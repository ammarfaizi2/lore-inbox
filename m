Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVELI3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVELI3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVELI33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:29:29 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14877
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261333AbVELI3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:29:20 -0400
Message-Id: <s28321ef.089@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:29:35 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix ATM makefile for out-of-source-tree builds
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part456689FF.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part456689FF.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Adjust ATM makefile to account for building outside of the source tree.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/drivers/atm/Makefile linux-2.6.12-rc4/driv=
ers/atm/Makefile
--- linux-2.6.12-rc4.base/drivers/atm/Makefile	2005-03-02 08:38:34.0000000=
00 +0100
+++ linux-2.6.12-rc4/drivers/atm/Makefile	2005-03-15 14:39:36.0000000=
00 +0100
@@ -39,7 +39,8 @@ ifeq ($(CONFIG_ATM_FORE200E_PCA),y)
   fore_200e-objs		+=3D fore200e_pca_fw.o
   # guess the target endianess to choose the right PCA-200E firmware =
image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
-    CONFIG_ATM_FORE200E_PCA_FW =3D $(shell if test -n "`$(CC) -E -dM =
$(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then =
echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
+    byteorder.h			:=3D include$(if $(patsubst =
$(srctree),,$(objtree)),2)/asm/byteorder.h
+    CONFIG_ATM_FORE200E_PCA_FW	:=3D $(obj)/pca200e$(if $(shell $(CC) -E =
-dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
   endif
 endif
=20



--=__Part456689FF.1__=
Content-Type: text/plain; name="linux-2.6.12-rc4-atm-make.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-atm-make.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Adjust ATM makefile to account for building outside of the source tree.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/drivers/atm/Makefile linux-2.6.12-rc4/drivers/atm/Makefile
--- linux-2.6.12-rc4.base/drivers/atm/Makefile	2005-03-02 08:38:34.000000000 +0100
+++ linux-2.6.12-rc4/drivers/atm/Makefile	2005-03-15 14:39:36.000000000 +0100
@@ -39,7 +39,8 @@ ifeq ($(CONFIG_ATM_FORE200E_PCA),y)
   fore_200e-objs		+= fore200e_pca_fw.o
   # guess the target endianess to choose the right PCA-200E firmware image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
-    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
+    byteorder.h			:= include$(if $(patsubst $(srctree),,$(objtree)),2)/asm/byteorder.h
+    CONFIG_ATM_FORE200E_PCA_FW	:= $(obj)/pca200e$(if $(shell $(CC) -E -dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
   endif
 endif
 

--=__Part456689FF.1__=--
