Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUHSJRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUHSJRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUHSJRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:17:03 -0400
Received: from [80.188.250.22] ([80.188.250.22]:21964 "EHLO
	thinkpad.gardas.net") by vger.kernel.org with ESMTP id S264500AbUHSJPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:15:37 -0400
Date: Thu, 19 Aug 2004 11:15:24 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.gardas.net
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IBM T22/APM suspend does not work with yenta_socket module loaded
 on 2.6.8.1
In-Reply-To: <20040819094702.A546@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.43.0408191113180.1006-100000@thinkpad.gardas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Russell King wrote:

> You could try grabbing the cbdump program from pcmcia.arm.linux.org.uk
> and trying to identify whether there's any differences in the register
> settings of the Cardbus bridges - between having no yenta module loaded
> and having yenta loaded with the sockets suspended using:
>
> echo 3 > /sys/class/pcmcia_socket/pcmcia_socket0/device/power/state
> echo 3 > /sys/class/pcmcia_socket/pcmcia_socket1/device/power/state
>
> (echo 0 to these files to resume the sockets.)

OK, diff is:

--- suspend-works.txt   Thu Aug 19 11:09:43 2004
+++ suspend-does-not-work-sockets-suspended.txt Thu Aug 19 11:12:20 2004
@@ -25,7 +25,7 @@
   Diagnostic                     [93] : 0x40
   -- cardbus registers
   CB_SOCKET_EVENT                [00] : 0x00000000
-  CB_SOCKET_MASK                 [04] : 0x00000000
+  CB_SOCKET_MASK                 [04] : 0x00000006
   CB_SOCKET_STATE                [08] : 0x30000006
   CB_SOCKET_FORCE                [0c] : 0x00000000
   CB_SOCKET_CONTROL              [10] : 0x00000000
@@ -36,7 +36,7 @@
   I365_POWER                     [02] : 0x00
   I365_INTCTL                    [03] : 0x50
   I365_CSC                       [04] : 0x00
-  I365_CSCINT                    [05] : 0x00
+  I365_CSCINT                    [05] : 0x08
   I365_ADDRWIN                   [06] : 0x00
   I365_IOCTL                     [07] : 0x00
   I365_GENCTL                    [16] : 0x00c0
@@ -93,7 +93,7 @@
   Diagnostic                     [93] : 0x40
   -- cardbus registers
   CB_SOCKET_EVENT                [00] : 0x00000000
-  CB_SOCKET_MASK                 [04] : 0x00000000
+  CB_SOCKET_MASK                 [04] : 0x00000006
   CB_SOCKET_STATE                [08] : 0x30000006
   CB_SOCKET_FORCE                [0c] : 0x00000000
   CB_SOCKET_CONTROL              [10] : 0x00000000
@@ -104,7 +104,7 @@
   I365_POWER                     [02] : 0x00
   I365_INTCTL                    [03] : 0x50
   I365_CSC                       [04] : 0x00
-  I365_CSCINT                    [05] : 0x00
+  I365_CSCINT                    [05] : 0x08
   I365_ADDRWIN                   [06] : 0x00
   I365_IOCTL                     [07] : 0x00
   I365_GENCTL                    [16] : 0x00c0


FYI: when I suspend sockets by echoing 3, suspend also does not work
(yenta loaded).

Anything other what should I test?

Thanks,

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com

