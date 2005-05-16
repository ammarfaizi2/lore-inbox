Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVEPLMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVEPLMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVEPLMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:12:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4010 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261405AbVEPLMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:12:40 -0400
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050516110203.GA13387@merlin.emma.line.org>
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	 <200505151121.36243.gene.heskett@verizon.net>
	 <20050515152956.GA25143@havoc.gtf.org>
	 <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	 <42877C1B.2030008@pobox.com>  <20050516110203.GA13387@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 16 May 2005 13:12:36 +0200
Message-Id: <1116241957.6274.36.camel@laptopd505.fenrus.org>
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

>  and
> request that the kernel switches off the drive's write cache in all
> drives unless the whole fsync() stuff works (unless defeated by a
> "benchmark" kernel boot parameter).

I think you missed the part where disabling the writecache decreases the
mtbf of your disk by like a factor 100 or so. At which point your
dataloss opportunity INCREASES by doing this.

Sure you can waive rethorics around, but the fact is that linux is
improving; there now is write barrier support for ext3 (and I assume
reiserfs) for at least IDE and iirc selected scsi too. 

Lets repeat that again: disabling the writecache altogether is bad for
your disk. really bad. Barriers aren't brilliant for it either but a
heck of a lot better. Lacking barriers, it's probably safer for your
data to have write cache on than off.


