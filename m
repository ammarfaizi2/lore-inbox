Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266866AbUAXFJN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 00:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266865AbUAXFJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 00:09:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22710 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266862AbUAXFJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 00:09:02 -0500
Date: Fri, 23 Jan 2004 21:00:23 -0800 (PST)
Message-Id: <20040123.210023.74723544.davem@redhat.com>
To: grundler@parisc-linux.org
Cc: jgarzik@pobox.lackof.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040124013614.GB1310@colo.lackof.org>
References: <20040124013614.GB1310@colo.lackof.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Grant Grundler <grundler@parisc-linux.org>
   Date: Fri, 23 Jan 2004 18:36:14 -0700

   3) Broadcom engineer noted the meaning of DMA_RWCTRL_ASSERT_ALL_BE
      has changed for bcm570[34] and also advised against setting
      it on BCM570[01] chips. I'm just implementing his advice.
      Comment below spells out more details.

Setting this bit is absolutely required on many RISC PCI boxes, where
streaming mappings must have cacheline sized DMA transactions done
on them with all byte enables on.

In fact, since the later chips don't allow controlling this, some of
them cause streaming byte hole errors on sparc64 and other RISC
systems when they do cacheline sized DMA to streaming DMA mappings
with not all the byte enables on.

So I'm not going to add this part of your changes.
