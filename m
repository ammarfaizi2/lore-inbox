Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317268AbSFCEoB>; Mon, 3 Jun 2002 00:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSFCEoA>; Mon, 3 Jun 2002 00:44:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50837 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317268AbSFCEoA>;
	Mon, 3 Jun 2002 00:44:00 -0400
Date: Sun, 02 Jun 2002 20:39:16 -0700 (PDT)
Message-Id: <20020602.203916.21926462.davem@redhat.com>
To: anton@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020603042727.GE2355@krispykreme>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Mon, 3 Jun 2002 14:27:27 +1000
   
   On ppc64 I found that pcibios_init was being called before
   pci_driver_init, maybe its happening on alpha too. I am using the
   following hack for the moment, I'll leave it to Patrick to fix it properly.
   
It's happening on every platform.  It should be done before
arch_initcalls actually, but after core_initcalls.  I would suggest to
rename unused_initcall into postcore_iniscall, then use it for this
and sys_bus_init which has the same problem.
