Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbTFVBe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 21:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbTFVBe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 21:34:56 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:61703 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S265417AbTFVBet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 21:34:49 -0400
Date: Sat, 21 Jun 2003 22:51:29 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix sysfs bogosity in i82365.c
Message-ID: <20030622015129.GE10801@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider applying, it was using a non-existent socket[] index
and not doing it for all sockets.

	Without this, forget about using i82365, crashes on boot :-)

- Arnaldo

===== drivers/pcmcia/i82365.c 1.36 vs edited =====
--- 1.36/drivers/pcmcia/i82365.c	Sun Jun 15 12:20:52 2003
+++ edited/drivers/pcmcia/i82365.c	Sat Jun 21 22:09:08 2003
@@ -1471,6 +1471,10 @@
 			    pcmcia_unregister_socket(&socket[i].socket);
 		    break;
 	    }
+	   class_device_create_file(&socket[i].socket.dev,
+			   	    &class_device_attr_info);
+	   class_device_create_file(&socket[i].socket.dev,
+			   	    &class_device_attr_exca);
     }
 
     /* Finally, schedule a polling interrupt */
@@ -1481,9 +1485,6 @@
     	poll_timer.expires = jiffies + poll_interval;
 	add_timer(&poll_timer);
     }
-
-    class_device_create_file(&socket[i].socket.dev, &class_device_attr_info);
-    class_device_create_file(&socket[i].socket.dev, &class_device_attr_exca);
     
     return 0;
     
