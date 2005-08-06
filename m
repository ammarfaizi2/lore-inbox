Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263158AbVHFCwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbVHFCwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 22:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVHFCwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 22:52:54 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:20073 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263158AbVHFCwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 22:52:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=uiab1ZhYdpAeEH3hR3EesB6JMVTBTmjB18QWO54Pni/vm2R2kmjMAAMXSREP11PPUG/kg8zk3A/qK5otM/mULracTBfCww8ICUztxbU0NI7u+cyfIg85Vkp23fAjYLaeWYTBV5W5MXKG2e5NcLIq8JALZM/hreF8LIIzRdE3y9w=  ;
Subject: Inclusion order patch
From: "James C. Georgas" <jgeorgas@rogers.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
In-Reply-To: <1123295768.17282.29.camel@Tachyon.home>
References: <1123295768.17282.29.camel@Tachyon.home>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 22:52:49 -0400
Message-Id: <1123296769.17282.36.camel@Tachyon.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me for reposting this. I forgot the subject line. hehe.

This patch lets this header stand alone, since I can never remember
which other headers to include, or in which order.

The three #include lines define the types: kobject, list_head and dev_t,
which are used in the cdev structure.

The forward declaration of struct inode is to quiet the following
compiler warning when including only cdev.h in my file:

include/linux/cdev.h:30: warning: `struct inode' declared inside parameter list
include/linux/cdev.h:30: warning: its scope is only this definition or
declaration, which is probably not what you want

I'm not sure, but I think it's saying that I'm declaring a new struct,
which will not be the same as the real struct inode if it is #included
later, because of the scope rules.

(oh yeah, this is my first patch to the list; did I get the format
right?)

BEGIN PATCH:

diff -Nru linux-2.6.12.4/include/linux/cdev.h linux/include/linux/cdev.h
--- linux-2.6.12.4/include/linux/cdev.h 2005-08-05 03:04:37.000000000
-0400
+++ linux/include/linux/cdev.h  2005-08-05 21:41:39.000000000 -0400
@@ -2,6 +2,12 @@
 #define _LINUX_CDEV_H
 #ifdef __KERNEL__

+#include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+struct inode;
+
 struct cdev {
        struct kobject kobj;
        struct module *owner;



-- 
James C. Georgas <jgeorgas@rogers.com>

