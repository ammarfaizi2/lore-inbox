Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWGKTub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWGKTub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWGKTub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:50:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:8345 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932107AbWGKTua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:50:30 -0400
Date: Tue, 11 Jul 2006 21:45:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] irqtrace-option-off-compile-fix
Message-ID: <20060711194505.GA25611@elte.hu>
References: <1152577120.7654.9.camel@localhost.localdomain> <1152601989.3128.10.camel@laptopd505.fenrus.org> <1152635003.7654.40.camel@localhost.localdomain> <1152637993.3128.96.camel@laptopd505.fenrus.org> <1152635804.7654.44.camel@localhost.localdomain> <1152641141.3128.104.camel@laptopd505.fenrus.org> <1152644540.3578.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152644540.3578.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> > The one you want is CONFIG_TRACE_IRQFLAGS .. which is the one that 
> > actually turns the tracing on
> 
> I could not turn off CONFIG_TRACE_IRQFLAGS_SUPPORT in .config 
> directly. The command "scripts/kconfig/conf -s arch/x86_64/Kconfig" in 
> Makefile overwrites changes made to CONFIG_TRACE_IRQFLAGS_SUPPORT in 
> .config file.  So this is always turned on in .config if the option 
> TRACE_IRQFLAGS_SUPPORT is set in arch/x86_64/Kconfig.debug.  I may be 
> missing something.  Any suggestions?

correct, that flag is always set - it signals towards the core kernel 
that the architecture in question (x86_64) that it has trace-irqflags 
support. NOTE: this does not mean that irqflags tracing is turned on - 
that is another option: CONFIG_TRACE_IRQFLAGS.

unsetting the support flag makes no sense and will likely break the 
build. There is no overhead from irqflags tracing if it's turned off. 
(even if the CONFIG_TRACE_IRQFLAGS_SUPPORT option is set)

does this explain things? We could rename the boolean value to 
CONFIG_TRACE_IRQFLAGS_SUPPORT_AVAILABLE perhaps, to avoid future 
confusion.

	Ingo
