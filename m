Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUL3LSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUL3LSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 06:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbUL3LSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 06:18:49 -0500
Received: from canuck.infradead.org ([205.233.218.70]:54539 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261612AbUL3LSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 06:18:47 -0500
Subject: Re: Bug : Out of range ptr error in module indicates bug in slab.c
From: Arjan van de Ven <arjan@infradead.org>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041230105452.26574.qmail@web60605.mail.yahoo.com>
References: <20041230105452.26574.qmail@web60605.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 30 Dec 2004 12:18:40 +0100
Message-Id: <1104405521.4170.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-30 at 02:54 -0800, selvakumar nagendran wrote:
> 		else	{
> 			new -> pipe_read_end = fdes[0];
> 			new -> pipe_write_end = fdes[1];

this is a bug; fdes is a USERSPACE pointer, you cannot directly access
that from kernel space, you need to use copy_from_user() for that.

And note, what you are doing is unreliable, since the user is capable of
changing that information before you log it in your structure, so if you
want to use the data you log for anything security related or for
something that has to be accurate, it's broken...

> 	while(temp != NULL)
> 	{
> 		kfree(temp);
> 		temp = temp -> next;
> 	}

that is of course wrong; you free temp and THEN you access it!!


