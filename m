Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWGLOD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWGLOD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWGLOD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:03:29 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:23561 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751376AbWGLOD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:03:29 -0400
Date: Wed, 12 Jul 2006 16:03:28 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: PATCH: Fix Jmicron support
Message-ID: <20060712140328.GA96059@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <1152713141.22943.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152713141.22943.67.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 03:05:41PM +0100, Alan Cox wrote:
> + *	If we are using libata we can drive this chip proeprly but must
> + *	do this early on to make the additional device appear during
> + *	the PCI scanning.

"properly"


> +static void __devinit quirk_jmicron_dualfn(struct pci_dev *pdev)
> +{
> +	u32 conf;
> +	u8 hdr;
> +
> +	/* Only poke fn 0 */	
> +	if (PCI_FUNC(pdev->devfn))
> +		return;
> +		
> +	switch(pdev->device) {
> +		case PCI_DEVICE_ID_JMICRON_JMB365:
> +		case PCI_DEVICE_ID_JMICRON_JMB366:
> +			/* Redirect IDE second PATA port to the right spot */
> +			pci_read_config_dword(pdev, 0x80, &conf);
> +			conf |= (1 << 24);
> +			/* Fall through */
> +			pci_write_config_dword(pdev, 0x80, conf);
> +		case PCI_DEVICE_ID_JMICRON_JMB361:
> +		case PCI_DEVICE_ID_JMICRON_JMB363:

Wouldn't you want to put the fall throught comment after the
pci_write?  Took me a moment to parse it given its position

  OG.
