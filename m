Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129806AbRABCcF>; Mon, 1 Jan 2001 21:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRABCbz>; Mon, 1 Jan 2001 21:31:55 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:22266 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S129806AbRABCbr>; Mon, 1 Jan 2001 21:31:47 -0500
Date: Mon, 1 Jan 2001 18:00:53 -0800
From: Chip Salzenberg <chip@valinux.com>
To: "Theodore Ts'o" <tytso@valinux.com>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: [PATCH] Re: FAIL: 2.2.18 + AA-VM-global-7 + serial 5.05
Message-ID: <20010101180053.D6010@valinux.com>
In-Reply-To: <20001222154757.A1167@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <20001222154757.A1167@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Fri, Dec 22, 2000 at 03:47:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Matthias Andree:
> I have a vanilla 2.2.18 that I patch Andrea Arcangeli's VM-global-7
> patch (for 2.2.18pre25) on top, as well as I²C 2.5.4, the current
> --12-09 IDE.2.2.18 patch and ReiserFS 3.5.28. So far, so good. If I now
> patch serial 5.05 on top of that, the kernel itself detects devices, but
> does nothing if it's to boot /sbin/init. ctrl-alt-del and Magic SysRq
> are both functional and can reboot the machine.

VA's current kernel includes VM-global and serial-5.05 (and lots of
other stuff :-)).  The only problem we had with serial-5.05 was its
2.2/2.4 compatibility code getting confused because 2.2.18 has more
of 2.4's init macros available.  Try this:

Index: tty_io.c
===================================================================
RCS file: /cvs/valinux/kernel/linux/drivers/char/tty_io.c,v
retrieving revision 1.2
retrieving revision 1.2.12.1
diff -u -2 -p -r1.2 -r1.2.12.1
--- tty_io.c	2000/08/30 21:33:27	1.2
+++ tty_io.c	2000/09/28 08:21:34	1.2.12.1
@@ -2185,7 +2185,4 @@ __initfunc(int tty_init(void))
 	espserial_init();
 #endif
-#ifdef CONFIG_SERIAL
-	rs_init();
-#endif
 #ifdef CONFIG_COMPUTONE
 	ip2_init();

-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
