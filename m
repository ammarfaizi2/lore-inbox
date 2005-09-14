Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVINT5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVINT5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVINT5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:57:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64709
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932565AbVINT5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:57:53 -0400
Date: Wed, 14 Sep 2005 12:57:50 -0700 (PDT)
Message-Id: <20050914.125750.05416211.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH]: Brown paper bag in fs/file.c?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050914191842.GA6315@in.ibm.com>
References: <20050914.113133.78024310.davem@davemloft.net>
	<20050914191842.GA6315@in.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dipankar Sarma <dipankar@in.ibm.com>
Date: Thu, 15 Sep 2005 00:48:42 +0530

> __free_fdtable() is used only when the fdarray/fdset are vmalloced
> (use of the workqueue) or there is a race between two expand_files().
> That might be why we haven't seen this cause any explicit problem
> so far.
> 
> This would be an appropriate patch - (untested). I will update
> as soon as testing is done.

Thanks.

I still can't figure out what causes my sparc64 bug.  Somehow a
kmalloc() chunk of file pointers gets freed too early, the SLAB is
shrunk due to memory pressure so the page containing that object gets
freed, that page ends up as an anonymous page in userspace, but filp
writes from the older usage occurs and corrupts the page.

I wonder if we simply leave a stale pointer around to the older
fd array in some case.
