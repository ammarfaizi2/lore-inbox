Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310219AbSCFWU6>; Wed, 6 Mar 2002 17:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310227AbSCFWUi>; Wed, 6 Mar 2002 17:20:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13198 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310219AbSCFWUg>;
	Wed, 6 Mar 2002 17:20:36 -0500
Date: Wed, 06 Mar 2002 14:18:09 -0800 (PST)
Message-Id: <20020306.141809.112819805.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: ionut@cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update for 2.4.19pre2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C8691C9.30FA3C29@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.44.0203061652050.31906-100000@age.cs.columbia.edu>
	<3C8691C9.30FA3C29@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Wed, 06 Mar 2002 17:01:45 -0500
   
   > And, in general, are there any other tricks one can do to speed up the PCI
   > transactions on non-x86 platforms? I'm still getting occasional overruns
   > on sparc64 (card receiving packets faster than it can push them over PCI),
   > which is somewhat disturbing..
   
   Dynamically tune your RX and TX DMA burst settings when you notice these
   conditions...  It is indeed possible to saturate PCI bus bandwidth.

On sparc64 you should set the burst settings to 64-byte read/write
bursts because the PCI chipset is going to disconnect you on 64-byte
boundaries anyways.  If the chip is bursting more than this, you
are wasting lots of PCI cycles with the retries done after the
disconnect.

Also make sure to use PCI READ MULTIPLE commands for DMA if the chip
provides such an option, this helps performance on many PCI
controllers to no end.
