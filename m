Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVAKIdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVAKIdz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVAKIdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:33:55 -0500
Received: from canuck.infradead.org ([205.233.218.70]:53512 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262568AbVAKIdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:33:50 -0500
Subject: Re: kfree error oops
From: Arjan van de Ven <arjan@infradead.org>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050111082332.58880.qmail@web60605.mail.yahoo.com>
References: <20050111082332.58880.qmail@web60605.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 09:33:44 +0100
Message-Id: <1105432425.3917.15.camel@laptopd505.fenrus.org>
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

On Tue, 2005-01-11 at 00:23 -0800, selvakumar nagendran wrote:
> Hello linux-experts,
>      While I tried to free the memory I allocated
> using kfree, I received the following error:
>   I am working in kernel 2.4.28.
>   I have also attached the code. Can anyone help me
> regarding this? I have also checked for NULL pointer
> even though it is not necessary.
> 
> Thanks,
> selva
> -----------------------
> list_for_each(p,&rhash_table[i])
> {
> 	//printk("\n Printing details for my..");
> 
> 	my = list_entry(p, struct resource, res_list);
> 	if(my)
> 	{	
> 	printk("\n My is not null..");
> 	printk("\n%ld,",  my -> rid.fd);
> 	printk("%ld,",  my -> rid.inode);
> 	printk("%d,", my -> rid.ACCESS_TYPE);
>         list_del(&my -> res_list);
>         kfree(my);

this is not allowed in list_for_each,
you must use list_for_each_safe() instead.


