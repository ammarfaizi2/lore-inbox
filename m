Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946068AbWGPBTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946068AbWGPBTG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 21:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946069AbWGPBTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 21:19:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42632
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946068AbWGPBTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 21:19:05 -0400
Date: Sat, 15 Jul 2006 18:19:17 -0700 (PDT)
Message-Id: <20060715.181917.71091405.davem@davemloft.net>
To: davej@redhat.com
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060715060400.GC5557@redhat.com>
References: <20060715010645.GB11515@gondor.apana.org.au>
	<20060714.224001.71089810.davem@davemloft.net>
	<20060715060400.GC5557@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Sat, 15 Jul 2006 02:04:00 -0400

> Ick, nasty.  Seems there's quite a few instances of that construct around.

The cases you grepped out here all seem to be OK to my eyes.
They fall into two categories of legitimate uses:

1) The return value really is a boolean, 0 or 1, so using
   likely/unlikely around it is fine.

   In fact, for a inline function returning a boolean, this
   is a way to get the likely'ness to propagate into a test
   done by the caller.

2) The likely() is part of some real check such as:

   return (likely(test_val) ? x : y);

   which is also fine.

Like I said, the bad case is only when the unlikely() or likely()
surrounds an expression that is not expected to evaluate to
a boolean.
