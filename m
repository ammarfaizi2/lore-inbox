Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUI2Ntb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUI2Ntb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUI2NtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:49:20 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:34442 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S268430AbUI2NnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:43:07 -0400
Date: Wed, 29 Sep 2004 15:43:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Leubner, Achim" <Achim_Leubner@adaptec.com>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20040929134301.GB17952@wohnheim.fh-wedel.de>
References: <B51CDBDEB98C094BB6E1985861F53AF302DE00@nkse2k01.adaptec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B51CDBDEB98C094BB6E1985861F53AF302DE00@nkse2k01.adaptec.com>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] gdth update
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: Achim_Leubner@adaptec.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 September 2004 14:15:57 +0200, Leubner, Achim wrote:
>  
> > > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> > > +static irqreturn_t gdth_interrupt(int irq, void *dev_id, struct
> pt_regs *regs);
> > >  #else
> > > -static void gdth_interrupt(int irq,struct pt_regs *regs);
> > > +static void gdth_interrupt(int irq, void *dev_id, struct pt_regs
> *regs);
> > >  #endif
> > 
> > this really is the wrong way to do such irq prototype compatibility in
> > drivers. *really*
> > 
> So please tell me what the right way should be. It works without any
> problem.

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
#define irqreturn_t void
#define IRQ_NONE
#define IRQ_HANDLED
#endif

static irqreturn_t gdth_interrupt(int irq, void *_dev, struct pt_regs *regs)
{
	if (/*not for me*/)
		return IRQ_NONE;
	/* some work */
	return IRQ_HANDLED;
}

Magically get's converted to old driver code by the macros above.
Point is that all ugly parts are confined to some header and don't
pollute the driver proper.

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
