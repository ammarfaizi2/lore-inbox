Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWFFH2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWFFH2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFFH2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:28:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:1489 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750717AbWFFH2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:28:51 -0400
Date: Tue, 6 Jun 2006 09:26:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Laurent Riffard <laurent.riffard@free.fr>,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       jbeulich@novell.com, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060606072628.GA28752@elte.hu>
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com> <20060604181002.57ca89df.akpm@osdl.org> <44840838.7030802@free.fr> <4484584D.4070108@free.fr> <20060605110046.2a7db23f.akpm@osdl.org> <986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Barry K. Nathan <barryn@pobox.com> wrote:

> On 6/5/06, Andrew Morton <akpm@osdl.org> wrote:
> >I guess we should force 8k stacks if the lockdep features are enabled.
> 
> Also, Laurent is running "2.6.17-rc5-mm3-lockdep" (per his previous
> message), i.e., 2.6.17-rc5-mm3 with Ingo's lockdep-combo patch added.
> If you're wondering how I conclude the latter from the former, look at
> this hunk from the lockdep-combo patch:
> 
> --- linux.orig/Makefile
> +++ linux/Makefile
> @@ -1,7 +1,7 @@
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 17
> -EXTRAVERSION =-rc5-mm3
> +EXTRAVERSION =-rc5-mm3-lockdep
> NAME=Lordi Rules
> 
> And from the same patch:
> 
> --- linux.orig/arch/i386/Makefile
> +++ linux/arch/i386/Makefile
> @@ -38,6 +38,10 @@ CFLAGS += $(call cc-option,-mpreferred-s
> include $(srctree)/arch/i386/Makefile.cpu
> 
> cflags-$(CONFIG_REGPARM) += -mregparm=3
> +#
> +# Prevent tail-call optimizations, to get clearer backtraces:
> +#
> +cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls
> 
> # temporary until string.h is fixed
> cflags-y += -ffreestanding
> 
> I would expect that to increase stack usage...

yes, and -pg (the one that creates the mcount callbacks that drive the 
lockdep tracer) increases the stack footprint too. But these items are 
only in my combo patch and in the lockdep tracer, not in -mm.

	Ingo
