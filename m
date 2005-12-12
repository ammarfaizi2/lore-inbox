Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVLLEi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVLLEi3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVLLEi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:38:28 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50650
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751098AbVLLEiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:38:14 -0500
Date: Sun, 11 Dec 2005 20:38:09 -0800 (PST)
Message-Id: <20051211.203809.127057416.davem@davemloft.net>
To: akpm@osdl.org
Cc: paulmck@us.ibm.com, oleg@tv-sign.ru, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051211203226.4deafd59.akpm@osdl.org>
References: <439B24A7.E2508AAE@tv-sign.ru>
	<20051212031053.GA8748@us.ibm.com>
	<20051211203226.4deafd59.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 11 Dec 2005 20:32:26 -0800

> So foo_mb() in preemptible code is potentially buggy.
> 
> I guess we assume that a context switch accidentally did enough of the
> right types of barriers for things to work OK.

A trap ought to flush all memory operations.

There are some incredibly difficult memory error handling cases if the
cpu does not synchronize all pending memory operations when a trap
occurs.

Failing that, yes, to be absolutely safe we'd need to have some
explicit memory barrier in the context switch.
