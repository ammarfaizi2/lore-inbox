Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbULLVNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbULLVNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbULLVNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:13:34 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:11149 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S262130AbULLVNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:13:16 -0500
Message-ID: <41BCB420.1080307@hackish.org>
Date: Sun, 12 Dec 2004 16:12:00 -0500
From: Peter Nelson <rufus-kernel@hackish.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041120)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Piel <Eric.Piel@tremplin-utc.net>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       decklin@red-bean.com
Subject: Re: [PATCH] Hotplug support for several PSX controlers
References: <41BCA915.3030407@tremplin-utc.net>
In-Reply-To: <41BCA915.3030407@tremplin-utc.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Piel wrote:

> Since 2.6.9, several PSX controlers in the same time can be supported. 
> However, because of a bug, if not all the PSX controlers are pluged in 
> then nothing works. Typically, you load gamecon with options saying 
> that you have two PSX adapter ports and then you plug and unplug has 
> many controllers has you want. There is a bug which prevent keypress 
> to be detected when not all the controllers connected.

As I added to the documentation "hot swapping should work (but is not 
recomended)."  This might make it a bit more likely to work, but still 
"not recomended."

> The problem was that when a port didn't have a controler pluged the 
> packet length to receive was read as very big, leading to a kind of 
> buffer overflow. This patch checks the packet length and if it is 
> bigger than the theoritical possible it considers that there is no 
> controller pluged on this port.

This seems like a reasonable explination when ports float if 
unconnected.  Your patch does almost the right thing.  First 
gc_psx_command should take a data[5] argument, that was a logic error on 
my part.  Second, you compare the calculated length to PSX_LENGTH, which 
is just saying we read in bytes.  It should check <= 6, which is the 
longest string of packets possible (buttons, buttons, right, right, 
left, left, see 
<http://www.gamesx.com/controldata/psxcont/psxcont.htm>).  Changing to 
compare to 6 makes the patch look good to me.

> It probably works on a vanilla 2.6.10-rc3 but I highly recommand to 
> use the Vojtech's tree which contains an important fix about PSX DDR 
> (cf http://marc.theaimsgroup.com/?l=linux-kernel&m=110118014804716&w=2).

Vojtech already accepted my almost-identical patch when I noticed this 
in September.  See
http://marc.theaimsgroup.com/?l=linux-kernel&m=109571247127456&w=4

> I've heard that Linus wants 2.6.10 ready for Christmas, this patch 
> should definitetly helps ;-)

I'm all for both my previous patch and this one making it into 2.6.10 =)

-Peter

