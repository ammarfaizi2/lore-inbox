Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSJVVVL>; Tue, 22 Oct 2002 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264759AbSJVVVL>; Tue, 22 Oct 2002 17:21:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264649AbSJVVVK>;
	Tue, 22 Oct 2002 17:21:10 -0400
Date: Tue, 22 Oct 2002 22:27:19 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: [PATCH] use 1ULL instead of 1UL in kernel/signal.c
Message-ID: <20021022222719.H27461@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On PA-RISC we have 36 signals defined for hpux compatibility.  So M()
and T() in kernel/signal.c try to do (1UL << 33) which is garbage on 32-bit
architectures.  How do people feel about this patch?

--- kernel/signal.c     21 Oct 2002 03:46:14 -0000      1.5
+++ kernel/signal.c     22 Oct 2002 21:25:29 -0000
@@ -96,7 +96,7 @@ int max_queued_signals = 1024;
 #define M_SIGEMT       0
 #endif
 
-#define M(sig) (1UL << (sig))
+#define M(sig) (1ULL << (sig))
 
 #define SIG_USER_SPECIFIC_MASK (\
        M(SIGILL)    |  M(SIGTRAP)   |  M(SIGABRT)   |  M(SIGBUS)    | \
@@ -132,7 +132,7 @@ int max_queued_signals = 1024;
         M(SIGXCPU)   |  M(SIGXFSZ)   |  M_SIGEMT                     )
 
 #define T(sig, mask) \
-       ((1UL << (sig)) & mask)
+       ((1ULL << (sig)) & mask)
 
 #define sig_user_specific(sig) \
                (((sig) < SIGRTMIN)  && T(sig, SIG_USER_SPECIFIC_MASK))

(patch copied & pasted; whitespace is munged.  This is an indication I
expect to get some pushback on this issue ;-)

-- 
Revolutions do not require corporate support.
