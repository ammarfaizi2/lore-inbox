Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVKJQxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVKJQxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVKJQxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:53:39 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:61328 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S1750760AbVKJQxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:53:39 -0500
Message-Id: <200511101600.jAAG0dx6012233@cmf.nrl.navy.mil>
To: Dave Jones <davej@redhat.com>, davem@davemloft.net
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Reply-To: chas3@users.sourceforge.net
Subject: Re: fix sparse warning in horizon atm driver. 
In-reply-to: <20051109055739.GA630@redhat.com> 
Date: Thu, 10 Nov 2005 11:00:39 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20051109055739.GA630@redhat.com>,Dave Jones writes:
>these vars get fed u32's, and are OR'd with u32's.
>Chances are they were meant to be u32's.
>
>I don't have hardware to test this, but I can't fathom
>why a u16 would be used here.

i guess someone got confused over BUFFER_PTR_MASK.  this patch 
looks fine to me.


[ATM]: [horizon] fix sparse warnings

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Chas Williams <cmas@cmf.nrl.navy.mil>

--- linus/drivers/atm/horizon.c~	2005-11-09 00:51:50.000000000 -0500
+++ linus/drivers/atm/horizon.c	2005-11-09 00:55:36.000000000 -0500
@@ -1511,8 +1511,8 @@ static inline short setup_idle_tx_channe
     // a.k.a. prepare the channel and remember that we have done so.
     
     tx_ch_desc * tx_desc = &memmap->tx_descs[tx_channel];
-    u16 rd_ptr;
-    u16 wr_ptr;
+    u32 rd_ptr;
+    u32 wr_ptr;
     u16 channel = vcc->channel;
     
     unsigned long flags;
