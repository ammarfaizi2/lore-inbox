Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265343AbUFVStX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUFVStX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265286AbUFVSiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:38:46 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:42320 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265343AbUFVSgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:36:35 -0400
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Question on using MSI in PCI driver
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E5024057E5196@orsmsx404.amr.corp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 11:26:44 -0700
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024057E5196@orsmsx404.amr.corp.intel.com> (Tom
 L. Nguyen's message of "Tue, 22 Jun 2004 11:08:04 -0700")
Message-ID: <524qp3o3dn.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 18:26:44.0944 (UTC) FILETIME=[78D71500:01C45886]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> What do you think of "Failure to request the MMIO address
    Tom> space of the MSI-X PBA"?  Or what name do you suggest?

Unless I'm misunderstanding the code, nothing is failing, and it's not
the PBA being mapped.  You're ioremapping the the MSI-X vector table
so that the msi core can write vector values, etc.  So I would suggest
using a name of "MSI-X vector table" in the call to
request_mem_region.  (Remember that this name will be displayed in
/proc/iomem, and I don't think it makes sense to display "MSI-X iomap
Failure" to the user when MSI-X is set up and working).

 - Roland
