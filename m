Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbVIEVoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVIEVoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVIEVnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:53 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:19794 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932675AbVIEVnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:40 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 20/24] V4L: print warning if pal= or secam= argument is
 unrecognized
Message-ID: <431cb7f8.VLF2vjbeDuymNOIe%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.vMFoyMb7gfO9A1vF5Z6U+M7VrZ/Bwjd1MTDnGa/njXk3cNvM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.vMFoyMb7gfO9A1vF5Z6U+M7VrZ/Bwjd1MTDnGa/njXk3cNvM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.vMFoyMb7gfO9A1vF5Z6U+M7VrZ/Bwjd1MTDnGa/njXk3cNvM
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-20-patch.diff"

- print warning if pal= or secam= argument is unrecognized

Signed-off-by: Philip Rowlands <phr@doc.ic.ac.uk>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/tda9887.c    |   13 +++++++++++++
 linux/drivers/media/video/tuner-core.c |   12 ++++++++++++
 2 files changed, 25 insertions(+)

diff -u /tmp/dst.1007 linux/drivers/media/video/tuner-core.c
--- /tmp/dst.1007	2005-09-05 11:43:13.000000000 -0300
+++ linux/drivers/media/video/tuner-core.c	2005-09-05 11:43:13.000000000 -0300
@@ -281,6 +281,12 @@
 			tuner_dbg ("insmod fixup: PAL => PAL-N\n");
 			t->std = V4L2_STD_PAL_N;
 			break;
+		case '-':
+			/* default parameter, do nothing */
+			break;
+		default:
+			tuner_warn ("pal= argument not recognised\n");
+			break;
 		}
 	}
 	if ((t->std & V4L2_STD_SECAM) == V4L2_STD_SECAM) {
@@ -297,6 +303,12 @@
 			tuner_dbg ("insmod fixup: SECAM => SECAM-L\n");
 			t->std = V4L2_STD_SECAM_L;
 			break;
+		case '-':
+			/* default parameter, do nothing */
+			break;
+		default:
+			tuner_warn ("secam= argument not recognised\n");
+			break;
 		}
 	}
 
diff -u /tmp/dst.1007 linux/drivers/media/video/tda9887.c
--- /tmp/dst.1007	2005-09-05 11:43:13.000000000 -0300
+++ linux/drivers/media/video/tda9887.c	2005-09-05 11:43:13.000000000 -0300
@@ -23,6 +23,7 @@
       TDA9887 (world), TDA9885 (USA)
       Note: OP2 of tda988x must be set to 1, else MT2032 is disabled!
    - KNC One TV-Station RDS (saa7134)
+   - Hauppauge PVR-150/500 (possibly more)
 */
 
 
@@ -519,6 +520,12 @@
 			dprintk(PREFIX "insmod fixup: PAL => PAL-DK\n");
 			t->std = V4L2_STD_PAL_DK;
 			break;
+		case '-':
+			/* default parameter, do nothing */
+			break;
+		default:
+			printk(PREFIX "pal= argument not recognised\n");
+			break;
 		}
 	}
 	if ((t->std & V4L2_STD_SECAM) == V4L2_STD_SECAM) {
@@ -535,6 +542,12 @@
 			dprintk(PREFIX "insmod fixup: SECAM => SECAM-L\n");
 			t->std = V4L2_STD_SECAM_L;
 			break;
+		case '-':
+			/* default parameter, do nothing */
+			break;
+		default:
+			printk(PREFIX "secam= argument not recognised\n");
+			break;
 		}
 	}
 	return 0;

--=_431cb7f8.vMFoyMb7gfO9A1vF5Z6U+M7VrZ/Bwjd1MTDnGa/njXk3cNvM--
