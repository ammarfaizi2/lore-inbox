Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUI2OYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUI2OYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUI2OXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:23:11 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:38916 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268464AbUI2OVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:21:16 -0400
Date: Wed, 29 Sep 2004 15:21:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: "Leubner, Achim" <Achim_Leubner@adaptec.com>, arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gdth update
Message-ID: <20040929152109.A13189@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	"Leubner, Achim" <Achim_Leubner@adaptec.com>, arjanv@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <B51CDBDEB98C094BB6E1985861F53AF302DE00@nkse2k01.adaptec.com> <20040929134301.GB17952@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040929134301.GB17952@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Wed, Sep 29, 2004 at 03:43:01PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 03:43:01PM +0200, Jörn Engel wrote:
> On Wed, 29 September 2004 14:15:57 +0200, Leubner, Achim wrote:
> >  
> > > > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> > > > +static irqreturn_t gdth_interrupt(int irq, void *dev_id, struct
> > pt_regs *regs);
> > > >  #else
> > > > -static void gdth_interrupt(int irq,struct pt_regs *regs);
> > > > +static void gdth_interrupt(int irq, void *dev_id, struct pt_regs
> > *regs);
> > > >  #endif
> > > 
> > > this really is the wrong way to do such irq prototype compatibility in
> > > drivers. *really*
> > > 
> > So please tell me what the right way should be. It works without any
> > problem.
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> #define irqreturn_t void
> #define IRQ_NONE
> #define IRQ_HANDLED
> #endif

Actually all these are in recent 2.4.x release.  So better check for
#ifndef IRQ_HANDLED.

