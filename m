Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWDUDxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWDUDxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 23:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWDUDxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 23:53:04 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:4613 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932160AbWDUDxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 23:53:03 -0400
Date: Fri, 21 Apr 2006 12:55:43 +0900 (JST)
Message-Id: <20060421.125543.126764691.yoshfuji@linux-ipv6.org>
To: opendon@donlaw.com
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, kaber@coreworks.de, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH linux-2.6.17-rc1] net: fix neigh_delete to handle mult.
 tables
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <4448520C.5080508@donlaw.com>
References: <4448520C.5080508@donlaw.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4448520C.5080508@donlaw.com> (at Thu, 20 Apr 2006 23:31:24 -0400), Don Law <opendon@donlaw.com> says:

> One side effect of this change is that neigh_lookup is now called while
> a read lock is held on neigh_tbl_lock.  neigh_lookup does take read
> locks on the tbl->lock set.  However, this does not introduce any new lock
> order dependencies, since we already have that precedent set in the
> neightbl_set function.

I don't think this is good change.

What you need to fix your problem is to remove the last
"goto out_dev_put;" isn't it?

--yoshfuji
