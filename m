Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSD1M01>; Sun, 28 Apr 2002 08:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSD1M00>; Sun, 28 Apr 2002 08:26:26 -0400
Received: from ns.suse.de ([213.95.15.193]:6148 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310190AbSD1M0Z>;
	Sun, 28 Apr 2002 08:26:25 -0400
To: Bryan Rittmeyer <bryan@ixiacom.com>
Cc: warchild@spoofed.org, linux-kernel@vger.kernel.org
Subject: Re: remote memory reading using arp?
In-Reply-To: <20020427202756.GC6240@spoofed.org.suse.lists.linux.kernel> <3CCB0EAB.9050602@ixiacom.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Apr 2002 14:26:24 +0200
Message-ID: <p73znzom2kv.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Rittmeyer <bryan@ixiacom.com> writes:

> It's not the ARP layer that's causing the padding... Ethernet has a
> minimum transmit size of 64 bytes (everything below that is disgarded
> by hardware as a fragment), so the network device driver or
> the hardware itself will pad any Linux skb smaller than 60 bytes up to
> that size (so that it's 64 bytes after appending CRC32). Apparently, in
> some cases that's done by just transmitting whatever uninitialized
> memory follows skb->data, which, after the system has been running
> for a while, may be inside a page previously used by userspace.

The driver should be fixed in that case. I would consider it a driver
bug. The cost of clearing the tail should be minimal, it is at most
two cache lines.

Is it known which driver caused this?

> 
> This is NOT a "remote memory reading" exploit, since there is no way to

It really is. 


-Andi
