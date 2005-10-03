Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVJCOtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVJCOtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVJCOtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:49:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932265AbVJCOtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:49:22 -0400
Subject: Re: [RFC] mempool_alloc() pre-allocated object usage
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Mundt <paul.mundt@nokia.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20051003143634.GA1702@nokia.com>
References: <20051003143634.GA1702@nokia.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 16:49:13 +0200
Message-Id: <1128350953.17024.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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

On Mon, 2005-10-03 at 17:36 +0300, Paul Mundt wrote:

> Both usage patterns seem valid from my point of view, would you be open
> to something that would accomodate both? (ie, possibly adding in a flag
> to determine pre-allocated object usage?) Or should I not be using
> mempool for contiguity purposes?

a similar dillema was in the highmem bounce code in 2.4; what worked
really well back then was to do it both; eg use half the pool for
"immediate" use, then try a VM alloc, and use the second half of the
pool for the really emergency cases.

Technically a mempool is there ONLY for the fallback, but I can see some
value in making it also a fastpath by means of a small scratch pool

