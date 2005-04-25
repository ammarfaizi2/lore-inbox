Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVDYVA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVDYVA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVDYVA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:00:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6308 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261185AbVDYVAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:00:22 -0400
Subject: Re: [PATCH 5/7] dlm: device interface
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050425151303.GF6826@redhat.com>
References: <20050425151303.GF6826@redhat.com>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 23:00:18 +0200
Message-Id: <1114462819.8442.57.camel@laptopd505.fenrus.org>
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


> +static struct rw_semaphore lockinfo_lock;


why are you using a rwsem here? rw semaphores are *expensive*. Really
expensive. Might well not be worth it unless you expect really frequent
readers compared to writers *and* long hold times. Can you give an idea
about how frequent the reader case is?
(and if it's really frequent, wouldn't RCU be a better solution?)


