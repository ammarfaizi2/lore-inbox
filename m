Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbULOSEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbULOSEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbULOSEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:04:21 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:52612 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S262422AbULOSDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:03:42 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 15 Dec 2004 11:03:37 -0700
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mv643xx_eth: replace fixed-count spin delays
Message-ID: <20041215180337.GA17904@xyzzy>
References: <20041213220949.GA19609@xyzzy> <20041213221431.GB19951@xyzzy> <20041214231101.GA11617@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214231101.GA11617@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:11:01PM +0000, Christoph Hellwig wrote:
> On Mon, Dec 13, 2004 at 03:14:31PM -0700, Dale Farnsworth wrote:
> > This patch removes spin delays (count to 1000000, ugh) and instead waits
> > with udelay or msleep for hardware flags to change.
> > 
> > It also adds a spinlock to protect access to the MV64340_ETH_SMI_REG,
> > which is shared across ports.
> 
> Care to add a comment with this information?  Driver-global locks are
> something we tend to avoid, and cases like this one where it's actually
> nessecary should be properly documented.

I did have comments where the spinlock is used.  I'll add one at the
spinlock definition as well.

> 
> > +	for (i=0; i<10; i++) {
> 
> This is missing some space, should be:
> 
> 	for (i = 0; i < 10; i++) {

Ok. I'll fix.

> > +#define PHY_WAIT_ITERATIONS	1000	/* 1000 iterations * 10uS = 10mS max */
> 
> Put this into the header or at least ontop of the file?

Will do.

> > +	/* wait for the SMI register to become available */
> > +	for (i=0; MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_BUSY; i++) {
> 
> Missing spaces again.
> 
> > +	for (i=0; !(MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_READ_VALID); i++) {
> 
> Dito.  (And a few more)

I'll fix them all.

Thanks,
-Dale
