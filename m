Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316092AbSEJTl5>; Fri, 10 May 2002 15:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316093AbSEJTl4>; Fri, 10 May 2002 15:41:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16138 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316092AbSEJTl4>; Fri, 10 May 2002 15:41:56 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: x86 question: Can a process have > 3GB memory?
Date: Fri, 10 May 2002 19:41:44 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <abh7po$dph$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.3.96.1020510145244.14035A-100000@gatekeeper.tmr.com> <E176GHv-0006ee-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1021059704 25415 127.0.0.1 (10 May 2002 19:41:44 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 May 2002 19:41:44 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E176GHv-0006ee-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> kernel. It would be possible to allow program access to this RAM, although
>> both Kernel and gcc support would be needed. M$ had "huge" memory models
>> to go over 64k in the old 8086 days, doing loads of segment registers.
>
>Alas that is not quite the case. You still have a 4Gb virtual address
>space. If you want > 32bits, get a > 32bit processor. This one isnt as
>simple as add segmentation and 'large model'

Well, you _could_ use the P bit on the segments and "page" them in on
demand with mmap. That would get you a model very similar to the old
16-big large model: no single object can be bigger than 2GB, but you can
have a total object size of something like 40 bits.

No kernel support needed, actually. It's all there with the LDT stuff.

But yes, compiler support and a recompiled glibc. And it would break all
programs that assume a flat address space.

And it would really _suck_ performance-wise if your working set is big
enough to cause you to have to switch mmap's a lot.

			Linus
