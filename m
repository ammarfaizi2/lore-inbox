Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319203AbSHNElM>; Wed, 14 Aug 2002 00:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319204AbSHNElL>; Wed, 14 Aug 2002 00:41:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:531 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319203AbSHNElK>; Wed, 14 Aug 2002 00:41:10 -0400
Message-ID: <3D59E035.3080506@zytor.com>
Date: Tue, 13 Aug 2002 21:44:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Alexander Viro <viro@math.psu.edu>,
       Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
References: <Pine.LNX.4.44.0208132142310.1208-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Wed, 14 Aug 2002, Benjamin LaHaise wrote:
> 
>>/dev/kmsg was another suggestion for the name.  But please revert the 
>>yet-another-syscall variant -- having a duplicate way for logging that 
>>doesn't work with stdio just seems sick to me (sys_syslog should die).
> 
> 
> Actually, anybody who uses stdio on syslog messages should be roasted. 
> Over the nice romantic glow of red-hot coal, slowly cooking the stupid git 
> alive.
> 
> It's not a bug, it's a feature. A syslog message needs to be atomic, which 
> means that it MUST NOT use the buffering of stdio. 
> 

You can do stdio nonbuffered.  As a matter of fact, if you're using 
klogd, it *will* be nonbuffered :^)

The point that Ben is making is that it should be a write() system call 
instead of something ad hockish, and I think I have to agree with him -- 
although, again, Andrew's patch does what I need.

	-hpa


