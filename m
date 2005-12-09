Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVLILmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVLILmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVLILmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:42:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38868 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932203AbVLILmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:42:49 -0500
Date: Fri, 9 Dec 2005 11:42:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209114246.GB16945@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, randy_d_dunlap@linux.intel.com,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20051208030242.GA19923@srcf.ucam.org> <20051208091542.GA9538@infradead.org> <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <1134050498.17102.2.camel@localhost.localdomain> <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain> <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208171901.GA22451@srcf.ucam.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 05:19:01PM +0000, Matthew Garrett wrote:
> This turns out to be quite difficult, and I can't see a clean way of 
> doing it without touching scsi or rewriting chunks of the ACPI glue 
> code.
> 
> The basic flow of code required here is:
> 
> 1) scsi layer registers a new device
> 2) platform_notify is called, which is (in this case) 
> acpi_platform_notify
> 3) acpi_platform_notify checks whether it knows dev->bus. If so, it 
> calls appropriate callbacks.
> 
> Without touching scsi, there doesn't seem to be any way for (3) to work 
> if scsi is a module. Would a simple
> 
> #ifdef CONFIG_ACPI
> acpi_scsi_init(&scsi_bus_type)
> #endif
> 
> in the scsi code be acceptable? If not, then we have some difficulty. 
> The acpi glue code has to be statically linked in, so it can't rely on 
> anything that directly references the scsi code.

As a concept it's _much_ better.  Although it should be platform_scsi_init
and every architecture would provide an, in most cases noop, implementation.
