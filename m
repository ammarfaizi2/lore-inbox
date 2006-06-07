Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWFGOLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWFGOLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWFGOLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:11:07 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:63703 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932103AbWFGOLF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:11:05 -0400
To: Adhiraj <adhiraj@linsyssoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_map_single() on IA64
References: <1149671049.3499.27.camel@triumph>
From: Jes Sorensen <jes@sgi.com>
Date: 07 Jun 2006 10:11:03 -0400
In-Reply-To: <1149671049.3499.27.camel@triumph>
Message-ID: <yq0ejy1rr7s.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adhiraj" == Adhiraj  <adhiraj@linsyssoft.com> writes:

Adhiraj> Hi all, How is it possible that on an IA64 machine, the
Adhiraj> address returned by pci_map_single() is above 4G (32 bits)
Adhiraj> when I have only 2G of physical memory?

Depends on how the physical memory is located on the system and how
the PCI bridge sees it.

Adhiraj> The DMA mask is set to 64 bits (using
Adhiraj> pci_set_dma_mask()). When I change it to 32 bit DMA mask, the
Adhiraj> problem goes away.

Forcing it to a 32 bit mask may force the box to use the IOMMU if it
has one, which not all IA64 systems do have. However, since you have
set the DMA mask to 64 bits then you're getting exactly what you are
asking for, so why is this a 'problem'? A 64 bit DMA mask means the
adapter can do 64 bit addressing, it has nothing to do with the width
of the databus.

Jes

