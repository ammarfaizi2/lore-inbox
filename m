Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129569AbRBMB1E>; Mon, 12 Feb 2001 20:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129654AbRBMB0y>; Mon, 12 Feb 2001 20:26:54 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:15256 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129569AbRBMB0s>;
	Mon, 12 Feb 2001 20:26:48 -0500
Message-ID: <20010213092638.A11218@saw.sw.com.sg>
Date: Tue, 13 Feb 2001 09:26:38 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 + 2.2.18 + laptop problems
In-Reply-To: <20010211224033.G352@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=d6Gm4EdcadzBjdND
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010211224033.G352@zip.com.au>; from "CaT" on Sun, Feb 11, 2001 at 10:40:33PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii

On Sun, Feb 11, 2001 at 10:40:33PM +1100, CaT wrote:
[snip]
> Feb 11 22:30:18 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!

Please try the attached patch.
Actually, it's designed to solve another problem, but may be your one has the
same origin as that other.

Best regards
		Andrey

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=res

Index: eepro100.c
===================================================================
RCS file: /home/oursoft/eepro100/eepro100.c,v
retrieving revision 1.20.2.13
diff -u -r1.20.2.13 eepro100.c
--- eepro100.c	2000/09/14 04:41:58	1.20.2.13
+++ eepro100.c	2001/02/13 01:22:07
@@ -726,6 +726,7 @@
 	   This takes less than 10usec and will easily finish before the next
 	   action. */
 	outl(PortReset, ioaddr + SCBPort);
+	inl(ioaddr + SCBPort);
 	/* Honor PortReset timing. */
 	udelay(10);
 
@@ -814,6 +815,7 @@
 #endif  /* kernel_bloat */
 
 	outl(PortReset, ioaddr + SCBPort);
+	inl(ioaddr + SCBPort);
 	/* Honor PortReset timing. */
 	udelay(10);
 
@@ -1037,6 +1039,9 @@
 	/* Set the segment registers to '0'. */
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outl(0, ioaddr + SCBPointer);
+	/* impose a delay to avoid a bug */
+	inl(ioaddr + SCBPointer);
+	udelay(10);
 	outb(RxAddrLoad, ioaddr + SCBCmd);
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outb(CUCmdBase, ioaddr + SCBCmd);
@@ -1298,6 +1303,7 @@
 		end_bh_atomic();
 		/* Reset the Tx and Rx units. */
 		outl(PortReset, ioaddr + SCBPort);
+		inl(ioaddr + SCBPort);
 		/* We may get spurious interrupts here.  But I don't think that they
 		   may do much harm.  1999/12/09 SAW */
 		udelay(10);

--d6Gm4EdcadzBjdND--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
