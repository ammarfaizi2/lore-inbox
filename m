Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbWHJM5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbWHJM5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWHJM5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:57:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52609
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161239AbWHJM5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:57:20 -0400
Date: Thu, 10 Aug 2006 05:57:11 -0700 (PDT)
Message-Id: <20060810.055711.56053014.davem@davemloft.net>
To: deweerdt@free.fr
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net,
       jet@gyve.org
Subject: Re: [patch] Use rwsems instead of custom locking scheme in
 net/socket.c and net/dccp/ccid.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060810121336.GB1462@slug>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<20060810121336.GB1462@slug>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederik Deweerdt <deweerdt@free.fr>
Date: Thu, 10 Aug 2006 14:13:36 +0200

> This patch aims at removing two implementations (spotted by Masatake YAMATO) of
> pseudo-rwlocks using a spinlock_t and an atomic_t. One in net/socket.c
> and another in net/bluetooth/af_bluetooth.c. I think that both could be
> converted to rwsems, saving some lines of code.

The net/socket.c one has been converted to RCU by Stephen
Hemminger already.

If the bluetooth case is in an important code path it should
use RCU as well.
