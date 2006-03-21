Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWCUHEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWCUHEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWCUHEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:04:11 -0500
Received: from xenotime.net ([66.160.160.81]:20674 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932241AbWCUHEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:04:11 -0500
Date: Mon, 20 Mar 2006 23:02:37 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] doc: more serial-console info.
Message-Id: <20060320230237.7dabf6bb.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add info on flow control for serial consoles.
Refer to netconsole option also.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kernel-parameters.txt |   15 ++++++++++-----
 Documentation/serial-console.txt    |   11 ++++++++---
 2 files changed, 18 insertions(+), 8 deletions(-)

--- linux-2616-work.orig/Documentation/kernel-parameters.txt
+++ linux-2616-work/Documentation/kernel-parameters.txt
@@ -366,12 +366,17 @@ running once the system is up.
 		tty<n>	Use the virtual console device <n>.
 
 		ttyS<n>[,options]
+		ttyUSB0[,options]
 			Use the specified serial port.  The options are of
-			the form "bbbbpn", where "bbbb" is the baud rate,
-			"p" is parity ("n", "o", or "e"), and "n" is bits.
-			Default is "9600n8".
-
-			See also Documentation/serial-console.txt.
+			the form "bbbbpnf", where "bbbb" is the baud rate,
+			"p" is parity ("n", "o", or "e"), "n" is number of
+			bits, and "f" is flow control ("r" for RTS or
+			omit it).  Default is "9600n8".
+
+			See Documentation/serial-console.txt for more
+			information.  See
+			Documentation/networking/netconsole.txt for an
+			alternative.
 
 		uart,io,<addr>[,options]
 		uart,mmio,<addr>[,options]
--- linux-2616-work.orig/Documentation/serial-console.txt
+++ linux-2616-work/Documentation/serial-console.txt
@@ -17,11 +17,13 @@ The format of this option is:
 			ttyX for any other virtual console
 			ttySx for a serial port
 			lp0 for the first parallel port
+			ttyUSB0 for the first USB serial device
 
 	options:	depend on the driver. For the serial port this
-			defines the baudrate/parity/bits of the port,
-			in the format BBBBPN, where BBBB is the speed,
-			P is parity (n/o/e), and N is bits. Default is
+			defines the baudrate/parity/bits/flow control of
+			the port, in the format BBBBPNF, where BBBB is the
+			speed, P is parity (n/o/e), N is number of bits,
+			and F is flow control ('r' for RTS). Default is
 			9600n8. The maximum baudrate is 115200.
 
 You can specify multiple console= options on the kernel command line.
@@ -45,6 +47,9 @@ become the console.
 You will need to create a new device to use /dev/console. The official
 /dev/console is now character device 5,1.
 
+(You can also use a network device as a console.  See
+Documentation/networking/netconsole.txt for information on that.)
+
 Here's an example that will use /dev/ttyS1 (COM2) as the console.
 Replace the sample values as needed.
 


---
