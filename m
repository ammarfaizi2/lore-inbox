Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274162AbRIYW01>; Tue, 25 Sep 2001 18:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274195AbRIYW0R>; Tue, 25 Sep 2001 18:26:17 -0400
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:33290 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S274162AbRIYW0C>;
	Tue, 25 Sep 2001 18:26:02 -0400
Date: Tue, 25 Sep 2001 15:26:28 -0700
From: andrew may <acmay@acmay.homeip.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ipip.c & ip_gre.c (Add Tunnel return)
Message-ID: <20010925152628.A8042@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the tunnel drivers should return the name of the
device the tunnel add created. Currently the tunnel_lookup
functions copy the name into the stack var in the ioctl
function but the ioctl copies the parm from the tunnel
device.

--- linux.org/net/ipv4/ip_gre.c	Tue Sep 25 02:27:58 2001
+++ linux/net/ipv4/ip_gre.c	Tue Sep 25 02:34:03 2001
@@ -284,7 +284,7 @@
 		}
 		if (i==100)
 			goto failed;
-		memcpy(parms->name, dev->name, IFNAMSIZ);
+		memcpy(nt->parms.name, dev->name, IFNAMSIZ);
 	}
 	if (register_netdevice(dev) < 0)
 		goto failed;
diff -ur linux.org/net/ipv4/ipip.c linux/net/ipv4/ipip.c
--- linux.org/net/ipv4/ipip.c	Tue Sep 25 02:27:52 2001
+++ linux/net/ipv4/ipip.c	Tue Sep 25 02:32:59 2001
@@ -255,7 +255,7 @@
 		}
 		if (i==100)
 			goto failed;
-		memcpy(parms->name, dev->name, IFNAMSIZ);
+		memcpy(nt->parms.name, dev->name, IFNAMSIZ);
 	}
 	if (register_netdevice(dev) < 0)
 		goto failed;



