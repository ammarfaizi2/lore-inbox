Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSIEO2j>; Thu, 5 Sep 2002 10:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSIEO2j>; Thu, 5 Sep 2002 10:28:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52457 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317602AbSIEO2i>;
	Thu, 5 Sep 2002 10:28:38 -0400
Date: Thu, 05 Sep 2002 07:26:11 -0700 (PDT)
Message-Id: <20020905.072611.56130710.davem@redhat.com>
To: rsreelat@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch for IA64: fix do_sys32_msgrcv bad address error.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFFB350C4A.BB78D4E6-ON65256C2B.004CF605@in.ibm.com>
References: <OFFB350C4A.BB78D4E6-ON65256C2B.004CF605@in.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "R Sreelatha" <rsreelat@in.ibm.com>
   Date: Thu, 5 Sep 2002 19:46:40 +0530

   In sys_ia32.c file, in the do_sys32_msgrcv() function call,  the value of
   ipck.msgp is interpreted as a 64 bit address, whereas it is a 32 bit
   address.
   Hence, do_sys32_msgrcv() finally returns EFAULT(bad address) error.
   The patch below takes care of this by type casting ipck.msgp to type u32.
   The patch is created for 2.5.32 version of the kernel.
   
It's still broken.

Fix this instead by declaring ipc_kludge with the proper
32-bit types.  This is why the identical code works on
sparc64 for sparc32 emulation. :-)
