Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272314AbRIEWK5>; Wed, 5 Sep 2001 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272320AbRIEWKr>; Wed, 5 Sep 2001 18:10:47 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:10635 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S272314AbRIEWKa>;
	Wed, 5 Sep 2001 18:10:30 -0400
Date: Wed, 5 Sep 2001 18:08:18 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <linux-kernel@vger.kernel.org>
cc: <netdev@oss.sgi.com>, Andi Kleen <ak@muc.de>, <kuznet@ms2.inr.ac.ru>
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <Pine.GSO.4.30.0109051803500.11700-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi, Alexey,

Whats wrong with this patch (just a thought, not tested or even compiled)?

---------------------------------------
--- devinet.c   2001/09/04 19:18:51     1.1
+++ devinet.c   2001/09/04 19:31:13
@@ -530,7 +530,7 @@

        if ((in_dev=__in_dev_get(dev)) != NULL) {
                for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL;
ifap=&ifa->ifa_next)
-                       if (strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
+                       if ((strcmp(ifr.ifr_name, ifa->ifa_label) == 0) ||
(sin->sin_addr.s_addr == ifa->ifa_address))
                                break;
        }
--------------------------------

cheers,
jamal


