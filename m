Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVJDOZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVJDOZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVJDOZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:25:35 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:24756 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932482AbVJDOZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:25:35 -0400
Date: Tue, 4 Oct 2005 10:25:10 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051004130009.GB31466@elte.hu>
Message-ID: <Pine.LNX.4.58.0510041007100.13294@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
 <20051004130009.GB31466@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also the inclusion of ktimer (I believe) has made a dependency with
mpparse and IO_APIC.  Since now mpparse.c calls setup_IO_APIC_early which
is defined only if X86_IO_APIC is, the kernel wont link without.
So, is the following patch sufficient? Or does mpparse.c need to be
different, that is should we not call setup_IO_APIC_early if X86_IO_APIC
is not set?

I haven't looked too deep into this, and wont until -rt6 gets fixed.
Better yet, Thomas is probably better at looking into this.

-- Steve

--- linux-2.6.14-rc3-rt6/arch/i386/Kconfig.debug.orig	2005-10-04 10:05:19.000000000 -0400
+++ linux-2.6.14-rc3-rt6/arch/i386/Kconfig.debug	2005-10-04 10:06:02.000000000 -0400
@@ -71,7 +71,7 @@ config X86_FIND_SMP_CONFIG

 config X86_MPPARSE
 	bool
-	depends on X86_LOCAL_APIC && !X86_VISWS
+	depends on X86_LOCAL_APIC && X86_IO_APIC && !X86_VISWS
 	default y

 endmenu

