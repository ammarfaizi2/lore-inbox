Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319201AbSHNEjP>; Wed, 14 Aug 2002 00:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319202AbSHNEjP>; Wed, 14 Aug 2002 00:39:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56594 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319201AbSHNEjK>; Wed, 14 Aug 2002 00:39:10 -0400
Message-ID: <3D59DFBE.4020007@zytor.com>
Date: Tue, 13 Aug 2002 21:42:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@zip.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
References: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208132123500.1208-100000@home.transmeta.com> <20020814003505.A16322@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Aug 13, 2002 at 09:26:45PM -0700, Linus Torvalds wrote:
> 
>>That said, I like the notion. I've always hated the fact that all the 
>>boot-time messages get lost, simply because syslogd hadn't started, and 
>>as a result things like fsck ran without any sign afterwards. The kernel 
>>log approach saves it all in one place.
>>
>>But /dev/console just sounds potentially _too_ noisy.
> 
> 
> /dev/kmsg was another suggestion for the name.  But please revert the 
> yet-another-syscall variant -- having a duplicate way for logging that 
> doesn't work with stdio just seems sick to me (sys_syslog should die).
> Something like the following untested code is much better.
> 

a) /dev/kmsg bettwe be S_IRUSR|S_IWUSR... reading /{proc,dev}/kmsg 
should drain the ring buffer.

b) Hook up the /proc/kmsg read to this thing.

It really needs to be a /dev node, not a /proc node; procfs is likely 
*not* to be mounted; however, manifesting a /dev node is easy enough.

	-hpa


