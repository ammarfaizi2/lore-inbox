Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVCLJKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVCLJKv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 04:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVCLJKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 04:10:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31717 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261890AbVCLJKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 04:10:45 -0500
Subject: Re: [PATCH] Prefaulting
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20050311172228.773cf03d.akpm@osdl.org>
References: <Pine.LNX.4.58.0503110444220.19419@schroedinger.engr.sgi.com>
	 <20050311172228.773cf03d.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 10:10:36 +0100
Message-Id: <1110618637.6292.36.camel@laptopd505.fenrus.org>
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


> >From a quick peek it seems that the patch makes negligible difference for a
> kernel compilation when prefaulting 1-2 pages and slows the workload down
> quite a lot when prefaulting up to 16 pages.

well the last time I saw prefaulting experiments (Ingo was involved
iirc) the problem was that the hitrate for the prefaults was such that
the costs for tearing down the extra redundant rmap chains was more
expensive than taking the "extra" faults. It seems linux has pretty
cheap faulting logic invalidating some of traditional OS assumptions... 

(fwiw one of the worst tests I remember was doing a lot of very short
shell script executions; the case where bash lives briefly so that you
get maximum cost for the extra teardowns while not a lot of bash gets
run so prefaulting doesn't make a lot of difference)


