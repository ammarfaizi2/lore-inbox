Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132863AbRDEMHO>; Thu, 5 Apr 2001 08:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132870AbRDEMHE>; Thu, 5 Apr 2001 08:07:04 -0400
Received: from [166.70.28.69] ([166.70.28.69]:3918 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132863AbRDEMGt>;
	Thu, 5 Apr 2001 08:06:49 -0400
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <Pine.LNX.4.31.0104041956240.1580-100000@linux.local>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2001 06:03:01 -0600
In-Reply-To: James Simmons's message of "Wed, 4 Apr 2001 20:04:04 -0700 (PDT)"
Message-ID: <m1bsqbwo3u.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@linux-fbdev.org> writes:

> >>> As long as you are copying in real memory. So the PCI bus or the host
> bridge
> >>> implementation may be the actual limit.
> >>
> >> The CyrixIII sits on the same host bridges as the intel processors
> >
> >I don't know if it applies to this case but one thing I have seen make
> >a noticeable difference is whether or not write-combining is enabled.
> >If we have only be enabling MTRR's for intel this could do account
> >for it.
> 
> I think what Geert was trying to point out is does MTRR perform was well
> with normal memory over bus to video memory transfers as compared to
> normal memory to normal memory transfers. MTTRs might not be optimzed for
> these kinds of transfers. I honestly can't say since I haven't tried it. I
> brought the MMX book home from works so I'm going to be experimenting
> with it this weekend to find out. I really like to compare the MMX
> performance to the word aligned transfers over the bus I have going. I had
> a bug in my soft accel code that prevented word alignment. Once I fixed
> that bug I seen a 10 fold improvement in rendering on the framebuffer.
> I'm not kidding about that improvement either :-)
> 
> MTTRs enabled always makes a difference. I liek to try it with and
> without. I will do some benchmarkings.

While I'm thinking about it what we really should be using is the PAT
extension and not MTRR's.  The PAT extension allows you to set the
attributes per page so you don't have the resource contention you do
with MTRR's.  I can just imagine the performance challenges right now
if you try to do a multi-head where multi > number of free MTRR's.

What happens with write-combining is active is that close adjacent
writes are batched together.  Without write-combining you tend to get
32bit writes on a bus with a word size of 64 or more bits.  By the way
does anyone know who didn't implement MTRR's or the equivalent on
alpha so we can shoot them?

Eric
