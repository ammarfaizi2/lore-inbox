Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSH0Goo>; Tue, 27 Aug 2002 02:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSH0Goo>; Tue, 27 Aug 2002 02:44:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31882 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315178AbSH0Gon>;
	Tue, 27 Aug 2002 02:44:43 -0400
Date: Mon, 26 Aug 2002 23:43:23 -0700 (PDT)
Message-Id: <20020826.234323.39328052.davem@redhat.com>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: readsw/writesw readsl/writesl
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10208262321150.24156-100000@master.linux-ide.org>
References: <20020826.231157.10296323.davem@redhat.com>
	<Pine.LNX.4.10.10208262321150.24156-100000@master.linux-ide.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andre Hedrick <andre@linux-ide.org>
   Date: Mon, 26 Aug 2002 23:23:22 -0700 (PDT)
   
   Would you consider these for each arch as there are coresponding one for
   IOMIO, and life would be better if we had a standard set for MMIO.
   
   Please consider the request.

I responded to the private email I got on this subject.
I forget who asked me this, but they said they were working
on this IDE stuff.

My response was that io_barrier() shall be defined on all
platforms in asm/io.h and that you can then define your
ide_read{l,w,b} as:

	__raw_raw{l,w,b}(...);
	io_barrier();

So instead of having a million read* variations, we have one that is
standard usage (little endian + I/O barrier) and then a raw variant
where the cpu does nothing special and you have to byte-twiddle and
barrier explicitly.
