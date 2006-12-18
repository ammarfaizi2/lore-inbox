Return-Path: <linux-kernel-owner+w=401wt.eu-S1753726AbWLRK2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbWLRK2J (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbWLRK2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:28:09 -0500
Received: from galaxy.systems.pipex.net ([62.241.162.31]:57631 "EHLO
	galaxy.systems.pipex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbWLRK2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:28:08 -0500
X-Greylist: delayed 1385 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 05:28:08 EST
Date: Mon, 18 Dec 2006 10:04:39 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@ws.homenet
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] microcode: Fix mc_cpu_notifier section warning
In-Reply-To: <20061217173602.abaf4b69.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.61.0612180954380.3848@ws.homenet>
References: <20061217173602.abaf4b69.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

Ok, your patch is correct, although I assume you realize that it does 
nothing --- both the function and the data it operates on are inside 
CONFIG_HOTPLUG_CPU and checking include/linux/init.h I see that 
__cpuinitdata is nothing in this case. E.g. msr_class_cpu_notifier in the 
msr driver isn't declared __cpuinitdata...

But to tidy up one should add __cpuinitdata as you suggest (to guard for 
the case if these two slip out of CONFIG_HOTPLUG_CPU, although they are 
meaningless if cpu hotplug support is not configured in).

Kind regards
Tigran

On Sun, 17 Dec 2006, Jean Delvare wrote:

> Structure mc_cpu_notifier references a __cpuinit function, but
> isn't declared __cpuinitdata itself:
>
> WARNING: arch/i386/kernel/microcode.o - Section mismatch: reference
> to .init.text: from .data after 'mc_cpu_notifier' (at offset 0x118)
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> arch/i386/kernel/microcode.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-2.6.20-rc1.orig/arch/i386/kernel/microcode.c	2006-12-15 09:05:20.000000000 +0100
> +++ linux-2.6.20-rc1/arch/i386/kernel/microcode.c	2006-12-17 15:23:40.000000000 +0100
> @@ -722,7 +722,7 @@
> 	return NOTIFY_OK;
> }
>
> -static struct notifier_block mc_cpu_notifier = {
> +static struct notifier_block __cpuinitdata mc_cpu_notifier = {
> 	.notifier_call = mc_cpu_callback,
> };
>
>
>
> -- 
> Jean Delvare
>
