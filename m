Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129237AbQJ2QxB>; Sun, 29 Oct 2000 11:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQJ2Qwl>; Sun, 29 Oct 2000 11:52:41 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:9487 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129230AbQJ2Qwa>; Sun, 29 Oct 2000 11:52:30 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27070@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Multiple warnings when compiling network driver in 2.4.0-test9
Date: Sun, 29 Oct 2000 08:52:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While trying to compile a network driver for 2.4.0-test9 (+kdb-v1.5,
configured for UP) I'm getting multiple warnings:
	/usr/src/linux/include/linux/sched.h:700: warning: can't inline call
to `__mmdrop'
	/usr/src/linux/include/linux/sched.h:704: warning: called from here

This happens for every kernel header I try to use such  as netdevice.h,
skbuff.h, malloc.h and pci.h
Each of those header files includes slab.h (line 14) that includes mm.h
(line 4) that includes sched.h which contains the following on line 700:

700:	extern inline void FASTCALL(__mmdrop(struct mm_struct *));
701:	static inline void mmdrop(struct mm_struct * mm)
702:	{
703:		if (atomic_dec_and_test(&mm->mm_count))
704:			__mmdrop(mm);
705:	}

My make file uses the following flags:
gcc -fomit-frame-pointer -Wall  -Wstrict-prototypes -Winline -O3
-D__KERNEL__ -DMODULE  -DDEBUG  -DMODVERSIONS -I/usr/src/linux/include

Can anyone tell me what this warning means and if I can safely ignore it (or
expect disaster) ?


	Thanks,

	Shmulik Hen,
      	Software Engineer
	Linux Advanced Networking Services
	Network Communications Group, Israel (NCGj)
	Intel Corporation Ltd.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
