Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBWP7T>; Fri, 23 Feb 2001 10:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbRBWP7K>; Fri, 23 Feb 2001 10:59:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129108AbRBWP66>; Fri, 23 Feb 2001 10:58:58 -0500
Date: Fri, 23 Feb 2001 10:58:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1 network (socket) performance
In-Reply-To: <3A966FF1.2C9E5641@colorfullife.com>
Message-ID: <Pine.LNX.3.95.1010223104549.2101B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
The problem with awful socket performance on 2.4.1 has been discovered
and fixed by Manfred Spraul. Here is some info, and his patch:


On Fri, 23 Feb 2001, Manfred Spraul wrote:

> Could you post your results to linux-kernel?
> My mail from this morning wasn't accurate enough, you patched the wrong
> line. Sorry.

Yep. The patch you sent was a little broken. I tried to fix it, but
ended up pathing the wrong line.

> 
> I've attached the 2 patches that should cure your problems.
> patch-new is integrated into the -ac series, and it's a bugfix - simple
> unix socket sends eat into memory reserved for atomic allocs.
> patch-new2 is the other variant, it just deletes the fallback system.

--- linux/net/core/sock.c	Fri Dec 29 23:07:24 2000
+++ linux/net/core/sock.c.new	Fri Feb 23 15:02:46 2001
@@ -777,7 +777,7 @@
 				/* The buffer get won't block, or use the atomic queue.
 			 	* It does produce annoying no free page messages still.
 			 	*/
-				skb = alloc_skb(size, GFP_BUFFER);
+				skb = alloc_skb(size, sk->allocation & (~__GFP_WAIT));
 				if (skb)
 					break;
 				try_size = fallback;



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


