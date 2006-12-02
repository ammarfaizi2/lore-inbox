Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422737AbWLBLXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWLBLXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162965AbWLBLXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:23:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31666 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1162418AbWLBLXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:23:15 -0500
Date: Sat, 2 Dec 2006 11:30:24 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: git-commits-head@vger.kernel.org
Subject: Re: PCI: Let PCI_MULTITHREAD_PROBE not be broken
Message-ID: <20061202113024.79e3330f@localhost.localdomain>
In-Reply-To: <200612020059.kB20xi2b003537@hera.kernel.org>
References: <200612020059.kB20xi2b003537@hera.kernel.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 00:59:44 GMT
Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
> @@ -19,7 +19,7 @@ config PCI_MSI
>  
>  config PCI_MULTITHREAD_PROBE
>  	bool "PCI Multi-threaded probe (EXPERIMENTAL)"
> -	depends on PCI && EXPERIMENTAL && BROKEN
> +	depends on PCI && EXPERIMENTAL
>  	help

NAK. 

It is broken as it breaks init time ordering relied upon by many
drivers for same probing and it breaks existing drive assumptions that
the probe is single threaded and therefore unlocked.

At the very least it needs

	&& !IDE && !WATCHDOG && !ATA

and probably far more.

This should not be enabled or even in the upstream tree until the
ordering problem is fixed and the submitter has done a review and fix of
all the locking.

Alan

