Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270615AbTGTDok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 23:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270616AbTGTDok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 23:44:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13781 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270615AbTGTDog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 23:44:36 -0400
Message-ID: <3F1A139B.3090708@pobox.com>
Date: Sat, 19 Jul 2003 23:59:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [PATCH] missing __KERNEL__ ifdef in include/linux/device.h]
Content-Type: multipart/mixed;
 boundary="------------040003080006050206010800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003080006050206010800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040003080006050206010800
Content-Type: message/rfc822;
 name="[PATCH] missing __KERNEL__ ifdef in include/linux/device.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] missing __KERNEL__ ifdef in include/linux/device.h"

Return-Path: <netdev-bounce@oss.sgi.com>
Delivered-To: garzik@gtf.org
Received: from orb.pobox.com (orb.pobox.com [216.65.124.72])
	by havoc.gtf.org (Postfix) with ESMTP id 7E9F1663B
	for <garzik@gtf.org>; Sat, 19 Jul 2003 22:57:55 -0400 (EDT)
Received: from orb.pobox.com (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id C895C1562EC
	for <garzik@gtf.org>; Sat, 19 Jul 2003 22:57:54 -0400 (EDT)
Delivered-To: jgarzik@pobox.com
Received: from smtp.mandrake.com (smtp.mandrake.com [63.209.80.248])
	by orb.pobox.com (Postfix) with ESMTP id BE51915620B
	for <jgarzik@pobox.com>; Sat, 19 Jul 2003 22:57:54 -0400 (EDT)
Received: from oss.sgi.com (oss.sgi.com [192.48.159.27])
	by smtp.mandrake.com (Postfix) with ESMTP id 2EB3A83C0E
	for <jgarzik@mandrakesoft.com>; Sat, 19 Jul 2003 18:10:30 -0700 (PDT)
Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.9/8.12.9) with ESMTP id h6K2unFl011061;
	Sat, 19 Jul 2003 19:56:49 -0700
Received: with ECARTIS (v1.0.0; list netdev); Sat, 19 Jul 2003 19:55:41 -0700 (PDT)
Received: from rei.rakuen (dclient217-162-65-211.hispeed.ch [217.162.65.211])
	by oss.sgi.com (8.12.9/8.12.9) with SMTP id h6K2taFl010762
	for <netdev@oss.sgi.com>; Sat, 19 Jul 2003 19:55:37 -0700
Received: by reeler.org id 19e4MD-0007Pb-00
	for <netdev@oss.sgi.com>; Sun, 20 Jul 2003 04:55:29 +0200
Date: Sun, 20 Jul 2003 04:55:29 +0200
From: Thomas Graf <tgraf@suug.ch>
To: netdev@oss.sgi.com
Subject: [PATCH] missing __KERNEL__ ifdef in include/linux/device.h
Message-ID: <20030720025528.GA30577@rei.rakuen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Encryption: "Encrypted with ROT13 using key 42"
X-archive-position: 4180
X-ecartis-version: Ecartis v1.0.0
Sender: netdev-bounce@oss.sgi.com
Errors-To: netdev-bounce@oss.sgi.com
X-original-sender: tgraf@suug.ch
Precedence: bulk
X-list: netdev
X-Spam-Status: No, hits=-6.0 required=6.0
	tests=AWL,BAYES_01,PATCH_UNIFIED_DIFF
	version=2.55
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)

Hello

device.h should be protected with __KERNEL__ because it uses
__KERNEL__ protected structures. Userspace applications
including if_arp.h such as iproute2 will fail because
it finally includes device.h as well.

 - thomas


Index: include/linux/device.h
===================================================================
RCS file: /cvs/tgr/linux-25/include/linux/device.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 device.h
--- include/linux/device.h	10 Jul 2003 22:58:31 -0000	1.1.1.2
+++ include/linux/device.h	20 Jul 2003 02:49:12 -0000
@@ -8,7 +8,7 @@
  * See Documentation/driver-model/ for more information.
  */
 
-#ifndef _DEVICE_H_
+#if defined __KERNEL__ && !defined _DEVICE_H_
 #define _DEVICE_H_
 
 #include <linux/config.h>





--------------040003080006050206010800--

