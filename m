Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTFOMOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 08:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTFOMOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 08:14:11 -0400
Received: from [211.167.76.68] ([211.167.76.68]:2437 "HELO soulinfo")
	by vger.kernel.org with SMTP id S262169AbTFOMOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 08:14:08 -0400
Date: Sun, 15 Jun 2003 20:28:03 +0800
From: hugang <hugang@soulinfo.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Pcmcia GPRS cards not works in linux.
Message-Id: <20030615202803.51fcf72e.hugang@soulinfo.com>
In-Reply-To: <20030615103456.B27533@flint.arm.linux.org.uk>
References: <20030615104322.496279e1.hugang@soulinfo.com>
	<20030615103456.B27533@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Russell King <rmk@arm.linux.org.uk>
 =?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA:?= dahinds@users.sourceforge.net,linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jun 2003 10:34:56 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

>  Could you include the information below and the output of cardctl
>  status please?
> 
Thank you very much.

>  I think I can tell you what's happening.  Your card contains two
>  configuration table entries (0x30 and 0x31).  The first, 0x30,
>  tells us that the card supports 3.3V in this configuration.  The
>  second indicates that the card supports 5V with this configuration.
  Your are right. With this patch it works fine.
--- cs.c.old    Sun Jun 15 19:46:26 2003
+++ cs.c        Sun Jun 15 19:52:51 2003
@@ -1765,8 +1765,10 @@
        return CS_CONFIGURATION_LOCKED;
 
     /* Do power control.  We don't allow changes in Vcc. */
-    if (s->socket.Vcc != req->Vcc)
-       return CS_BAD_VCC;
+       printk("VCC: %d, %d\n", s->socket.Vcc, req->Vcc);
+    /*if (s->socket.Vcc != req->Vcc)
+       return CS_BAD_VCC;*/
+       printk("Vpp1: %d, %d\n", req->Vpp1, req->Vpp2);
     if (req->Vpp1 != req->Vpp2)
        return CS_BAD_VPP;
     s->socket.Vpp = req->Vpp1;

---2.5.71-------without-hacker
hugang:/home/hugang/download/module-init# uname -a
Linux hugang 2.5.71 #4 ÈÕ 6ÔÂ 15 11:44:04 CST 2003 i686 unknown
hugang:/home/hugang/download/module-init# cardctl config
Socket 0:
  Vcc 3.3V  Vpp1 3.3V  Vpp2 3.3V
hugang:/home/hugang/download/module-init# cardctl status
Socket 0:
  3.3V 16-bit PC Card
  function 0: [ready], [wp], [bat low]
--with-hacker--
VCC: 33, 50
Vpp1: 0, 0
ttyS0 at I/O 0x100 (irq = 3) is a 16550A
hugang:~# cardctl status
Socket 0:
  3.3V 16-bit PC Card
  function 0: [ready]
hugang:~# cardctl config
Socket 0:
  Vcc 5.0V  Vpp1 0.0V  Vpp2 0.0V
  interface type is "memory and I/O"
  irq 3 [exclusive] [level]
  speaker output is enabled
  function 0:
    config base 0x0400
      option 0x70
    io 0x0100-0x010f [8bit]
-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
http://soulinfo.com/~hugang/HuGang.asc
ICQ#         : 205800361
Registered Linux User : 204016
