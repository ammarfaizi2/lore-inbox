Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVCNAB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVCNAB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVCNAB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:01:56 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:59063 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261592AbVCNABy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:01:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16948.54411.754999.668332@wombat.chubb.wattle.id.au>
Date: Mon, 14 Mar 2005 11:02:19 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for	2.6.11)
In-Reply-To: <1110568448.15927.74.camel@localhost.localdomain>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	<1110568448.15927.74.camel@localhost.localdomain>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Gwe, 2005-03-11 at 03:36, Peter Chubb wrote:
> +static irqreturn_t irq_proc_irq_handler(int irq, void *vidp, struct pt_regs *regs)
> +{
> + 	struct irq_proc *idp = (struct irq_proc *)vidp;
> + 
> + 	BUG_ON(idp->irq != irq);
> + 	disable_irq_nosync(irq);
> + 	atomic_inc(&idp->count);
> + 	wake_up(&idp->q);
> + 	return IRQ_HANDLED;

Alan> You just deadlocked the machine in many configurations. You can't use
Alan> disable_irq for this trick you have to tell the kernel how to handle it.


Can you elaborate, please?  In particular, why doesn't essentially the
same action (disabling an interrupt before the EOI) in
note_interrupt() not lock up the machine?

I can see there'd be problems if the code allowed shared interrupts,
but it doesn't.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
