Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290839AbSARVev>; Fri, 18 Jan 2002 16:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290837AbSARVep>; Fri, 18 Jan 2002 16:34:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35222 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290839AbSARVec>;
	Fri, 18 Jan 2002 16:34:32 -0500
Date: Fri, 18 Jan 2002 13:33:06 -0800 (PST)
Message-Id: <20020118.133306.118980313.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: dan@embeddededge.com, hozer@drgw.net, linux-kernel@vger.kernel.org,
        groudier@free.fr, mattl@mvista.com
Subject: Re: pci_alloc_consistent from interrupt == BAD
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020118212949.H2059@flint.arm.linux.org.uk>
In-Reply-To: <3C4875DB.9080402@embeddededge.com>
	<20020118.123221.85715153.davem@redhat.com>
	<20020118212949.H2059@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Fri, 18 Jan 2002 21:29:49 +0000
   
   However, if it becomes easy to implement without impacting the code too
   much, then it will get fixed in due coarse.  The problem currently is
   that there is no way for the page table allocation functions to know
   that they should be using atomic and emergency pool memory allocations.

Encapsultate the page table allocation core interfaces into
__whatever_alloc() routines that take a GFP arg perhaps?
It is like a 15 minute hack.

BTW, the USB host controller drivers do this (allocate potentially
from interrupts) so anyone using USB on ARM...
