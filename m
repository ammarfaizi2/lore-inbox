Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUHBVvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUHBVvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUHBVus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:50:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:11673 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263972AbUHBVtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:49:51 -0400
Subject: Re: [PATCH] [ppc64] watch IOMMU virtual merging
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Anton Blanchard <anton@samba.org>, sfr@ozlabs.org,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040802170843.GI2334@holomorphy.com>
References: <20040802164448.GN30253@krispykreme>
	 <20040802170843.GI2334@holomorphy.com>
Content-Type: text/plain
Message-Id: <1091483151.7389.78.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 07:45:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not familiar with the TCE space regions; could you describe or
> point to documentation for the semantics there?
> 
> My first thought is to artificially limit the amount of physical
> merging (hopefully to some nonzero amount instead of disabling it
> entirely) allowed to take place in order to allow for better virtual
> merging.

Actually, we could tune the ratio between large allocs and small allocs,
the real problem is the failure case. We can't really afford to break
down a physical segment at the iommu level because that would increase
the size of the SG list which can't be dealt at the upper level (we don't
know how much space has been allocated and the HW may have limitations on
the number of entries).

What we really need is a way for drivers to return the BIO upstream and
ask for a split in case of iommu allocation error, but I've been told that
would be horribly complex...

Ben.


