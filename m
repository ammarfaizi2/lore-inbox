Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269045AbUIHQs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269045AbUIHQs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269060AbUIHQs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:48:59 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:62342 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269045AbUIHQs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:48:56 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: 2.6.8.1 mempool subsystem sickness
Date: Wed, 08 Sep 2004 16:48:54 +0000
Message-Id: <090820041648.7817.413F37F600049F4800001E892200762302970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with 4GB of memory, and without 
the user space patch that spilts user space
just a stock kernel, I am seeing memory 
allocation failures with X server and simple
apps on a machine with a Pentium 4 
processor and 500MB of memory.  

If you load large apps and do a lot of 
skb traffic, the mempool abd slab 
caches start gobbling up pages
and don't seem to balance them 
very well, resulting in memory 
allocation failures over time if
the system stays up for a week 
or more.  

I am also seeing the same behavior 
on another system which has been
running for almost 30 days with 
an skb based traffic regeneration 
test calling and sending skb's
in kernel between two interfaces.

The pages over time get stuck 
in the slab allocator and user
space apps start to fail on alloc
requests.  

Rebooting the system clears
the problem, which slowly over time
comes back.  I am seeing this with
stock kernels from kernel.org 
and on kernels I have patched,
so the problem seems to be
in the base code.  I have spent
the last two weeks observing 
the problem to verify I can
reproduce it and it keeps 
happening.  

Jeff

