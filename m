Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263923AbRFWLfr>; Sat, 23 Jun 2001 07:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265676AbRFWLfh>; Sat, 23 Jun 2001 07:35:37 -0400
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:38099 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263923AbRFWLfV>; Sat, 23 Jun 2001 07:35:21 -0400
Message-ID: <3B347EB0.C48939DB@wanadoo.fr>
Date: Sat, 23 Jun 2001 13:34:08 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20pre4 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: twaugh@redhat.com
Subject: [PATCH] 2.2.20-pre, parport_probe, output truncated
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I load the 'lp' module, I got the following

[jean-luct@debian-f5ibh] ~ # modprobe lp
parport0: PC-style at 0x378 (0x778), irq 7 [SPP,ECP,ECPEPP,ECPPS2]
parport0: Unspecified, EPSON Styl
lp0: using parport0 (interrupt-driven).

After increasing the 'giveup' delay in parport_probe.c, I've the correct
output :

[jean-luct@debian-f5ibh] ~ # modprobe lp
parport0: PC-style at 0x378 (0x778), irq 7 [SPP,ECP,ECPEPP,ECPPS2]
parport0: Printer, EPSON Stylus COLOR 500
lp0: using parport0 (interrupt-driven).

--- parport_probe.old   Sat Jun 23 10:01:57 2001
+++ parport_probe.c     Sat Jun 23 13:16:48 2001
@@ -55,7 +55,7 @@
        unsigned int count = 0;
        unsigned char z=0;
        unsigned char Byte=0;
-       unsigned long igiveupat=jiffies+5*HZ;
+       unsigned long igiveupat=jiffies+9*HZ;
 
        for (i=0; time_before(jiffies, igiveupat); i++) {
               /* if(current->need_resched) schedule(); */

----
Regards
		Jean-Luc
