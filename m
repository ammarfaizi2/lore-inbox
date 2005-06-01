Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFATcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFATcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVFATc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:32:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63456 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261155AbVFAT3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:29:16 -0400
Subject: Re: [PATCH] Sample fix for hyperthread exploit
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
In-Reply-To: <20050601172505.GM23013@shell0.pdx.osdl.net>
References: <200506012158.39805.kernel@kolivas.org>
	 <1117627597.6271.29.camel@laptopd505.fenrus.org>
	 <200506012213.25445.kernel@kolivas.org>
	 <20050601172505.GM23013@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 21:29:07 +0200
Message-Id: <1117654147.6271.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 10:25 -0700, Chris Wright wrote:
> * Con Kolivas (kernel@kolivas.org) wrote:
> > On Wed, 1 Jun 2005 22:06, Arjan van de Ven wrote:
> > > > Comments?
> > >
> > > I don't think it's really worth it, but if you go this way I'd rather do
> > > this via a prctl() so that apps can tell the kernel "I'd like to run
> > > exclusive on a core". That'd be much better than blindly isolating all
> > > applications.
> > 
> > I agree, and this is where we (could) implement the core isolation. I'm still 
> > under the impression (as you appear to be) that this theoretical exploit is 
> > not worth trying to work around.
> 
> Also, uid is not sufficient.  Something more comprehensive (like ability
> to ptrace) would be appropriate.

I would go a lot simpler. App says "I want exclusivity" via pctl and
NOTHING runs on the other half. Well maybe with exceptions of processes
that share the mm with the exclusive one (in practice "threads") since
those could just read the memory anyway.

ptrace-ability goes wonky the moment the "secret bearing" thread revokes
something that would make ptrace be denied consequently ... means we'd
have to find all those cases and make all of them bump the other app of
the cpu. smells too complex to me for such a rare event -> hard to get
fail proof.

