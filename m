Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSLBIXG>; Mon, 2 Dec 2002 03:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbSLBIXG>; Mon, 2 Dec 2002 03:23:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20416 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265708AbSLBIXF>;
	Mon, 2 Dec 2002 03:23:05 -0500
Date: Mon, 02 Dec 2002 00:28:15 -0800 (PST)
Message-Id: <20021202.002815.58826951.davem@redhat.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p737kesu9bt.fsf@oldwotan.suse.de>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com.suse.lists.linux.kernel>
	<1038804400.4411.4.camel@rth.ninka.net.suse.lists.linux.kernel>
	<p737kesu9bt.fsf@oldwotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 02 Dec 2002 09:13:58 +0100
   
   Random sample (with .ehframe stripped):
   
   64bit ls:
   -rwxr-xr-x    1 root     root        76672 Oct 25 05:59 /bin/ls
     text    data     bss     dec     hex filename
     64847    7752    1136   73735   12007 /bin/ls
   
   32bit ls: 
   -rwxr-xr-x    1 root     root        68524 2002-09-09 22:56 /bin/ls
     text    data     bss     dec     hex filename
     65353    1112     872   67337   10709 /bin/ls
   
   [< 1K .text growth, some .data growth due to 64bit pointers]

The data is where I'd say the bloat would be, and lo and behold is a
nearly 7-fold increase for the sample you give us _only_ in the .data
section.

This doesn't even include dynamically allocated data structures,
things that sit on the stack, etc.

I can definitely see the text staying roughly the same, that's not the
big cost, it's the larger data structures.

BTW, I bet your dynamic relocation tables are a bit larger too.
