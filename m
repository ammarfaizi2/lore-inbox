Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUGJMBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUGJMBS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUGJMBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:01:18 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:43156 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266218AbUGJMBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:01:16 -0400
Message-ID: <40EFDA89.4020001@yahoo.com.au>
Date: Sat, 10 Jul 2004 22:01:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <fabian.frederick@skynet.be>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: autoregulation needed
References: <1089453053.3646.18.camel@localhost.localdomain>
In-Reply-To: <1089453053.3646.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:
> Hi,
> 
> 	I've been surprised these last days to read ar wasn't that interesting
> (!!!) so I did a slight bench :
> 
> http://fabian.unixtech.be/kernel/autoregulate/
> 
> Well, I hope we can have that pretty stuff in mainline.I'm bored
> patching it again and again.
> 
> If some persons could confirm GUI is relaxed with autoregulation (well
> its my case but I could use a box from Mars or smthg :) ).
> 

That is a good start.

I don't think we need to rush in changes here on the basis that
they improve a *really* thrashing workload, although obviously
that is interesting, and a definitely positive point.

I didn't see Con's newest autoswappiness patch do a great deal
for kbuild here. The inactivation thing seems to help more - it
appears to increase the rate of active list scanning, which is
consistient with the sort of behaviour I have seen. However, the
problem with increased active list scanning is that it can be
quicker to evict RSS over throwaway data which is bad.

Changes should be tested one at a time if possible, and when they
are determined to be an improvement, we should try to look into
what the "auto tuning" magic is doing right, and see if that can
be implemented in a simpler way (although it may be already as
simple as possible).
