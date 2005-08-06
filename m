Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263133AbVHFCgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVHFCgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 22:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVHFCgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 22:36:12 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:14176 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263133AbVHFCgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 22:36:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=dRZWLJwSGo9+ADhCvbd8zWyabQP9B+FO02p5qjxQ8QavQgGi9sk11TXefN8Aq7hbBuLQ/XXVAuK+yWY/tyh6TDjQ5fNOkMmbz9Dcxdjv5VU3jxF+MsbI19YauByf4njvOtVFvFkAWcR3s7eJl1PiiIEFqwReAXv/TjjdWdg3Dd0=  ;
Subject: 
From: "James C. Georgas" <jgeorgas@rogers.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 22:36:06 -0400
Message-Id: <1123295768.17282.29.camel@Tachyon.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch lets this header stand alone, since I can never remember
which other headers to include, or in which order.

The three #include lines define the types: kobject, list_head and dev_t,
which are used in the cdev structure.

The forward declaration of struct inode is to quiet the following
compiler warning when including only cdev.h in my file:

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

