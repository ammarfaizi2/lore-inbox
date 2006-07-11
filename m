Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWGKWHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWGKWHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWGKWHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:07:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57316
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932184AbWGKWHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:07:24 -0400
Date: Tue, 11 Jul 2006 15:08:10 -0700 (PDT)
Message-Id: <20060711.150810.13051231.davem@davemloft.net>
To: bos@serpentine.com
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
 keep cache pressure down
From: David Miller <davem@davemloft.net>
In-Reply-To: <1152655509.16499.49.camel@chalcedony.pathscale.com>
References: <1152653401.16499.35.camel@chalcedony.pathscale.com>
	<20060711.145751.77136364.davem@davemloft.net>
	<1152655509.16499.49.camel@chalcedony.pathscale.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@serpentine.com>
Date: Tue, 11 Jul 2006 15:05:08 -0700

> Well, exactly this scheme seems to work for __iowrite_copy*.  There's a
> weak generic version and a strong version in arch/x86_64/lib that
> overrides it, and it gets picked up at kernel link time.

It is linked in as an object, not into the library archive,
that's why that one works like that.

That is why io.o is added to the "obj-y" variable instead of the
"lib-y" variable.  It is also necessary to link these things
in as objects when module exports are present, because if there
is no in-kernel reference to the function, you won't get the
function nor it's module export :)
