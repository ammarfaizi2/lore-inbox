Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314520AbSDSCjD>; Thu, 18 Apr 2002 22:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314516AbSDSCiD>; Thu, 18 Apr 2002 22:38:03 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:24807 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314520AbSDSChu>;
	Thu, 18 Apr 2002 22:37:50 -0400
Date: Thu, 18 Apr 2002 19:37:48 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : Minor fix to Wireless Handlers (essid)
Message-ID: <20020418193748.I988@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	This is *not* an IrDA patch, but would you mind to push that
to Linus ?
	It fixes a bug that could cause a wireless driver to crash
badly when getting/setting ESSID. Thanks to Bas Vermeulen (no wire
needed wireless driver) for finding this one ;-).
	Thanks in advance...

	Jean

-----------------------------------------

diff -u -p linux/net/core/wireless.v3.c linux/net/core/wireless.c
--- linux/net/core/wireless.v3.c	Thu Apr 18 16:55:54 2002
+++ linux/net/core/wireless.c	Thu Apr 18 16:58:21 2002
@@ -28,11 +28,13 @@
  *
  * v3 - 19.12.01 - Jean II
  *	o Make sure we don't go out of standard_ioctl[] in ioctl_standard_call
- *	o Fix /proc/net/wireless to handle __u8 to __s8 change in iwqual
  *	o Add event dispatcher function
  *	o Add event description
  *	o Propagate events as rtnetlink IFLA_WIRELESS option
  *	o Generate event on selected SET requests
+ *
+ * v4 - 18.04.01 - Jean II
+ *	o Fix stupid off by one in iw_ioctl_description : IW_ESSID_MAX_SIZE + 1
  */
 
 /***************************** INCLUDES *****************************/
@@ -122,13 +124,13 @@ static const struct iw_ioctl_description
 	/* SIOCGIWSCAN */
 	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_SCAN_MAX_DATA, 0},
 	/* SIOCSIWESSID */
-	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE, IW_DESCR_FLAG_EVENT},
+	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE + 1, IW_DESCR_FLAG_EVENT},
 	/* SIOCGIWESSID */
-	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE, IW_DESCR_FLAG_DUMP},
+	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE + 1, IW_DESCR_FLAG_DUMP},
 	/* SIOCSIWNICKN */
-	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE, 0},
+	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE + 1, 0},
 	/* SIOCGIWNICKN */
-	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE, 0},
+	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE + 1, 0},
 	/* -- hole -- */
 	{ IW_HEADER_TYPE_NULL, 0, 0, 0, 0, 0},
 	/* -- hole -- */
