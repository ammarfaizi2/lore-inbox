Return-Path: <linux-kernel-owner+w=401wt.eu-S933214AbWLaUhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933214AbWLaUhS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933213AbWLaUhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:37:17 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50111
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933211AbWLaUhQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:37:16 -0500
Date: Sun, 31 Dec 2006 12:37:15 -0800 (PST)
Message-Id: <20061231.123715.115911390.davem@davemloft.net>
To: daniel.marjamaki@gmail.com
Cc: netdev@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core/flow.c: compare data with memcmp
From: David Miller <davem@davemloft.net>
In-Reply-To: <80ec54e90612310837y786fd764oc18bf37c8f0b2b8c@mail.gmail.com>
References: <80ec54e90612310837y786fd764oc18bf37c8f0b2b8c@mail.gmail.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel_Marjamäki" <daniel.marjamaki@gmail.com>
Date: Sun, 31 Dec 2006 17:37:05 +0100

> From: Daniel Marjamäki
> This has been tested by me.
> Signed-off-by: Daniel Marjamäki <daniel.marjamaki@gmail.com>

Please do not do this.

memcmp() cannot assume the alignment of the source and
destination buffers and thus will run more slowly than
that open-coded comparison.

That code was done like that on purpose because it is
one of the most critical paths in the networking flow
cache lookup which runs for every IPSEC packet going
throught the system.
