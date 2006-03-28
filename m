Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWC1Rwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWC1Rwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWC1Rwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:52:32 -0500
Received: from main.gmane.org ([80.91.229.2]:41435 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932094AbWC1Rwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:52:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: compile error when building multiple EHCI host controllers as modules
Date: Tue, 28 Mar 2006 19:51:55 +0200
Message-ID: <pan.2006.03.28.17.51.53.450352@free.fr>
References: <97434D6A-A556-4288-8F13-7048E416E611@kernel.crashing.org> <Pine.LNX.4.44.0603241429220.19557-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Fri, 24 Mar 2006 14:32:57 -0600, Kumar Gala a écrit :


> +
> +static int __init ehci_hcd_init(void)
> +{
> +	int retval = 0;
> +
> +	pr_debug("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
> +		 hcd_name,
> +		 sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
> +		 sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
> +
> +#ifdef CONFIG_PPC_83xx
> +	retval = platform_driver_register(&ehci_fsl_dr_driver);
> +	if (retval < 0)
> +		return retval;
This is wrong as the first driver could failed but the following one could
be correct : imagine generic kernel were multiple config options are
enabled.
On some board we could have only one controller, on other both.

> +	retval = platform_driver_register(&ehci_fsl_dr_driver);
> +	if (retval < 0)
> +		return retval;
> +#endif
We should unregister all the previous drivers if we fail.

Matthieu

