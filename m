Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWG0SN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWG0SN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWG0SN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:13:59 -0400
Received: from hera.kernel.org ([140.211.167.34]:45736 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751911AbWG0SN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:13:58 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: request_irq() return value
Date: Thu, 27 Jul 2006 11:13:17 -0700
Organization: OSDL
Message-ID: <20060727111317.109bfc4d@localhost.localdomain>
References: <200607271950.03370.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1154023998 6608 10.8.0.54 (27 Jul 2006 18:13:18 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 27 Jul 2006 18:13:18 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 19:50:03 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	I'm looking at the source code of different drivers and wondering about 
> request_irq() return value. It is used mostly in 'open' routine of struct 
> net_device. If request_irq() fails some drivers return -EAGAIN, some -EBUSY 
> and some the return value of request_irq(). Is this intentional? Sample 
> drivers code:

Correct practice is to propagate the error code of request_irq out to be
the return value of the open routine. This allows the request_irq to return
different values for overlapping irqs, or out of memory, etc.

> Besides request_irq() is arch dependent so depending on arch it has different 
> set of possible return values. So ... does the return value matter or I 
> misunderstood something here?

Each architecture should return something sane. If it doesn't then it a problem
that should be addressed there.
