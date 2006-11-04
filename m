Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965568AbWKDRgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965568AbWKDRgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965569AbWKDRgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:36:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21225 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965568AbWKDRgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:36:51 -0500
Subject: Re: [PATCH 2/2] Workaround for SB600 SATA ODD issue
From: Arjan van de Ven <arjan@infradead.org>
To: Luugi Marsan <luugi.marsan@amd.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061103190004.9ED8DCBD48@localhost.localdomain>
References: <20061103190004.9ED8DCBD48@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 04 Nov 2006 18:36:49 +0100
Message-Id: <1162661809.3160.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 14:00 -0500, Luugi Marsan wrote:
> From: conke.hu@amd.com
> 
> There was an ASIC bug in the SB600 SATA controller of low revision (<=13) and CD burning may hang (only SATA ODD has this issue, and SATA HDD works well). The patch provides a workaround for this issue.
> 
> Signed-off-by:  Luugi Marsan <luugi.marsan@amd.com>
> 
> --- linux-2.6.19-rc4-git5/drivers/ata/ahci.c.orig       2006-11-04 03:56:22.000000000 +0800
> +++ linux-2.6.19-rc4-git5/drivers/ata/ahci.c    2006-11-04 04:20:36.000000000 +0800
> @@ -189,6 +189,7 @@ struct ahci_host_priv {
>         unsigned long           flags;
>         u32                     cap;    /* cache of HOST_CAP register */
>         u32                     port_map; /* cache of HOST_PORTS_IMPL reg */
> +       u8                      rev;    /* PCI Revision ID */
>  };
>  

why put this into the ahci struct rather than in the pci device struct?
In the place you use it you already have the pci device struct already..
and it's really a pci device property so putting it in that struct makes
a whole lot of sense conceptually anyway...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

