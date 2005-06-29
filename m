Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVF2LPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVF2LPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVF2LPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:15:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59347 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262551AbVF2LPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:15:42 -0400
Subject: Re: kmalloc without GFP_xxx?
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506291402.18064.vda@ilport.com.ua>
References: <200506291402.18064.vda@ilport.com.ua>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 13:15:39 +0200
Message-Id: <1120043739.3196.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Wed, 2005-06-29 at 14:02 +0300, Denis Vlasenko wrote:
> Hi,
> It struck me that kernel actually can figure out whether it's okay
> to sleep or not by looking at combination of (flags & __GFP_WAIT)
> and ((in_atomic() || irqs_disabled()) as it already does this for
> might_sleep() barfing:

that is not enough.

you could be holding a spinlock for example!

(and no that doesn't set in_atomic() always)


