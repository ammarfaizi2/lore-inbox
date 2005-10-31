Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVJaVWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVJaVWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVJaVWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:22:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26534 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932521AbVJaVWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:22:30 -0500
Subject: Re: BUG?: request_irq can apparently sleep
From: Arjan van de Ven <arjan@infradead.org>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051031104110.18938.qmail@thales.mathematik.uni-ulm.de>
References: <20051031104110.18938.qmail@thales.mathematik.uni-ulm.de>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 22:22:23 +0100
Message-Id: <1130793744.2798.8.camel@laptopd505.fenrus.org>
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

On Mon, 2005-10-31 at 11:41 +0100, Christian Ehrhardt wrote:
> Hi,
> 
> the basic question is: Is request_irq allowed to sleep?

yes it sleeps.

problem is some (IDE) code calls it really early during boot in a place
you can't sleep, and during that early boot it also usually won't sleep.
Just that if we make request_irq() a might_sleep() then everyone gets
spew in their dmesg... and lots of bugreports



