Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVJOKFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVJOKFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 06:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVJOKFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 06:05:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35522 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751090AbVJOKFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 06:05:41 -0400
Subject: Re: interruptible_sleep_on, interrupts and device drivers
From: Arjan van de Ven <arjan@infradead.org>
To: Gabriele Brugnoni <news@dveprojects.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510151200.32148.news@dveprojects.com>
References: <200510151200.32148.news@dveprojects.com>
Content-Type: text/plain
Date: Sat, 15 Oct 2005 12:05:22 +0200
Message-Id: <1129370722.2908.5.camel@laptopd505.fenrus.org>
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

On Sat, 2005-10-15 at 12:00 +0200, Gabriele Brugnoni wrote:
> Hello,
> 
> I'm writing a device driver for a UART to be used to drive a RS485 line. 
> I would use the interruptible_sleep_on function to wait for receiver ready,
> or for the transmitter to finish.

don't.

interruptible_sleep_on() is a broken interface (see the comments in the
header) and should not be used in any new code (where "new" is "since
the year 2000" :)

Just use the wait_event() interfaces .... or just a simple semaphore
even if what you want to do is simple and performance isn't too
critical.


