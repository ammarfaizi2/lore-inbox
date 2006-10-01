Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWJARCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWJARCb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWJARCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:02:31 -0400
Received: from chen.mtu.ru ([195.34.34.232]:30724 "EHLO chen.mtu.ru")
	by vger.kernel.org with ESMTP id S1751263AbWJARCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:02:31 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [patch 1/2] libata: _GTF support
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       linux-kernel@vger.kernel.org
Date: Sun, 01 Oct 2006 21:02:21 +0400
References: <20060928182211.076258000@localhost.localdomain> <20060928112901.62ee8eba.kristen.c.accardi@intel.com>
User-Agent: KNode/0.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20061001170216.34F3F54C4EC@chen.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:

> _GTF is an acpi method that is used to reinitialize the drive.  It returns
> a task file containing ata commands that are sent back to the drive to
> restore it to boot up defaults.
> 
[...]
> @@ -1597,6 +1601,9 @@ int ata_bus_probe(struct ata_port *ap)
>  /* reset and determine device classes */
>  ap->ops->phy_reset(ap);
>  
> +     /* retrieve and execute the ATA task file of _GTF */
> +     ata_acpi_exec_tfs(ap);
> +
>  for (i = 0; i < ATA_MAX_DEVICES; i++) {
>  dev = &ap->device[i];
>

ata_bus_probe() seems to be called only if driver does not provide own error
handler? Also would GTF be executed on resume? I hoped it may fix resume
from RAM problem I have but it looks like this is never executed in my case
(pata_ali).

TIA

-andrey

