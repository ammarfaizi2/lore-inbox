Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbQLNLun>; Thu, 14 Dec 2000 06:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbQLNLuY>; Thu, 14 Dec 2000 06:50:24 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:18953 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130493AbQLNLuR>; Thu, 14 Dec 2000 06:50:17 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Atsuhiro Kojima <ark@center.osakafu-u.ac.jp>
Date: Thu, 14 Dec 2000 22:19:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14904.44216.352364.618062@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: failed in BUG() at fs/buffer.c:765
In-Reply-To: message from Atsuhiro Kojima on Thursday December 14
In-Reply-To: <20001214191242E.ark@center.osakafu-u.ac.jp>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 14, ark@center.osakafu-u.ac.jp wrote:
> Dear kernel maintainers,
> I will report my problem around 2.4.0-test kernel.
> 
> Thanks in advance.

The simplest fix for this is the patch below.  Exactly what will get
into test13 has not yet been decided.

NeilBrown

--- drivers/md/raid5.c	2000/12/13 00:13:54	1.1
+++ drivers/md/raid5.c	2000/12/13 00:14:07
@@ -1009,6 +1009,7 @@
 	struct buffer_head *bh;
 	int method1 = INT_MAX, method2 = INT_MAX;
 
+#if 0
 	/*
 	 * Attempt to add entries :-)
 	 */
@@ -1039,6 +1040,7 @@
 			atomic_dec(&bh->b_count);
 		}
 	}
+#endif
 	PRINTK("handle_stripe() -- begin writing, stripe %lu\n", sh->sector);
 	/*
 	 * Writing, need to update parity buffer.
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
