Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVJPIZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVJPIZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 04:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVJPIZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 04:25:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53197 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751310AbVJPIZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 04:25:28 -0400
Subject: Re: PATCH: EDAC, core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1129403217.17923.22.camel@localhost.localdomain>
References: <1129403217.17923.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 16 Oct 2005 10:25:24 +0200
Message-Id: <1129451124.2911.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +static ctl_table mc_table[] = {
> +	{-1, "panic_on_ue", &panic_on_ue,
> +	 sizeof(int), 0644, NULL, proc_dointvec},
> +	{-2, "log_ue", &log_ue,
> +	 sizeof(int), 0644, NULL, proc_dointvec},
> +	{-3, "log_ce", &log_ce,
> +	 sizeof(int), 0644, NULL, proc_dointvec},
> +	{-4, "poll_msec", &poll_msec,
> +	 sizeof(int), 0644, NULL, proc_dointvec},
> +	{-7, "panic_on_pci_parity", &panic_on_pci_parity,
> +	 sizeof(int), 0644, NULL, proc_dointvec},
> +	{-8, "check_pci_parity", &check_pci_parity,
> +	 sizeof(int), 0644, NULL, proc_dointvec},
> +#ifdef CONFIG_EDAC_DEBUG
> +	{-9, "debug_level", &edac_debug_level,
> +	 sizeof(int), 0644, NULL, proc_dointvec},
> +#endif
> +	{0}
> +};

why aren't these module parameters? Nowadays you can have sysfs-runtime
changable module parameters... sounds a lot nicer than adding a chunk of
sysctl stuff

> +
> +#ifdef CONFIG_PROC_FS
> +static const char *mem_types[] = {
> +	[MEM_EMPTY] = "Empty",
> +	[MEM_RESERVED] = "Reserved",
> +	[MEM_UNKNOWN] = "Unknown",
> +	[MEM_FPM] = "FPM",
> +	[MEM_EDO] = "EDO",
> +	[MEM_BEDO] = "BEDO",
> +	[MEM_SDR] = "Unbuffered-SDR",
> +	[MEM_RDR] = "Registered-SDR",
> +	[MEM_DDR] = "Unbuffered-DDR",
> +	[MEM_RDDR] = "Registered-DDR",
> +	[MEM_RMBS] = "RMBS"
> +};


why proc? Again this sounds like a platform sysfs thing...



