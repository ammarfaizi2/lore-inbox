Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135838AbRDYJzd>; Wed, 25 Apr 2001 05:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135839AbRDYJzY>; Wed, 25 Apr 2001 05:55:24 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:18963 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S135838AbRDYJzI>;
	Wed, 25 Apr 2001 05:55:08 -0400
Message-ID: <09BE2D952F35D411ABAF009027B6B1D37984ED@abg0971e.abg.fsc.net>
From: "Mulder, Tjeerd" <Tjeerd.Mulder@fujitsu-siemens.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with DHCP when using tokenring on 2.4.x
Date: Wed, 25 Apr 2001 11:57:37 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is probably caused by a change that was made around
kernel 2.3.29. The hardware type of a tokenring adapter was changed
from ARPHRD_IEEE802 to ARPHRD_IEEE802_TR. That breaks pump and the
ISC dhcp package. So pump from RH6.2 certainly won't work.

Fixing the ISC dhcp package is easy. Maybe it has been fixed
on the ISC site by now. Don't know about pump. 
 

Patch for the ISC package:

--- dhcp-3.0b2pl11/common/discover.c.org	Mon Jan  8 17:38:18 2001
+++ dhcp-3.0b2pl11/common/discover.c	Mon Jan  8 17:23:56 2001
@@ -407,7 +407,11 @@
 #ifndef HAVE_ARPHRD_IEEE802
 # define ARPHRD_IEEE802 HTYPE_IEEE802
 #endif
+#ifdef ARPHRD_IEEE802_TR
+		      case ARPHRD_IEEE802_TR:
+#else
 		      case ARPHRD_IEEE802:
+#endif
 			tmp -> hw_address.hlen = 7;
 			tmp -> hw_address.hbuf [0] = ARPHRD_IEEE802;
 			memcpy (&tmp -> hw_address.hbuf [1], sa.sa_data, 6);



--
======================================================================
Tjeerd Mulder                ! mailto:tjeerd.mulder@fujitsu-siemens.com
Fujitsu Siemens Computers    !
FSC PO PC RD MDE             !
Buergermeister Ulrichstr 100 ! Phone: +49 821 804 3549
86199 Augsburg               ! Fax  : +49 821 804 3934
======================================================================


