Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285128AbRLQNUN>; Mon, 17 Dec 2001 08:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280027AbRLQNUD>; Mon, 17 Dec 2001 08:20:03 -0500
Received: from sun.fadata.bg ([80.72.64.67]:6149 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S279798AbRLQNTu>;
	Mon, 17 Dec 2001 08:19:50 -0500
To: Jan-Benedict Glaw <jbglaw@microdata-pos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xchg and GCC's optimisation:-(
In-Reply-To: <20011217134526.A31801@microdata-pos.de>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20011217134526.A31801@microdata-pos.de>
Date: 17 Dec 2001 15:18:45 +0200
Message-ID: <87wuzmq91m.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jan-Benedict" == Jan-Benedict Glaw <jbglaw@microdata-pos.de> writes:
Jan-Benedict> I've looked at ./include/asm-i386/system.h which does some black
Jan-Benedict> magic with it, and I don't really understand that. However, the
Jan-Benedict> result is that the xchg gets optimized away, rendering at least

Can you try with this patch ...

--- system.h.orig.0	Mon Dec 17 15:03:38 2001
+++ system.h	Mon Dec 17 15:16:58 2001
@@ -205,21 +205,15 @@ static inline unsigned long __xchg(unsig
 	switch (size) {
 		case 1:
 			__asm__ __volatile__("xchgb %b0,%1"
-				:"=q" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
+				     :"+q" (x),"=m" (*__xg(ptr)));
 			break;
 		case 2:
 			__asm__ __volatile__("xchgw %w0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
+				     :"+r" (x),"=m" (*__xg(ptr)));
 			break;
 		case 4:
 			__asm__ __volatile__("xchgl %0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
+				     :"+r" (x), "=m" (*__xg(ptr)));
 			break;
 	}
 	return x;
