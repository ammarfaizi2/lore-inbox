Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbULPS6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbULPS6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbULPS5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:57:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47561 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261987AbULPS4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:56:52 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: davidm@hpl.hp.com
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
Date: Thu, 16 Dec 2004 10:56:12 -0800
User-Agent: KMail/1.7.1
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
References: <200412160850.20223.jbarnes@engr.sgi.com> <16833.55270.601527.754270@napali.hpl.hp.com>
In-Reply-To: <16833.55270.601527.754270@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412161056.13019.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 16, 2004 10:45 am, David Mosberger wrote:
> >>>>> On Thu, 16 Dec 2004 08:50:19 -0800, Jesse Barnes
> >>>>> <jbarnes@engr.sgi.com> said:
>
>   Jesse> +int ia64_pci_legacy_read(struct pci_dev *dev, u16 port, u32 *val,
> u8 size) Jesse> +{
>   Jesse> + int ret = 0;
>   Jesse>         :
>   Jesse> + case 1:
>   Jesse> +  addr = (unsigned long *)paddr;
>   Jesse> +  *val = (u8)(*(volatile u8 *)(addr));
>   Jesse> +  break;
>   Jesse> + case 2:
>   Jesse> +  addr = (unsigned long *)paddr;
>   Jesse> +  *val = (u16)(*(volatile u16 *)(addr));
>   Jesse> +  break;
>   Jesse>          :
>   Jesse> +}
>
>   Jesse> +int ia64_pci_legacy_write(struct pci_dev *dev, u16 port, u32 val,
> u8 size) Jesse> +{
>   Jesse> + switch (size) {
>   Jesse> + case 1:
>   Jesse> +  addr = (unsigned long *)paddr;
>   Jesse> +  *(volatile u8 *)(addr) = (u8)(val);
>   Jesse> +  break;
>   Jesse> + case 2:
>   Jesse> +  addr = (unsigned long *)paddr;
>   Jesse> +  *(volatile u16 *)(addr) = (u16)(val);
>   Jesse> +  break;
>   Jesse>           :
>   Jesse> + }
>
> No offense, but what's up with this castamania?

Leftovers from other code.  I don't actually use this stuff on sn2, someone 
with a DIG test box will have to verify it (willy pointed out that I should 
probably just be using the appropriate inX our outX routine here instead, 
which makes sense).

Jesse
