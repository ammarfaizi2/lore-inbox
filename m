Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWHHWKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWHHWKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWHHWKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:10:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56481
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030317AbWHHWKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:10:16 -0400
Date: Tue, 08 Aug 2006 15:10:20 -0700 (PDT)
Message-Id: <20060808.151020.94555184.davem@davemloft.net>
To: a.p.zijlstra@chello.nl
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       phillips@google.com
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060808193345.1396.16773.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	<20060808193345.1396.16773.sendpatchset@lappy>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think the new atomic operation that will seemingly occur on every
device SKB free is unacceptable.

You also cannot modify netdev->flags in the lockless manner in which
you do, it must be done with the appropriate locking, such as holding
the RTNL semaphore.
