Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVCZIgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVCZIgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVCZIe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:34:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11940 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262015AbVCZIeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:34:14 -0500
Subject: Re: [PATCH] remove redundant NULL pointer checks prior to calling
	kfree() in fs/nfsd/
From: Arjan van de Ven <arjan@infradead.org>
To: linux-os@analogic.com
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503251731240.6372@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252319220.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503251731240.6372@chaos.analogic.com>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 09:34:00 +0100
Message-Id: <1111826041.6293.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Fri, 2005-03-25 at 17:34 -0500, linux-os wrote:
> On Fri, 25 Mar 2005, Jesper Juhl wrote:
> 
> > (please keep me on CC)
> >
> >
> > checking for NULL before calling kfree() is redundant and needlessly
> > enlarges the kernel image, let's get rid of those checks.
> >
> 
> Hardly. ORing a value with itself and jumping on condition is
> real cheap compared with pushing a value into the stack

which century are you from?
"jumping on condition" can easily be 100+ cycles, depending on how
effective the branch predictor is. Pushing a value onto the stack otoh
is half a cycle. 

Your argument was right probably in 1994, when cpus didn't do
speculation and out of order execution...


