Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVHOJm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVHOJm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 05:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVHOJm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 05:42:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37809 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932393AbVHOJm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 05:42:28 -0400
Subject: Re: [-mm patch] make kcalloc() a static inline
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200508151233.46523.vda@ilport.com.ua>
References: <20050808223842.GM4006@stusta.de>
	 <200508151120.46186.vda@ilport.com.ua>
	 <Pine.LNX.4.58.0508151126570.26955@sbz-30.cs.Helsinki.FI>
	 <200508151233.46523.vda@ilport.com.ua>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 11:41:57 +0200
Message-Id: <1124098918.3228.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Mon, 2005-08-15 at 12:33 +0300, Denis Vlasenko wrote:

> gcc can optimize that away with non-const n?! I don't think so.

due to the wonders of "value range propagation" it actually can, if the
check is done sufficiently before...

gcc keeps track of the range a variable can have at each point, so if
the check is done before, the "possible range" will be such that the
divide should be optimizable.

(Note: this is a relatively new feature in gcc though)


