Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280631AbRKGLys>; Wed, 7 Nov 2001 06:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280524AbRKGLyj>; Wed, 7 Nov 2001 06:54:39 -0500
Received: from [212.42.171.85] ([212.42.171.85]:2823 "EHLO
	mail.runtime-collective.com") by vger.kernel.org with ESMTP
	id <S280602AbRKGLyV>; Wed, 7 Nov 2001 06:54:21 -0500
Date: Wed, 7 Nov 2001 11:53:52 +0000
From: Berkan Eskikaya <berkan@runtime-collective.com>
To: Gerard Roudier <groudier@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sym53c8xx problem
Message-ID: <20011107115352.D22106@runtime-collective.com>
In-Reply-To: <20011106024430.A7893@cogs.susx.ac.uk> <20011106181733.C1653-100000@gerard>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20011106181733.C1653-100000@gerard>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gerard, 

Thanks for the explanation. The kernel we're running
has been patched for better Oracle performance. The
patch --attached to this mail-- effects SHMMAX, SHMMNI, 
SHMSEG, SEMMNI, SEMMSL, SEMMNS, SEMUME, SEMMNU, and SEMMAP; 
and I just saw a comment in include/asm-i386/shmparam.h 
saying not to touch the default SHMMAX because people 
depend on it.

Maybe this explains the mystery?

Cheers,

Berkan

--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.2.19-ora8i"

diff -ru linux/include/asm-i386/shmparam.h linux.ora8i/include/asm-i386/shmparam.h
--- linux/include/asm-i386/shmparam.h	Sun Mar 25 17:31:05 2001
+++ linux.ora8i/include/asm-i386/shmparam.h	Mon Oct  1 11:22:04 2001
@@ -33,14 +33,14 @@
  * SHMMAX <= (PAGE_SIZE << _SHM_IDX_BITS).
  */
 
-#define SHMMAX 0x2000000		/* max shared seg size (bytes) */
+#define SHMMAX 0x40000000		/* max shared seg size (bytes) */
 /* Try not to change the default shipped SHMMAX - people rely on it */
 
 #define SHMMIN 1 /* really PAGE_SIZE */	/* min shared seg size (bytes) */
-#define SHMMNI (1<<_SHM_ID_BITS)	/* max num of segs system wide */
+#define SHMMNI 200	/* max num of segs system wide */
 #define SHMALL				/* max shm system wide (pages) */ \
 	(1<<(_SHM_IDX_BITS+_SHM_ID_BITS))
 #define	SHMLBA PAGE_SIZE		/* attach addr a multiple of this */
-#define SHMSEG SHMMNI			/* max shared segs per process */
+#define SHMSEG 100			/* max shared segs per process */
 
 #endif /* _ASMI386_SHMPARAM_H */
diff -ru linux/include/linux/sem.h linux.ora8i/include/linux/sem.h
--- linux/include/linux/sem.h	Sun Mar 25 17:31:03 2001
+++ linux.ora8i/include/linux/sem.h	Mon Oct  1 11:22:44 2001
@@ -60,17 +60,17 @@
 	int semaem;
 };
 
-#define SEMMNI  128             /* ?  max # of semaphore identifiers */
-#define SEMMSL  250              /* <= 512 max num of semaphores per id */
-#define SEMMNS  (SEMMNI*SEMMSL) /* ? max # of semaphores in system */
+#define SEMMNI  256             /* ?  max # of semaphore identifiers */
+#define SEMMSL  256             /* <= 512 max num of semaphores per id */
+#define SEMMNS  2048            /* ? max # of semaphores in system */
 #define SEMOPM  32	        /* ~ 100 max num of ops per semop call */
 #define SEMVMX  32767           /* semaphore maximum value */
 
 /* unused */
-#define SEMUME  SEMOPM          /* max num of undo entries per process */
-#define SEMMNU  SEMMNS          /* num of undo structures system wide */
+#define SEMUME  10              /* max num of undo entries per process */
+#define SEMMNU  30              /* num of undo structures system wide */
 #define SEMAEM  (SEMVMX >> 1)   /* adjust on exit max value */
-#define SEMMAP  SEMMNS          /* # of entries in semaphore map */
+#define SEMMAP  10              /* # of entries in semaphore map */
 #define SEMUSZ  20		/* sizeof struct sem_undo */
 
 #ifdef __KERNEL__

--jho1yZJdad60DJr+--
