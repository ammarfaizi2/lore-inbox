Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSHHPlk>; Thu, 8 Aug 2002 11:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSHHPlk>; Thu, 8 Aug 2002 11:41:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21731 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317610AbSHHPlk>;
	Thu, 8 Aug 2002 11:41:40 -0400
Date: Thu, 08 Aug 2002 08:32:15 -0700 (PDT)
Message-Id: <20020808.083215.41828271.davem@redhat.com>
To: rkuhn@e18.physik.tu-muenchen.de
Cc: kwijibo@zianet.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208081431210.4739-100000@pc40.e18.physik.tu-muenchen.de>
References: <Pine.LNX.4.44.0208081029320.4709-100000@pc40.e18.physik.tu-muenchen.de>
	<Pine.LNX.4.44.0208081431210.4739-100000@pc40.e18.physik.tu-muenchen.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
   Date: Thu, 8 Aug 2002 14:39:56 +0200 (CEST)
   
   If I can do more to help sort this out, please tell me. With my fix to 
   prefix every write with a dummy read, the system is rock solid, not a 
   single glitch on 12 machines in the last 14 hours.
   
I'll figure out why this indirect register stuff isn't working.

   I'm very curious on how this all works, so would somebody please give me a 
   pointer where to start reading concerning linux and PCI 
   reordering/pci_write_config_dword?
   
The PCI controller might be illegally reordering PCI MEM space
accesses to the card's registers with asynchronous DMA activity.

If that is true, the explanation is that the PCI config space
accesses synchrnoize wrt. pending DMA operations the device is
doing.
