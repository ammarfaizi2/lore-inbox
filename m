Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVBVWEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVBVWEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVBVWEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:04:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261290AbVBVWEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:04:01 -0500
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
From: Arjan van de Ven <arjan@infradead.org>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <16923.193.128608.607599@jaguar.mkp.net>
References: <16923.193.128608.607599@jaguar.mkp.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 23:03:53 +0100
Message-Id: <1109109833.6024.109.camel@laptopd505.fenrus.org>
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

On Tue, 2005-02-22 at 04:52 -0500, Jes Sorensen wrote:
> Hi,
> 
> This patch introduces ia64 specific read/write handlers for /dev/mem
> access which is needed to avoid uncached pages to be accessed through
> the cached kernel window which can lead to random corruption. It also
> introduces a new page-flag PG_uncached which will be used to mark the
> uncached pages. I assume this may be useful to other architectures as
> well where the CPU may use speculative reads which conflict with
> uncached access. In addition I moved do_write_mem to be under
> ARCH_HAS_DEV_MEM as it's only ever used if that is defined.
> 
> The patch is needed for the new ia64 special memory driver (mspec -
> former fetchop).


is there ANY valid reason to allow access to cached uses at all?
(eg kernel ram)

why not just disable any such ram access entirely...


