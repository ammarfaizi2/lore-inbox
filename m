Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUHSJs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUHSJs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUHSJs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:48:26 -0400
Received: from [80.188.250.22] ([80.188.250.22]:45004 "EHLO
	thinkpad.gardas.net") by vger.kernel.org with ESMTP id S264791AbUHSJrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:47:08 -0400
Date: Thu, 19 Aug 2004 11:46:53 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.gardas.net
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IBM T22/APM suspend does not work with yenta_socket module loaded
 on 2.6.8.1
In-Reply-To: <20040819103006.D546@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.43.0408191145510.1006-100000@thinkpad.gardas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Russell King wrote:

> Argh, sorry, it didn't take effect.  You need:
>
> echo -e '3\0' > /sys/class/pcmcia_socket/pcmcia_socket0/device/power/state
> echo -e '3\0' > /sys/class/pcmcia_socket/pcmcia_socket1/device/power/state
>
> I forgot that sysfs is fussy when it comes to parsing numbers. ;(

I hope I have not make any mistake, but diff seems to be pretty bigger:

--- suspend-works.txt	Thu Aug 19 11:09:43 2004
+++ suspend-does-not-work-sockets-suspended2.txt	Thu Aug 19 11:44:54 2004
@@ -24,47 +24,47 @@
   Device control                 [92] : 0x66
   Diagnostic                     [93] : 0x40
   -- cardbus registers
-  CB_SOCKET_EVENT                [00] : 0x00000000
-  CB_SOCKET_MASK                 [04] : 0x00000000
-  CB_SOCKET_STATE                [08] : 0x30000006
-  CB_SOCKET_FORCE                [0c] : 0x00000000
-  CB_SOCKET_CONTROL              [10] : 0x00000000
-  CB_SOCKET_POWER                [20] : 0x00000000
+  CB_SOCKET_EVENT                [00] : 0xffffffff
+  CB_SOCKET_MASK                 [04] : 0xffffffff
+  CB_SOCKET_STATE                [08] : 0xffffffff
+  CB_SOCKET_FORCE                [0c] : 0xffffffff
+  CB_SOCKET_CONTROL              [10] : 0xffffffff
+  CB_SOCKET_POWER                [20] : 0xffffffff
   -- exca registers
-  I365_IDENT                     [00] : 0x84
-  I365_STATUS                    [01] : 0x00
-  I365_POWER                     [02] : 0x00
-  I365_INTCTL                    [03] : 0x50
-  I365_CSC                       [04] : 0x00
-  I365_CSCINT                    [05] : 0x00
-  I365_ADDRWIN                   [06] : 0x00
-  I365_IOCTL                     [07] : 0x00
-  I365_GENCTL                    [16] : 0x00c0
-  I365_GBLCTL                    [1e] : 0x0000
-  I365_IO0_START                 [08] : 0x0000
-  I365_IO0_STOP                  [0a] : 0x0001
-  I365_IO1_START                 [0c] : 0x0000
-  I365_IO1_STOP                  [0e] : 0x0001
-  I365_MEM0_START                [10] : 0x0000
-  I365_MEM0_STOP                 [12] : 0x0000
-  I365_MEM0_OFF                  [14] : 0x0000
-  I365_MEM0_PAGE                 [40] : 0x00
-  I365_MEM1_START                [18] : 0x0000
-  I365_MEM1_STOP                 [1a] : 0x0000
-  I365_MEM1_OFF                  [1c] : 0x0000
-  I365_MEM1_PAGE                 [41] : 0x00
-  I365_MEM2_START                [20] : 0x0000
-  I365_MEM2_STOP                 [22] : 0x0000
-  I365_MEM2_OFF                  [24] : 0x0000
-  I365_MEM2_PAGE                 [42] : 0x00
-  I365_MEM3_START                [28] : 0x0000
-  I365_MEM3_STOP                 [2a] : 0x0000
-  I365_MEM3_OFF                  [2c] : 0x0000
-  I365_MEM3_PAGE                 [43] : 0x00
-  I365_MEM4_START                [30] : 0x0000
-  I365_MEM4_STOP                 [32] : 0x0000
-  I365_MEM4_OFF                  [34] : 0x0000
-  I365_MEM4_PAGE                 [44] : 0x00
+  I365_IDENT                     [00] : 0xff
+  I365_STATUS                    [01] : 0xff
+  I365_POWER                     [02] : 0xff
+  I365_INTCTL                    [03] : 0xff
+  I365_CSC                       [04] : 0xff
+  I365_CSCINT                    [05] : 0xff
+  I365_ADDRWIN                   [06] : 0xff
+  I365_IOCTL                     [07] : 0xff
+  I365_GENCTL                    [16] : 0xffff
+  I365_GBLCTL                    [1e] : 0xffff
+  I365_IO0_START                 [08] : 0xffff
+  I365_IO0_STOP                  [0a] : 0xffff
+  I365_IO1_START                 [0c] : 0xffff
+  I365_IO1_STOP                  [0e] : 0xffff
+  I365_MEM0_START                [10] : 0xffff
+  I365_MEM0_STOP                 [12] : 0xffff
+  I365_MEM0_OFF                  [14] : 0xffff
+  I365_MEM0_PAGE                 [40] : 0xff
+  I365_MEM1_START                [18] : 0xffff
+  I365_MEM1_STOP                 [1a] : 0xffff
+  I365_MEM1_OFF                  [1c] : 0xffff
+  I365_MEM1_PAGE                 [41] : 0xff
+  I365_MEM2_START                [20] : 0xffff
+  I365_MEM2_STOP                 [22] : 0xffff
+  I365_MEM2_OFF                  [24] : 0xffff
+  I365_MEM2_PAGE                 [42] : 0xff
+  I365_MEM3_START                [28] : 0xffff
+  I365_MEM3_STOP                 [2a] : 0xffff
+  I365_MEM3_OFF                  [2c] : 0xffff
+  I365_MEM3_PAGE                 [43] : 0xff
+  I365_MEM4_START                [30] : 0xffff
+  I365_MEM4_STOP                 [32] : 0xffff
+  I365_MEM4_OFF                  [34] : 0xffff
+  I365_MEM4_PAGE                 [44] : 0xff

 00:02.0 CardBus bridge: Texas Instruments PCI1450
   -- generic cardbus config registers
@@ -92,45 +92,45 @@
   Device control                 [92] : 0x66
   Diagnostic                     [93] : 0x40
   -- cardbus registers
-  CB_SOCKET_EVENT                [00] : 0x00000000
-  CB_SOCKET_MASK                 [04] : 0x00000000
-  CB_SOCKET_STATE                [08] : 0x30000006
-  CB_SOCKET_FORCE                [0c] : 0x00000000
-  CB_SOCKET_CONTROL              [10] : 0x00000000
-  CB_SOCKET_POWER                [20] : 0x00000000
+  CB_SOCKET_EVENT                [00] : 0xffffffff
+  CB_SOCKET_MASK                 [04] : 0xffffffff
+  CB_SOCKET_STATE                [08] : 0xffffffff
+  CB_SOCKET_FORCE                [0c] : 0xffffffff
+  CB_SOCKET_CONTROL              [10] : 0xffffffff
+  CB_SOCKET_POWER                [20] : 0xffffffff
   -- exca registers
-  I365_IDENT                     [00] : 0x84
-  I365_STATUS                    [01] : 0x00
-  I365_POWER                     [02] : 0x00
-  I365_INTCTL                    [03] : 0x50
-  I365_CSC                       [04] : 0x00
-  I365_CSCINT                    [05] : 0x00
-  I365_ADDRWIN                   [06] : 0x00
-  I365_IOCTL                     [07] : 0x00
-  I365_GENCTL                    [16] : 0x00c0
-  I365_GBLCTL                    [1e] : 0x0000
-  I365_IO0_START                 [08] : 0x0000
-  I365_IO0_STOP                  [0a] : 0x0001
-  I365_IO1_START                 [0c] : 0x0000
-  I365_IO1_STOP                  [0e] : 0x0001
-  I365_MEM0_START                [10] : 0x0000
-  I365_MEM0_STOP                 [12] : 0x0000
-  I365_MEM0_OFF                  [14] : 0x0000
-  I365_MEM0_PAGE                 [40] : 0x00
-  I365_MEM1_START                [18] : 0x0000
-  I365_MEM1_STOP                 [1a] : 0x0000
-  I365_MEM1_OFF                  [1c] : 0x0000
-  I365_MEM1_PAGE                 [41] : 0x00
-  I365_MEM2_START                [20] : 0x0000
-  I365_MEM2_STOP                 [22] : 0x0000
-  I365_MEM2_OFF                  [24] : 0x0000
-  I365_MEM2_PAGE                 [42] : 0x00
-  I365_MEM3_START                [28] : 0x0000
-  I365_MEM3_STOP                 [2a] : 0x0000
-  I365_MEM3_OFF                  [2c] : 0x0000
-  I365_MEM3_PAGE                 [43] : 0x00
-  I365_MEM4_START                [30] : 0x0000
-  I365_MEM4_STOP                 [32] : 0x0000
-  I365_MEM4_OFF                  [34] : 0x0000
-  I365_MEM4_PAGE                 [44] : 0x00
+  I365_IDENT                     [00] : 0xff
+  I365_STATUS                    [01] : 0xff
+  I365_POWER                     [02] : 0xff
+  I365_INTCTL                    [03] : 0xff
+  I365_CSC                       [04] : 0xff
+  I365_CSCINT                    [05] : 0xff
+  I365_ADDRWIN                   [06] : 0xff
+  I365_IOCTL                     [07] : 0xff
+  I365_GENCTL                    [16] : 0xffff
+  I365_GBLCTL                    [1e] : 0xffff
+  I365_IO0_START                 [08] : 0xffff
+  I365_IO0_STOP                  [0a] : 0xffff
+  I365_IO1_START                 [0c] : 0xffff
+  I365_IO1_STOP                  [0e] : 0xffff
+  I365_MEM0_START                [10] : 0xffff
+  I365_MEM0_STOP                 [12] : 0xffff
+  I365_MEM0_OFF                  [14] : 0xffff
+  I365_MEM0_PAGE                 [40] : 0xff
+  I365_MEM1_START                [18] : 0xffff
+  I365_MEM1_STOP                 [1a] : 0xffff
+  I365_MEM1_OFF                  [1c] : 0xffff
+  I365_MEM1_PAGE                 [41] : 0xff
+  I365_MEM2_START                [20] : 0xffff
+  I365_MEM2_STOP                 [22] : 0xffff
+  I365_MEM2_OFF                  [24] : 0xffff
+  I365_MEM2_PAGE                 [42] : 0xff
+  I365_MEM3_START                [28] : 0xffff
+  I365_MEM3_STOP                 [2a] : 0xffff
+  I365_MEM3_OFF                  [2c] : 0xffff
+  I365_MEM3_PAGE                 [43] : 0xff
+  I365_MEM4_START                [30] : 0xffff
+  I365_MEM4_STOP                 [32] : 0xffff
+  I365_MEM4_OFF                  [34] : 0xffff
+  I365_MEM4_PAGE                 [44] : 0xff


Is this what you expect?

Thanks,

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com

