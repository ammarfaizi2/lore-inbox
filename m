Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbTKDJsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbTKDJsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:48:14 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:40065 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264033AbTKDJsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:48:13 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
References: <1067885332.2076.13.camel@mulgrave>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 04 Nov 2003 04:48:10 -0500
In-Reply-To: <1067885332.2076.13.camel@mulgrave>
Message-ID: <yq0znfcjwh1.fsf@trained-monkey.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Bottomley <James.Bottomley@steeleye.com> writes:

James> Erm, I don't think so.  pci_map_single() covers a different use
James> case from pci_map_page().

James> The thing pci_map_single() can do that pci_map_page() can't is
James> cope with contiguous regions greater than PAGE_SIZE in length
James> (which you get either from kmalloc() or __get_free_pages()).
James> This feature is used in the SCSI layer for instance.

The question is whether that should be allowed in the first place. Some
IOMMU's will have to map it page-by-page anyway. However if it is to
remain a valid use then I don't see why pci_map_page() shouldn't be
able to handle it under the same conditions by passing it a
size > PAGE_SIZE.

Cheers,
Jes


