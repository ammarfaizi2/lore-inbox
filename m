Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283420AbRK2V5f>; Thu, 29 Nov 2001 16:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283419AbRK2V50>; Thu, 29 Nov 2001 16:57:26 -0500
Received: from ns.suse.de ([213.95.15.193]:10247 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283415AbRK2V5I> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 16:57:08 -0500
To: linux-kernel@vger.kernel.org
Subject: LFCR instead of CRLF on serial console
X-Yow: I just put lots of the EGG SALAD in the SILK SOCKS --
From: Andreas Schwab <schwab@suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
Date: 29 Nov 2001 22:57:06 +0100
Message-ID: <jezo55utot.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial console code is printing LFCR at the end of the line instead of
CRLF.  While this makes no difference on a terminal(-emulator), most
editors and file viewers (including less) only recognize CRLF as DOS-style
end-of-line markers.

--- linux/drivers/char/serial.c	2001/11/16 14:23:08	1.1
+++ linux/drivers/char/serial.c	2001/11/16 14:23:35
@@ -5812,11 +5812,11 @@
 		 *	Send the character out.
 		 *	If a LF, also do CR...
 		 */
-		serial_out(info, UART_TX, *s);
 		if (*s == 10) {
-			wait_for_xmitr(info);
 			serial_out(info, UART_TX, 13);
+			wait_for_xmitr(info);
 		}
+		serial_out(info, UART_TX, *s);
 	}
 
 	/*

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
