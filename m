Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293087AbSCAMUX>; Fri, 1 Mar 2002 07:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293037AbSCAMUO>; Fri, 1 Mar 2002 07:20:14 -0500
Received: from hanoi.cronyx.ru ([144.206.181.53]:18439 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id <S293048AbSCAMUK>;
	Fri, 1 Mar 2002 07:20:10 -0500
Message-ID: <3C7F719E.3040402@cronyx.ru>
Date: Fri, 01 Mar 2002 15:18:38 +0300
From: Roman Kurakin <rik@cronyx.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial.c BUG 2.4.x-2.5x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Who is responsible person for applying patches to main tree?

This time I decide to send 2.5.5 patch version:

--- serial-255.c    Thu Feb 28 19:24:47 2002
+++ ../serial-255.c    Wed Feb 20 05:10:59 2002
@@ -2084,7 +2084,6 @@
     unsigned int        i,change_irq,change_port;
     int             retval = 0;
     unsigned long        new_port;
-    unsigned long        new_mem;
 
     if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
         return -EFAULT;
@@ -2094,7 +2093,6 @@
     new_port = new_serial.port;
     if (HIGH_BITS_OFFSET)
         new_port += (unsigned long) new_serial.port_high << 
HIGH_BITS_OFFSET;
-    new_mem = new_serial.iomem_base;
 
     change_irq = new_serial.irq != state->irq;
     change_port = (new_port != ((int) state->port)) ||
@@ -2136,7 +2134,6 @@
         for (i = 0 ; i < NR_PORTS; i++)
             if ((state != &rs_table[i]) &&
                 (rs_table[i].port == new_port) &&
-                (rs_table[i].iomem_base == new_mem) &&
                 rs_table[i].type)
                 return -EADDRINUSE;
     }

-------- Original Message --------
 Subject: Serial.c Bug
 Date: Wed, 14 Nov 2001 13:02:47 +0300
 From: Roman Kurakin <rik@cronyx.ru>
 To: linux-kernel@vger.kernel.org

   I have found a bug. It is in support of serial cards which uses 
memory for
   I/O insted of ports. I made a patch for serial.c and fix one place, but
   probably the problem like this one could be somewhere else.
  
   If you try to use setserial with such cards you will get "Address in use"
   (-EADDRINUSE)
     
   Best regards,
                    Kurakin Roman


Best regards,
                        Roman Kurakin




