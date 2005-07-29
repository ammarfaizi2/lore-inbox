Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVG2TDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVG2TDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVG2TBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:01:49 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:30726 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S262731AbVG2TBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:01:44 -0400
Date: Fri, 29 Jul 2005 15:01:39 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Mickey Stein <yekkim@pacbell.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.13-rc4
In-Reply-To: <42EA1C8D.8080708@pacbell.net>
Message-ID: <Pine.LNX.4.61.0507291456550.2566@lancer.cnet.absolutedigital.net>
References: <42EA1C8D.8080708@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Mickey Stein wrote:

> This is regarding *-rc4 and *-rc4-git1:  I slapped together my favorite config
> and gave it a test run. It had a bit of a problem and ground to a halt after
> spewing these into the log.
> 
> If I can find the time tomorrow morning, I'll leave parport_pc commented out
> of modprobe.conf and see if something else pops loose. I don't use the
> parallel port, but I try to keep a fairly robust config for noticing bugs.

Hi Mick,

Can you please try the patch below from Linus (or -git2 tomorrow) and 
confirm that it fixes it for you?

thx,
-cp

--- a/include/asm-i386/bitops.h
+++ b/include/asm-i386/bitops.h
@@ -335,14 +335,13 @@ static inline unsigned long __ffs(unsign
 static inline int find_first_bit(const unsigned long *addr, unsigned size)
 {
 	int x = 0;
-	do {
-		if (*addr)
-			return __ffs(*addr) + x;
-		addr++;
-		if (x >= size)
-			break;
+
+	while (x < size) {
+		unsigned long val = *addr++;
+		if (val)
+			return __ffs(val) + x;
 		x += (sizeof(*addr)<<3);
-	} while (1);
+	}
 	return x;
 }
 
-- 
"Democracy can learn some things from Communism; for example,
   when a Communist politician is through, he is through."
                        -- Unknown
