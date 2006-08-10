Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWHJO07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWHJO07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWHJO07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:26:59 -0400
Received: from sd291.sivit.org ([194.146.225.122]:57352 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1751186AbWHJO06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:26:58 -0400
Subject: Re: [PATCH] memory ordering in __kfifo primitives
From: Stelian Pop <stelian@popies.net>
To: paulmck@us.ibm.com
Cc: Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       open-iscsi@googlegroups.com, pradeep@us.ibm.com, mashirle@us.ibm.com
In-Reply-To: <20060810134135.GB1298@us.ibm.com>
References: <20060810001823.GA3026@us.ibm.com>
	 <20060810003310.GA3071@us.ibm.com> <44DAC892.7000100@cs.wisc.edu>
	 <20060810134135.GB1298@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 10 Aug 2006 16:26:53 +0200
Message-Id: <1155220013.1108.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 10 août 2006 à 06:41 -0700, Paul E. McKenney a écrit :

> I am happy to go either way -- the patch with the memory barriers
> (which does have the side-effect of slowing down kfifo_get() and
> kfifo_put(), by the way), or a patch removing the comments saying
> that it is OK to invoke __kfifo_get() and __kfifo_put() without
> locking.
> 
> Any other thoughts on which is better?  (1) the memory barriers or
> (2) requiring the caller hold appropriate locks across calls to
> __kfifo_get() and __kfifo_put()?

If someone wants to use explicit locking, he/she can go with kfifo_get()
instead of the __ version.

I'd rather keep the __kfifo_get() and __kfifo_put() functions lockless,
so I say go for (1) even if there is a tiny price to pay for corectness.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

