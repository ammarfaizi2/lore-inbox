Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268022AbRHBAdq>; Wed, 1 Aug 2001 20:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbRHBAdg>; Wed, 1 Aug 2001 20:33:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62220 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268022AbRHBAdT>; Wed, 1 Aug 2001 20:33:19 -0400
Subject: Re: Memory Write Ordering Question
To: jim@intra.blueskylabs.com (James W. Lake)
Date: Thu, 2 Aug 2001 01:35:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ("Linux Kernel Mailing List (E-mail)")
In-Reply-To: <no.id> from "James W. Lake" at Aug 01, 2001 11:44:10 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15S6S7-00087H-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm wondering if anyone has any idea what exactly is causing this.  The
> readl is a so-so work around.  I'd like to figure out how to do it
> correctly.  Does anyone who knows more about Intel CPU's and write
> ordering and PCI have any ideas?

Its entirely a PCI issue. PCI writes are posted and may be deferred. However
a write cannot pass another write to the device, nor a read, so your read
is the real solution.

The full horror is in the PCI specs which you can get on CD nowdays fairly
sanely. Basically PCI is a message passing system disguised as a bus, treat
it as the former and you wont get too badly hurt
