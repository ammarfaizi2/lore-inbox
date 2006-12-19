Return-Path: <linux-kernel-owner+w=401wt.eu-S932235AbWLSHd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWLSHd0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWLSHd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:33:26 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:3136 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932235AbWLSHd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:33:26 -0500
Date: Tue, 19 Dec 2006 08:33:28 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] microcode: Fix mc_cpu_notifier section warning
Message-Id: <20061219083328.5951571f.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0612180954380.3848@ws.homenet>
References: <20061217173602.abaf4b69.khali@linux-fr.org>
	<Pine.LNX.4.61.0612180954380.3848@ws.homenet>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tigran,

On Mon, 18 Dec 2006 10:04:39 +0000 (GMT), Tigran Aivazian wrote:
> Ok, your patch is correct, although I assume you realize that it does 
> nothing --- both the function and the data it operates on are inside 
> CONFIG_HOTPLUG_CPU and checking include/linux/init.h I see that 
> __cpuinitdata is nothing in this case. E.g. msr_class_cpu_notifier in the 
> msr driver isn't declared __cpuinitdata...

I don't see anything in arch/i386/kernel/microcode.c depending on
CONFIG_HOTPLUG_CPU (in 2.6.20-rc1), sorry.

> But to tidy up one should add __cpuinitdata as you suggest (to guard for 
> the case if these two slip out of CONFIG_HOTPLUG_CPU, although they are 
> meaningless if cpu hotplug support is not configured in).
> 
> Kind regards
> Tigran
> 
> On Sun, 17 Dec 2006, Jean Delvare wrote:
> 
> > Structure mc_cpu_notifier references a __cpuinit function, but
> > isn't declared __cpuinitdata itself:
> >
> > WARNING: arch/i386/kernel/microcode.o - Section mismatch: reference
> > to .init.text: from .data after 'mc_cpu_notifier' (at offset 0x118)
> >
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> > arch/i386/kernel/microcode.c |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-2.6.20-rc1.orig/arch/i386/kernel/microcode.c	2006-12-15 09:05:20.000000000 +0100
> > +++ linux-2.6.20-rc1/arch/i386/kernel/microcode.c	2006-12-17 15:23:40.000000000 +0100
> > @@ -722,7 +722,7 @@
> > 	return NOTIFY_OK;
> > }
> >
> > -static struct notifier_block mc_cpu_notifier = {
> > +static struct notifier_block __cpuinitdata mc_cpu_notifier = {
> > 	.notifier_call = mc_cpu_callback,
> > };

-- 
Jean Delvare
