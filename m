Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVCVIeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVCVIeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVCVIeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:34:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60838 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262564AbVCVId4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:33:56 -0500
Subject: Re: mmap/munmap bug
From: Arjan van de Ven <arjan@infradead.org>
To: Hayim Shaul <hayim@post.tau.ac.il>
Cc: Gleb Natapov <gleb@minantech.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503221015500.10609@nova.cs.tau.ac.il>
References: <Pine.LNX.4.61.0503211731430.9160@nova.cs.tau.ac.il>
	 <1111430042.6952.70.camel@laptopd505.fenrus.org>
	 <20050322075658.GA32445@minantech.com>
	 <1111478733.7096.36.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0503221015500.10609@nova.cs.tau.ac.il>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 09:33:49 +0100
Message-Id: <1111480429.7096.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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

On Tue, 2005-03-22 at 10:23 +0200, Hayim Shaul wrote:
> >> Does it support zero copy not only for send but also for receive? Can we
> >> receive packets directly to userspace buffers?
> >
> > that it can't currently, but without some major protocol stack rework
> > that's not going to be easy. If you want to help do that work,
> > excellent! Be sure to contact the people on net-dev mailinglist since
> > they are the ones having looked at this previously.
> 
> My case is simpler, as the application I attend it to is similar to a NAT. 
> A packet comes in, a little alternation of the headers and off it goes 
> again. So there's no TCP-stack or anything.
> 
> What I thought of doing, is map the skbuff to user-space. Have the 
> user-application alter the headers. Send the (same) skbuff from 
> kernel-space.
> 
> Does there exist anything equivalent?

yes; netfilter has facilities for this actually afaik.
tcpdump also uses something like this (but only in one direction), it
mmaps some ringbuffer with incomming packets.


