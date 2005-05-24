Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVEXW2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVEXW2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEXW2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:28:30 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:30590 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262099AbVEXW11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:27:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SgBHyBBtYVezalXv5mgigMh4AJzI6PGEsoPzLqVPrQJimDgDWWrE2jAoq4ONOJxBMKIkqJsX/62FErjtkB/fxAjFno3RCVg013CXuovODjaTKifLU9MKJDSejdnnkGR540yl7Wb92zaTP7azYBnziO2fAjl+thprU8tpPV1weXI=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] #include asm/uaccess.h in asm/checksum.h
Date: Wed, 25 May 2005 02:31:44 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505250231.44207.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

csum_and_copy_to_user is static inline and uses VERIFY_WRITE. Patch allows to
remove asm/uaccess.h from i386_ksyms.c without dependency surprises.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-vanilla/include/asm-i386/checksum.h	2005-05-24 08:48:20.000000000 +0400
+++ linux-ksyms/include/asm-i386/checksum.h	2005-05-25 01:28:45.000000000 +0400
@@ -3,6 +3,8 @@
 
 #include <linux/in6.h>
 
+#include <asm/uaccess.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
