Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270138AbRHGH4S>; Tue, 7 Aug 2001 03:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270137AbRHGH4J>; Tue, 7 Aug 2001 03:56:09 -0400
Received: from qn-212-127-137-79.quicknet.nl ([212.127.137.79]:15232 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id <S270136AbRHGH4B>;
	Tue, 7 Aug 2001 03:56:01 -0400
Date: Tue, 7 Aug 2001 09:55:37 +0200
From: "Carlo E. Prelz" <fluido@fluido.as>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: 2.4.7ac8: small patch needed
Message-ID: <20010807095537.A542@qn-212-127-137-79.fluido.as>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E2ED@ausxmrr501.us.dell.com> <20010502150202.B1283@qn-212-127-137-79.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010502150202.B1283@qn-212-127-137-79.fluido.as>; from fluido@fluido.as on Wed, May 02, 2001 at 03:02:02PM +0200
X-operating-system: Linux qn-212-127-137-79 2.4.7-ac7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. In order to compile 2.4.7ac8 I needed to apply this small
patch, otherwise it would not find function shmem_set_size:

--- shmem.c~    Tue Aug  7 07:17:36 2001
+++ shmem.c     Tue Aug  7 08:56:41 2001
@@ -1419,9 +1419,11 @@
        }
        shm_mnt = res;

+#ifdef CONFIG_TMPFS
        /* The internal instance should not do size checking */
        if ((error = shmem_set_size(SHMEM_SB(res->mnt_sb), ULONG_MAX, ULONG_MAX)))
                printk (KERN_ERR "could not set limits on internal tmpfs\n");
+#endif

        return 0;
 }

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
