Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131585AbRBMOjL>; Tue, 13 Feb 2001 09:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131680AbRBMOjC>; Tue, 13 Feb 2001 09:39:02 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:45786 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S131585AbRBMOis>; Tue, 13 Feb 2001 09:38:48 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes
Message-ID: <3A8946EB.A053C868@fi.muni.cz>
Date: Tue, 13 Feb 2001 14:38:35 GMT
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <E14SfKk-0001kl-00@the-village.bc.nu>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1-RTL3.11b i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
 > Yeah I've seen this claim repeatedly. XFree 4.0.2 crashes for me in
similar
> ways on 3dfx and matrox cards and it happens with 2.2 kernels as well. What
> makes me suspicious its XFree triggered is that there isnt really anything
> XFree does that would trigger mm bugs on x86 platforms. It isnt threaded, it
> doesnt make extensive threaded use of mmap. But of course it does touch
> hardware directly, paticularly the AGPgart. That might be an obvious first
> candidate but having looked at it I see no problems.
> 
> > Anyone looking into this?
> 
> I believe it to be Xfree or glibc problems.  So I'm not. Since I can't get
> XFree 4 stable on 2.2 I dont have a useful setup to study this.

I'll try to repeat my problem here in the hope someone will notice this
and will help me.

The problem is with the usage of RTL & XFree86 4.0
In the old days of Xfree3.3.6 I've no problems at all. After upgrading
to XFree4.0
this problem has appeared:

RTL scheduler calls my module code and this randomly segfaults (usually
its in
spinlock and trace shows that it was looping in page_fault)
(this happen  with any rtl module)

This problem appears only IF my module has been loaded AFTER mga.o drm
kernel driver.
When I'm not using accelerated XFree (without kernel module) or I'm
preloading
my module before mga.o  (it even help to stop xfree, remove mga, load my
driver,
restart xfree) everything runs just fine.

As drm code is cooperating with AGP and DMA and I'm not skilled enough
to know about these
memory mapping problems I've no idea how could happen that my kernel
module code
is not present in the specified memory. As I've noticed drm contains
some code
for handling page fault exception however for RTL task its "a must" that
code has to
be present in memory.

I'm having couple of questins - is it correct when I assume than kernel
memory
including the memory used for kernel module drivers is unswapable and
will
always stay in the same physical place ?

Should I use PG_reserver or PG_locked for the pages I want that MMU
would not touch ?
Is it useful to increment counter in mem_map_t as it is done in the drm
driver ?

thanks

bye

-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

