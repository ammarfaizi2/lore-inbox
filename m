Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424484AbWKPUwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424484AbWKPUwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424483AbWKPUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:52:25 -0500
Received: from localhost.localdomain ([127.0.0.1]:44435 "EHLO localhost")
	by vger.kernel.org with ESMTP id S1424482AbWKPUwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:52:24 -0500
Date: Thu, 16 Nov 2006 15:52:24 -0500 (EST)
Message-Id: <20061116.155224.08323028.davem@davemloft.net>
To: jaschut@sandia.gov
Cc: linux-kernel@vger.kernel.org, jens.axboe@oracle.com
Subject: Re: splice/vmsplice performance test results
From: David Miller <davem@davemloft.net>
In-Reply-To: <1163700539.2672.14.camel@sale659.sandia.gov>
References: <1163700539.2672.14.camel@sale659.sandia.gov>
X-Mailer: Mew version 5.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jim Schutt" <jaschut@sandia.gov>
Date: Thu, 16 Nov 2006 11:08:59 -0700

> Or is read+write really the fastest way to get data off a
> socket and into a file?

There is still no explicit TCP support for splice/vmsplice so things
get copied around and most of the other advantaves of splice/vmplice
aren't obtained either.  So perhaps that explains your numbers.

Jens Axboe tries to get things working, and others have looked into it
too, but adding TCP support is hard and for several reasons folks like
Alexey Kuznetsov and Evgeniy Polyakov believe that sys_receivefile()
is an interface much better suited for TCP receive.

splice/vmsplice has a lot of state connected to a transaction, and
perhaps that is part of why Evgeniy and Alexey have trouble wrapping
their brains around an efficient implementation.
