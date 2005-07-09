Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVGITri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVGITri (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVGITri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:47:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40615 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261706AbVGITrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:47:36 -0400
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20050709191501.GA9068@wotan.suse.de>
References: <20050709144116.GA9444@elte.hu.suse.lists.linux.kernel>
	 <20050709152924.GA13492@elte.hu.suse.lists.linux.kernel>
	 <p73ll4f29m7.fsf@verdi.suse.de>
	 <1120930264.3176.52.camel@laptopd505.fenrus.org>
	 <20050709191501.GA9068@wotan.suse.de>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 21:47:26 +0200
Message-Id: <1120938446.3176.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Sat, 2005-07-09 at 21:15 +0200, Andi Kleen wrote:
> On Sat, Jul 09, 2005 at 07:31:04PM +0200, Arjan van de Ven wrote:
> > On Sat, 2005-07-09 at 19:05 +0200, Andi Kleen wrote:
> > > Ingo Molnar <mingo@elte.hu> writes:
> > > >  
> > > > +static void force_sig_info_fault(int si_signo, int si_code,
> > > > +				 unsigned long address, struct task_struct *tsk)
> > > 
> > > This won't work with a unit-at-a-time compiler which happily
> > > inlines everything static with only a single caller. Use noinline
> > 
> > but.... the x86 kernel is -fno-unit-at-a-time.... for stack reasons ;)
> 
> The gcc people are making noises of removing that. So eventually
> it will need to go.

the gcc people also fixed the stack usage on inlining (at least this
specific class) in CVS HEAD so the "problem" is a lot smaller whenever
they make it go away.

