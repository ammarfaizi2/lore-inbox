Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbULDWAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbULDWAS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbULDWAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:00:18 -0500
Received: from peabody.ximian.com ([130.57.169.10]:46988 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261176AbULDWAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:00:03 -0500
Subject: Re: [PATCH] aic7xxx large integer
From: Robert Love <rml@novell.com>
To: Miguel Angel Flores <maf@sombragris.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41B222BE.9020205@sombragris.com>
References: <41B222BE.9020205@sombragris.com>
Content-Type: text/plain
Date: Sat, 04 Dec 2004 17:01:17 -0500
Message-Id: <1102197677.6052.77.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-04 at 21:49 +0100, Miguel Angel Flores wrote:

> -	mask_39bit = 0x7FFFFFFFFFULL;
> +	mask_39bit = 0x7FFFFFFF;

I cannot believe that this is the correct solution and, if it is, the
name of the variable ought to be changed.

More likely, I suspect that the mask wants to be 39-bits, what with its
name and all.

The problem is that DMA addresses come in both 32-bit (generic) and
64-bit (high) forms.  mask_39bit is a dma_addr_t so it is 64-bit if
CONFIG_HIGHMEM64G and 32-bit otherwise.  Possibly, the right solution is
to make mask_39bit dma64_addr_t.  Or, if the mapping needs to be
consistent, assign a different value depending on the value of
CONFIG_HIGHMEM64G.

See Documentation/DMA-*.txt for more information.

	Robert Love


