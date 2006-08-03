Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWHCVqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWHCVqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWHCVqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:46:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25783
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030187AbWHCVqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:46:40 -0400
Date: Thu, 03 Aug 2006 14:45:58 -0700 (PDT)
Message-Id: <20060803.144558.02298663.davem@davemloft.net>
To: tytso@mit.edu
Cc: dwalker@mvista.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       mchan@broadcom.com
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060803171731.GE20603@thunk.org>
References: <20060803163204.GB20603@thunk.org>
	<1154623598.19547.52.camel@c-67-188-28-158.hsd1.ca.comcast.net>
	<20060803171731.GE20603@thunk.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Tso <tytso@mit.edu>
Date: Thu, 3 Aug 2006 13:17:31 -0400

> The tg3_timer() code, for example, is trigger by the device driver but
> isn't associated with a process for boosting purposes, and creating a
> process just so that tg3_timer() can be boosted seems like the Wrong

Ted please make sure the tg3 chips you have actually do need
that periodic poking code that tg3_timer() has, most chips do
not.

You don't need the periodic poke unless TG3_FLAG_TAGGED_STATUS is
cleared, and that is only the case for two chips 1) 5700 and 2) 5788.

The only thing left is the link status and that is not so concerned
about mild forms of latency in the timer firing.
