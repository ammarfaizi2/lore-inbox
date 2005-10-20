Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbVJTHrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbVJTHrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 03:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbVJTHri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 03:47:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1929 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751793AbVJTHrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 03:47:37 -0400
Subject: Re: Patch: ATI Xilleon port 2/11 net/e100 Memory barriers and
	write flushing
From: Arjan van de Ven <arjan@infradead.org>
To: ddaney@avtrex.com
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
References: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 09:47:25 +0200
Message-Id: <1129794446.2807.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 22:54 -0700, David Daney wrote:
> This is the second part of my Xilleon port.
> 
> I am sending the full set of patches to linux-mips@linux-mips.org
> which is archived at: http://www.linux-mips.org/archives/
> 
> Only the patches that touch generic parts of the kernel are coming
> here.
> 
> The Xilleon (32bit MIPS SOC) has a write back buffer that seems to
> operate on the pci bus and does not get flushed before a read.  The
> result is that a memory barrier must be done before a read intended to
> flush PCI writes.

this is broken hardware; the real solution is to put that wmb() into the
readl() function, as opposed to patching half the kernel for this!

And the second problem seems to be an reodering, which is also not quite
allowed. That also needs fixing, probably in the writel/writeb() macros.


