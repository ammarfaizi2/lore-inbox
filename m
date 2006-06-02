Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWFBOxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWFBOxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWFBOxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:53:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:57047 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751435AbWFBOxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:53:49 -0400
Subject: [PATCH] fix make rpm for powerpc
From: Mike Wolf <mjw@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 02 Jun 2006 09:53:42 -0500
Message-Id: <1149260023.13835.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The default target for most powerpc platforms is zImage.  The
zImage however is in arch/powerpc/boot and the mkspec script
was set up to get the kernel from the top level of the kernel 
tree.  This patch copies vmlinux to arch/powerpc/boot and then
copies the kernel to the tmp directory so the rpm can be made.

Signed-off-by: Mike Wolf <mjw@us.ibm.com>


=============

--- linux.orig/scripts/package/mkspec	2006-05-21 23:22:53.000000000 -0500
+++ linux/scripts/package/mkspec	2006-05-22 15:13:56.000000000 -0500
@@ -73,8 +73,13 @@
 echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/efi/vmlinuz-$KERNELRELEASE"
 echo 'ln -s '"efi/vmlinuz-$KERNELRELEASE" '$RPM_BUILD_ROOT'"/boot/"
 echo "%else"
+echo "%ifarch ppc64"
+echo "cp vmlinux arch/powerpc/boot"
+echo "cp arch/powerpc/boot/"'$KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$KERNELRELEASE"
+echo "%else"
 echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$KERNELRELEASE"
 echo "%endif"
+echo "%endif"
 
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$KERNELRELEASE"
 


