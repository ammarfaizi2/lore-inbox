Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277299AbRJJQPL>; Wed, 10 Oct 2001 12:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277298AbRJJQPC>; Wed, 10 Oct 2001 12:15:02 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:21006 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277296AbRJJQOt>; Wed, 10 Oct 2001 12:14:49 -0400
Message-ID: <3BC473F9.EB65B6B2@zip.com.au>
Date: Wed, 10 Oct 2001 09:14:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luis Montgomery <monty@fismat1.fcfm.buap.mx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11: problem with at1700
In-Reply-To: <Pine.GSO.4.21.0110100409260.27961-100000@fismat1.fcfm.buap.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Montgomery wrote:
> 
> I try to compile 2.4.11 and find this error:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS
> -include /usr/src/linux-2.4.11/include/linux/modversions.h   -c -o
> at1700.o at1700.c
> at1700.c:475: conflicting types for `read_eeprom'
> at1700.c:161: previous declaration of `read_eeprom'
> make[2]: *** [at1700.o] Error 1
> 

That's an easy one:

--- linux-2.4.11/drivers/net/at1700.c	Tue Oct  9 21:31:38 2001
+++ linux-akpm/drivers/net/at1700.c	Wed Oct 10 09:03:41 2001
@@ -158,7 +158,7 @@ struct net_local {
 extern int at1700_probe(struct net_device *dev);
 
 static int at1700_probe1(struct net_device *dev, int ioaddr);
-static int read_eeprom(int ioaddr, int location);
+static int read_eeprom(long ioaddr, int location);
 static int net_open(struct net_device *dev);
 static int	net_send_packet(struct sk_buff *skb, struct net_device *dev);
 static void net_interrupt(int irq, void *dev_id, struct pt_regs *regs);

Incidentally, do you use at1700 much?  Does it work OK?
There's an ancient patch at http://web.gnu.walfield.org/mail-archive/linux-kernel/2000-July/3897.html
which seems fairly significant, but it's rare hardware, and I don't
think there have been any bug reports.


-
