Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTJNUEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTJNUEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:04:00 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:9206 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262789AbTJNUD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:03:56 -0400
Message-ID: <3F8C56B3.1080504@opensound.com>
Date: Tue, 14 Oct 2003 13:04:03 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
Subject: Re: mouse driver bug in 2.6.0-test7?
References: <3F8C3A99.6020106@opensound.com> <1066159113.12171.4.camel@tux.rsn.bth.se> <20031014193847.GA9112@ucw.cz>
In-Reply-To: <20031014193847.GA9112@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Oct 14, 2003 at 09:18:34PM +0200, Martin Josefsson wrote:
> 
>>On Tue, 2003-10-14 at 20:04, 4Front Technologies wrote:
>>
>>>Why is the PS2 mouse tracking about 2x faster in 2.6.0-test7 compared
>>>to 2.4.xx?. Has anybody else seen this problem?.
>>>
>>>If I move the mouse 1 inch horizontally left-to-right on the mouse
>>>pad, the cursor on the screen moves almost twice the distance on the
>>>screen compared to Linux 2.4.xx
>>
>>It's probably mostly because Vojtech changed the samplerate from 200 to
>>60. Here's a patch to change it back. I've sent it to Vojtech but he's
>>completely ignored it so far. This patch also readds the fallback logic
>>that was used before his change, although it uses the new
>>samplerate-table.
>>
>>Without this patch my mouse is awful to use.
>>Vojtech, please consider this patch, at least say yay or nay.
> 
> 
> Patch considered. I'll up the samplerate default to 80, but not more,
> since samplerates above that cause trouble for a lot of people (keyboard
> doesn't work when you're moving the mouse).
> 
> The "set lower rate in case ..." part of the patch doesn't make sense.
> If the user gives a too low (less than 10) samples per second, then the
> original code will try to set 0, which is stupid, but harmless. The
> added code will try to access beyond the bounds of the rates[] array.


Hi Martin/Vojtech,

Martin, many thanks for your fix - it works perfectly now.

Oddly enough the sample rate of 200 seems to have fixed the problem.
Vojetech,  Martin's fixes are fully functional. If you want to keep it at 80,
I'd recommend that you make the sample rate a module config option so that
users may be able to tweak this for their systems.

The default of 200 has been tested on VIA400 and IntelICH5 systems that I have.
One running Redhat9/2.6.0-test7 and the other running Gentoo 1.4/2.6.0-test7



best regards

Dev Mazumdar
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

