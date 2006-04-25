Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWDYF1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWDYF1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWDYF1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:27:07 -0400
Received: from mtaout3.012.net.il ([84.95.2.7]:61306 "EHLO mtaout3.012.net.il")
	by vger.kernel.org with ESMTP id S932111AbWDYF1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:27:06 -0400
Date: Tue, 25 Apr 2006 08:26:07 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] x86-64: trivial gart clean-up
In-reply-to: <200604250042.43910.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, linux-kernel@vger.kernel.org
Message-id: <20060425052607.GC28558@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060424225342.GB14575@us.ibm.com> <200604250042.43910.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:42:43AM +0200, Andi Kleen wrote:

> On Tuesday 25 April 2006 00:53, Jon Mason wrote:
> > A trivial change to have gart_unmap_sg call gart_unmap_single directly,
> > instead of bouncing through the dma_unmap_single wrapper in
> > dma-mapping.h.  This change required moving the gart_unmap_single above
> > gart_unmap_sg, and under gart_map_single (which seems a more logical
> > place that its current location IMHO).
> 
> What advantage does that have? I think I prefer the old code.

I don't know what Jon had in mind, but we do avoid a call through a
function pointer this way. I agree with Jon that it also makes more
sense - gart code can just call the gart code directly, without going
through the dma_xxx wrapper that ends up calling it anyway.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

