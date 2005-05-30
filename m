Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVE3Jky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVE3Jky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVE3Jkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:40:53 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:41443 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261582AbVE3JkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:40:07 -0400
X-Envelope-From: kraxel@suse.de
To: linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
References: <4297746C.10900@ammasso.com>
From: Gerd Knorr <kraxel@suse.de>
Organization: SUSE Labs, Berlin
Date: 30 May 2005 11:38:32 +0200
In-Reply-To: <4297746C.10900@ammasso.com>
Message-ID: <873bs5yrxj.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> writes:

> Also, does the pgd/pmd/pte page-table walking work on addresses
> returned by kmalloc(), or do I have to use __pa() to get the physical
> address?

You should use vmalloc_to_page() (this does the page-table walking
with correct locking), then the usual dma mapping interface
(pci_map_page() or pci_map_sg()) to get bus address(es) you can pass
to your device for DMA.

  Gerd

