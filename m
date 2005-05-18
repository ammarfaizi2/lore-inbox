Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVERUiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVERUiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVERUiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:38:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3566 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262359AbVERUiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:38:08 -0400
Subject: Re: [PATCH] prevent NULL mmap in topdown model
From: Arjan van de Ven <arjan@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 22:38:02 +0200
Message-Id: <1116448683.6572.43.camel@laptopd505.fenrus.org>
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

On Wed, 2005-05-18 at 15:57 -0400, Rik van Riel wrote:
> This (trivial) patch prevents the topdown allocator from allocating
> mmap areas all the way down to address zero.  It's not the prettiest
> patch, so suggestions for improvement are welcome ;)


it looks like you stop at brk() time.. isn't it better to just stop just
above NULL instead?? Gives you more space and is less of an artificial
barrier..


