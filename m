Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbUKVIS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUKVIS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 03:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUKVIS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 03:18:58 -0500
Received: from canuck.infradead.org ([205.233.218.70]:37132 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261978AbUKVIS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 03:18:57 -0500
Subject: Re: can kfree sleep?
From: Arjan van de Ven <arjan@infradead.org>
To: "Peter T. Breuer" <ptb@lab.it.uc3m.es>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200411212230.iALMUcC17182@inv.it.uc3m.es>
References: <200411212230.iALMUcC17182@inv.it.uc3m.es>
Content-Type: text/plain
Message-Id: <1101111524.2813.18.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 22 Nov 2004 09:18:45 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?ip=80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Not true for vfree()
> 
> My interest at the moment is in what can sleep and what cannot sleep.
> Are you saying that vfree can sleep or that vfree cannot be called from
> at least one other context in addition to the NMI handler context (from
> which it cannot be called ...)?


vfree() is not allowed to be called from irq context, and since it can do cross cpu IPI's, you have to generally be careful with it.


