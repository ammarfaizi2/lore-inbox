Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031072AbWKUQ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031072AbWKUQ31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031073AbWKUQ31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:29:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:33494 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1031072AbWKUQ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:29:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M6g4VFMiLyc9mxLH6xnLqhjX+tocnS7dA5ozJRFOyTQlEH1/E0FmH0WgAzcut2UHx4Ep/S+w1hXS1KkX5Kl+lPyw5wNp6+AkBZt0VyPwnlPrL3lo6k/fFFmSvB2fR7cW2Hdjb7d5Whw5CagBTHT8BUk22sAApBzqyHN5hLYGfX4=
Message-ID: <3a5b1be00611210829p75f44b1fu7ba6fde807fb530e@mail.gmail.com>
Date: Tue, 21 Nov 2006 18:29:23 +0200
From: "Komal Shah" <komal.shah802003@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: gen_pool_destroy(...)?
Cc: jes@trained-monkey.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Why we don't have gen_pool_destroy(...) like mempool_destroy(...)? As
of now I can only see the application of genalloc function in
ia64/uncached.c file only.

Reason, why I am asking is, that I have dual-core embedded processor
(ARM11-ARM7), ARM11 being the master and the bridge between the two
has to manage the customized ARM7-MMU (which offers me 4GB of virtual
address space, but in application/driver, we would like to use only
2GB).

So, before mapping any user-space allocated/kernel allocated buffer to
ARM7-MMU so that it can be visible there, I want to check that Is
there any enough space left in that ARM7 virtual address space, if
yes, I want allow that virtual address to be used for mapping the
buffer.

So, use of it might go like this...

rsvpool =  gen_pool_create(PAGE_SHIFT, -1)..

gen_pool_add(rsvpool, addr, SZ_2G, -1);

....then alloc/check the space as requested by the user/kernel buffer..eg. SZ_4K

gen_pool_alloc(rsvpool, SZ_4K);

Now, each reserved pool allocation should also keep track of if it is
really mapped to ARM7 or not....

but finally when driver unloads, it should delete the pool...with
something like gen_pool_destroy(...) isn't it?

-- 
---Komal Shah
http://komalshah.blogspot.com
