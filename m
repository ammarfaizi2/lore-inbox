Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbULNXP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbULNXP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbULNXP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:15:27 -0500
Received: from [213.146.154.40] ([213.146.154.40]:57753 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261745AbULNXLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:11:08 -0500
Date: Tue, 14 Dec 2004 23:11:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Ralf Baechle <ralf@linux-mips.org>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: Re: [PATCH 2/6] mv643xx_eth: replace fixed-count spin delays
Message-ID: <20041214231101.GA11617@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dale Farnsworth <dale@farnsworth.org>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, Ralf Baechle <ralf@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	Brian Waite <brian@waitefamily.us>,
	"Steven J. Hill" <sjhill@realitydiluted.com>
References: <20041213220949.GA19609@xyzzy> <20041213221431.GB19951@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213221431.GB19951@xyzzy>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 03:14:31PM -0700, Dale Farnsworth wrote:
> This patch removes spin delays (count to 1000000, ugh) and instead waits
> with udelay or msleep for hardware flags to change.
> 
> It also adds a spinlock to protect access to the MV64340_ETH_SMI_REG,
> which is shared across ports.

Care to add a comment with this information?  Driver-global locks are
something we tend to avoid, and cases like this one where it's actually
nessecary should be properly documented.

> +	for (i=0; i<10; i++) {

This is missing some space, should be:

	for (i = 0; i < 10; i++) {

> +#define PHY_WAIT_ITERATIONS	1000	/* 1000 iterations * 10uS = 10mS max */

Put this into the header or at least ontop of the file?

> +	/* wait for the SMI register to become available */
> +	for (i=0; MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_BUSY; i++) {

Missing spaces again.

> +	for (i=0; !(MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_READ_VALID); i++) {

Dito.  (And a few more)
