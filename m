Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUFTQ4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUFTQ4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 12:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUFTQ4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 12:56:46 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:19906 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264705AbUFTQ4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 12:56:34 -0400
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <m34qp7glsp.fsf@defiant.pm.waw.pl>
References: <1087481331.2210.27.camel@mulgrave>
	<m33c4tsnex.fsf@defiant.pm.waw.pl> <1087523134.2210.97.camel@mulgrave>
	<m3fz8s79dz.fsf@defiant.pm.waw.pl> <1087657251.2162.49.camel@mulgrave> 
	<m34qp7glsp.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Jun 2004 11:56:26 -0500
Message-Id: <1087750590.11000.87.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 18:39, Krzysztof Halasa wrote:
> The problem is that (depending on platform) the pci_map_* and dma_map_*
> functions ignore both masks. An example of such platform is i386 :-)
> 
> It seems the masks are used on i386 for only one thing - consistent
> dma mask is used for consistent allocations only, and normal dma mask
> is not used at all.

Actually, I think you misunderstand the way the API works.  The only
time the dma_map_ functions pay attention to the mask is in an IOMMU
transaction.  For no-IOMMU systems, its far more efficient for bouncing
to occur in the upper layers (as it does for block and net).

> The normal mask is used mainly on 64-bit platforms and the meaningful
> values are 2^32-1 and 2^64-1. It's used by PCI-X device drivers to
> enable DAC transfers. This is why it isn't used on 32-bit platforms.

This statement is incorrect, Russell has already given you a counter
example.

James

