Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTEJLRf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 07:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTEJLRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 07:17:34 -0400
Received: from rth.ninka.net ([216.101.162.244]:41359 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263742AbTEJLRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 07:17:34 -0400
Subject: Re: qla1280 mem-mapped I/O fix
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
References: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052566211.22636.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2003 04:30:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-10 at 02:51, David Mosberger wrote:
> With the fix in the second hunk, I don't see any reason not to turn on
> MEMORY_MAPPED_IO in qla1280.  It seems to work fine on my machine
> with this controller (ia64 Big Sur).

David, you absolute MAY NOT pass this:

> -	pci_read_config_word (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
> +	pci_read_config_dword (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);

into ioremap() which is exactly what this driver is doing.
One must use the PCI device struct resource values.

-- 
David S. Miller <davem@redhat.com>
