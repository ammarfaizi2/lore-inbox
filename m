Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWGLEpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWGLEpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 00:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWGLEpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 00:45:08 -0400
Received: from koto.vergenet.net ([210.128.90.7]:63447 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932419AbWGLEpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 00:45:06 -0400
Date: Wed, 12 Jul 2006 10:00:19 +0900
From: Horms <horms@verge.net.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH] i386 kexec:  Allow the kexec on panic support to compile on voyager.
Message-ID: <20060712010017.GC9591@verge.net.au>
References: <20060711123017.5F15A3403D@koto.vergenet.net> <m1ejwrgb2b.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejwrgb2b.fsf@ebiederm.dsl.xmission.com>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 02:07:24PM -0600, Eric W. Biederman wrote:
> Horms <horms@verge.net.au> writes:
> 
> > On Mon, 10 Jul 2006 16:37:49 -0600, Eric W. Biederman wrote:
> >> 
> >> This patch removes the foolish assumption that SMP implied local
> >> apics.  That assumption is not-true on the Voyager subarch.  This
> >> makes that dependency explicit, and allows the code to build.
> >
> > Doesn't only a small portion of the code in question rely
> > on CONFIG_X86_LOCAL_APIC? Is just a workaround until proper
> > voager support materialises?
> 
> Essentially, but it is correct for the code to stay this way.

Is it neccessary for local apic to be present for all the code in the 
ifdef to work? It seems to me that the register saving code
could be made to work without it.

> >> What gets disabled is just an optimization to get better crash
> >> dumps so the support should work if there is a kernel that will
> >> initialization on the voyager subarch under those harsh conditions.
> >
> > By that do you mean, a crash kernel that is able to boot even
> > though the non-crashing CPUs have not been shutdown?
> 
> I simply mean a crash kernel that is able to boot.

I was hoping for some more specific information than that.

> >> Hopefully we can figure out how to initialize apics in init_IRQ
> >> and remove the need to disable io_apics and this dependency.
> >
> > That does sound nice. Do you have any ideas on how that could be 
> > made to happen?
> 
> My patch for that got reverted because it wouldn't boot on Linus's
> SMP laptop.  It appeared to be some weird ACPI problem.  I didn't
> receive any bug reports otherwise.

Do you have a link to the patch, or a copy of it floating around?

ACPI is the root of many evils, particularly as its bahaviour seems
to effect many different systems, and it behaves differently on
different machines. Perhaps the code could be cleaned up a little
and incoporated into -mm. In my experience the best way to solve ACPI
problems is to expose the code to as much hardware as possible.

> So I suspect the steps are:
> 1) Unify SMP and non-SMP apic initialization so it is the exact same
>    code.
> 2) Move the unified code up in the boot sequence into init_IRQs.
> 
> It is something that needs to be done very delicately.

Yes undersandably so. Sounds quite tedious :(

-- 
Horms                                           
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

