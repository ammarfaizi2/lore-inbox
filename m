Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWJIHkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWJIHkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWJIHkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:40:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61871 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932322AbWJIHkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:40:41 -0400
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
	handle IRQ -1"
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>, Roland Dreier <rdreier@cisco.com>
In-Reply-To: <m1hcyerpjc.fsf@ebiederm.dsl.xmission.com>
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	 <m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	 <20061006155021.GE14186@rhun.haifa.ibm.com>
	 <m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	 <20061006202324.GJ14186@rhun.haifa.ibm.com>
	 <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	 <20061007080315.GM14186@rhun.haifa.ibm.com>
	 <m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0610071154510.3952@g5.osdl.org>
	 <1160249585.3000.159.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0610071255480.3952@g5.osdl.org>
	 <m1hcyerpjc.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 09 Oct 2006 09:40:05 +0200
Message-Id: <1160379606.3000.195.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So yes, having software say "We want to steer this particular interrupt to 
> > this L3 cache domain" sounds eminently sane.
> >
> > Having software specify which L1 cache domain it wants to pollute is 
> > likely just crazy micro-management.
> 
> The current interrupt delivery abstraction in the kernel is a
> set of cpus an interrupt can be delivered to.  Which seem sufficient
> to the cause of aiming at a cache domain.  Frequently the lower
> levels of interrupt delivery map this to a single cpu because of
> hardware limitations but in certain cases we can honor a multiple cpu
> request.
> 
> I believe the scheduler has knowledge about different locality domains
> for NUMA and everything else.  So what is wanting on our side is some
> architecture? work to do the broad steering by default.


well normally this is the job of the userspace IRQ balancer to get
right; the thing is undergoing a redesign right now to be smarter and
deal better with dual/quad core, numa etc etc, but as a principle thing
this is best done in userspace (simply because there's higher level
information there, like "is this interrupt for a network device", so
that policy can take that into account)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

