Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSJUM0t>; Mon, 21 Oct 2002 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbSJUM0t>; Mon, 21 Oct 2002 08:26:49 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:4276 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261354AbSJUM0r>; Mon, 21 Oct 2002 08:26:47 -0400
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000E6ADE5B@fmsmsx103.fm.intel.com>
References: <F2DBA543B89AD51184B600508B68D4000E6ADE5B@fmsmsx103.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 13:48:25 +0100
Message-Id: <1035204505.27318.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-19 at 00:48, Nakajima, Jun wrote:
> -/* Enable FXSR and company _before_ testing for FP problems. */
> -       /*
> -        * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
> -        */
> -       if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
> -               extern void __buggy_fxsr_alignment(void);
> -               __buggy_fxsr_alignment();
> -       }
>         if (cpu_has_fxsr) {
>                 printk(KERN_INFO "Enabling fast FPU save and restore... ");

So you back out a test that is pretty much essential to catch misaligned
stuff if we do get something wrong in our alignments or due to compiler
suprises and hope it doesnt happen ?

This isnt "fixing" this is the mad axeman at work. Linus this patch
should not go in as it is


