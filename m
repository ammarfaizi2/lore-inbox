Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSGEKin>; Fri, 5 Jul 2002 06:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316909AbSGEKim>; Fri, 5 Jul 2002 06:38:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37024 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316897AbSGEKil>; Fri, 5 Jul 2002 06:38:41 -0400
Date: Fri, 5 Jul 2002 10:40:49 +0100
From: Stephen Tweedie <sct@redhat.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Pavel Machek <pavel@ucw.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020705104049.H27198@redhat.com>
References: <20020702123718.A4711@redhat.com> <Pine.LNX.3.95.1020702075957.24872A-100000@chaos.analogic.com> <20020703034809.GI474@elf.ucw.cz> <20020703234750Z16173-11563+874@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020703234750Z16173-11563+874@humbolt.nl.linux.org>; from phillips@arcor.de on Thu, Jul 04, 2002 at 01:48:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 04, 2002 at 01:48:59AM +0200, Daniel Phillips
<phillips@arcor.de> wrote:

> Is it just the mod_dec_use_count; return/unload race we're worried about?  
> I'm not clear on why this is hard.  I'd think it would be sufficient just to 
> walk all runnable processes to ensure none has an execution address inside the
> module.

That fails if:

the module function has called somewhere else in the kernel (and
with -fomit-frame-pointer, you can't reliably walk back up the stack
to find out if there is a stack frame higher up the stack which is in
the module);

the module has taken an interrupt into an unrelated driver;

we have computed a call into the module but haven't actually executed
the call yet;

etc. 


> For smp, an ipi would pick up the current process on each cpu.

Without freezing the other CPUs, that still leaves the race wide open.

--Stephen
