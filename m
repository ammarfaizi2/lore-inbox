Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSDDXV1>; Thu, 4 Apr 2002 18:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293242AbSDDXVR>; Thu, 4 Apr 2002 18:21:17 -0500
Received: from CPE-203-51-30-240.nsw.bigpond.net.au ([203.51.30.240]:48120
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S293196AbSDDXVO>; Thu, 4 Apr 2002 18:21:14 -0500
Message-ID: <3CACDFE5.E2FA11AE@eyal.emu.id.au>
Date: Fri, 05 Apr 2002 09:21:09 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre5-ac2: 8253xutl.c compile error
In-Reply-To: <200204042017.g34KHqv11609@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------5A0A099A7CD8A046884723FD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5A0A099A7CD8A046884723FD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> Linux 2.4.19pre5-ac2
> o       SAB8253 series wan drivers                      (Joachim Martillo)

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-ac/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-ac/include/linux/modversions.h -I.
-DKBUILD_BASENAME=8253xutl  -c -o 8253xutl.o 8253xutl.c
8253xutl.c: In function `sab8253x_wait_until_sent':
8253xutl.c:1347: structure has no member named `counter'
make[4]: *** [8253xutl.o] Error 1
make[4]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-ac/drivers/net/wan/8253x'

I simply deleted the offending line since I do not use this module, and
it looks like the right thing too (monkey sees monkey does).

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------5A0A099A7CD8A046884723FD
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-pre5-ac2-8253.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-pre5-ac2-8253.patch"

--- linux/drivers/net/wan/8253x/8253xutl.c.orig	Fri Apr  5 08:52:00 2002
+++ linux/drivers/net/wan/8253x/8253xutl.c	Fri Apr  5 08:55:47 2002
@@ -1344,7 +1344,6 @@
 	while ((Sab8253xCountTransmit(port) > 0) || !port->all_sent) 
 	{
 		current->state = TASK_INTERRUPTIBLE;
-		current->counter = 0;
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 		{

--------------5A0A099A7CD8A046884723FD--

