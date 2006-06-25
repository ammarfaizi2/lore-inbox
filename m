Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWFYKzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWFYKzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWFYKzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:55:17 -0400
Received: from mail.charite.de ([160.45.207.131]:22440 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932343AbWFYKzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:55:15 -0400
Date: Sun, 25 Jun 2006 12:55:12 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Problem with 2.6.17-mm2
Message-ID: <20060625105512.GZ27143@charite.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
References: <20060625103523.GY27143@charite.de> <20060625034913.315755ae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060625034913.315755ae.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
> On Sun, 25 Jun 2006 12:35:23 +0200
> Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:
> 
> > 2.6.17 and 2.6.17.1 work OK, but using -mm2 gives me two oddieties:
> 
> OK, thanks.
> 
> > 1) A lot of "unexpected IRQ trap at vector X" for X=[09,07]
> 
> hm, ack_bad_irq().  That isn't supposed to happen.

Yet the box seems to work ok.
 
> Ingo, Thomas - it's possible that -mm2's genirq is affecting x86?
> 
> > 2) A problem with the powernow_k8 driver, which makes the kernel puke upon modprobe (at the end of my dmes output).
> 
> yup, I uploaded the below for for that into the hot-fixes directory.
> 
> --- a/drivers/cpufreq/cpufreq.c~cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only-fix-fix
> +++ a/drivers/cpufreq/cpufreq.c
> @@ -1551,7 +1551,7 @@ static struct notifier_block __cpuinitda
>   * (and isn't unregistered in the meantime).
>   *
>   */
> -int __cpuinit cpufreq_register_driver(struct cpufreq_driver *driver_data)
> +int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  {
>  	unsigned long flags;
>  	int ret;

I will try it immediately and report back. Thanks for the swift
response!

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
