Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWHTS5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWHTS5J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWHTS5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:57:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:17827 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751146AbWHTS5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:57:08 -0400
Message-ID: <44E8B05A.1090105@us.ibm.com>
Date: Sun, 20 Aug 2006 13:56:26 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Eric Sesterhenn <snakebyte@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Signedness issue in drivers/scsi/ipr.c
References: <1156014835.19657.3.camel@alice>
In-Reply-To: <1156014835.19657.3.camel@alice>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn wrote:
> hi,
> 
> gcc 4.1 with some extra warnings show the following:
> 
> drivers/scsi/ipr.c:6361: warning: comparison of unsigned expression < 0 is always false
> drivers/scsi/ipr.c:6385: warning: comparison of unsigned expression < 0 is always false
> drivers/scsi/ipr.c:6415: warning: comparison of unsigned expression < 0 is always false

Acked-by: Brian King <brking@us.ibm.com>

> 
> The problem is that rc is of the type u32, which can never be smaller than zero,
> therefore all three error handling checks get useless. This patch changes it to
> a normal int, because all usages / all functions it get used with expect an int.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.18-rc4/drivers/scsi/ipr.c.orig	2006-08-19 21:10:18.000000000 +0200
> +++ linux-2.6.18-rc4/drivers/scsi/ipr.c	2006-08-19 21:10:25.000000000 +0200
> @@ -6324,7 +6324,7 @@ static int __devinit ipr_probe_ioa(struc
>  	struct Scsi_Host *host;
>  	unsigned long ipr_regs_pci;
>  	void __iomem *ipr_regs;
> -	u32 rc = PCIBIOS_SUCCESSFUL;
> +	int rc = PCIBIOS_SUCCESSFUL;
>  	volatile u32 mask, uproc;
>  
>  	ENTER;
> 
> 

