Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUFZI10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUFZI10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 04:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266889AbUFZI1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 04:27:25 -0400
Received: from [213.146.154.40] ([213.146.154.40]:21700 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266334AbUFZI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 04:27:24 -0400
Date: Sat, 26 Jun 2004 09:27:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <roland@topspin.com>
Cc: long <tlnguyen@snoqualmie.dp.intel.com>, linux-kernel@vger.kernel.org,
       ak@muc.de, akpm@osdl.org, greg@kroah.com, jgazik@pobox.com,
       tom.l.nguyen@intel.com, zwane@linuxpower.ca
Subject: Re: [PATCH]2.6.7 MSI-X Update
Message-ID: <20040626082713.GA11693@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <roland@topspin.com>,
	long <tlnguyen@snoqualmie.dp.intel.com>,
	linux-kernel@vger.kernel.org, ak@muc.de, akpm@osdl.org,
	greg@kroah.com, jgazik@pobox.com, tom.l.nguyen@intel.com,
	zwane@linuxpower.ca
References: <200406260121.i5Q1LwK0005068@snoqualmie.dp.intel.com> <52n02r14ki.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52n02r14ki.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 06:38:37PM -0700, Roland Dreier wrote:
> I like this new MSI patch much better since it has pci_disable_msi()
> and pci_disable_msix() (as well as using pci_read_config_xxx instead
> of bus ops), but I still feel the API is not quite right.  I don't
> think the pci_disable_msi() and pci_disable_msix() functions should
> only be for error paths; I think that they should always be used to
> undo the effect of pci_enable_msi() or pci_enable_msix() when a driver
> is unloading, and that request()/free_irq() should not have any effect
> on a device's MSI state.

Agreed.  Non-symmetric APIs are very bad.

> As a concrete example, the e1000 net driver does request_irq() in its
> e1000_up() function and free_irq() in its e1000_down() function.
> Basically, the driver will do request_irq() when the user does
> "ifconfig up" and free_irq() when the user does "ifconfig down".

Lots of networking drivers do that..

