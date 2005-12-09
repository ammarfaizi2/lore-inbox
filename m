Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVLILue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVLILue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVLILud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:50:33 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:43213 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750846AbVLILuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:50:32 -0500
Date: Fri, 9 Dec 2005 11:50:09 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209115009.GA25771@srcf.ucam.org>
References: <20051208091542.GA9538@infradead.org> <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <1134050498.17102.2.camel@localhost.localdomain> <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain> <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org> <20051209114246.GB16945@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209114246.GB16945@infradead.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 11:42:46AM +0000, Christoph Hellwig wrote:

> As a concept it's _much_ better.  Although it should be platform_scsi_init
> and every architecture would provide an, in most cases noop, implementation.

How about

if (platform_scsi_init)
	platform_scsi_init(&scsi_bus_type);

? This is similar to how the platform_notify callback code is handled. 
Making it per-arch isn't quite ideal, since x86 can be ACPI or APM and 
kernels need support for both. On the other hand, I can't think of any 
way that APM could do anything useful with the information, so per-arch 
may be reasonable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
