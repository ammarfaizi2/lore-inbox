Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTFKJ5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTFKJ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:57:38 -0400
Received: from catv-50622120.szolcatv.broadband.hu ([80.98.33.32]:31428 "EHLO
	catv-50622120.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S264292AbTFKJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:57:37 -0400
Message-ID: <3EE70045.8000609@externet.hu>
Date: Wed, 11 Jun 2003 12:11:17 +0200
From: Boszormenyi Zoltan <zboszor@externet.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Cyrix ARR problem in split MTRR code
Content-Type: multipart/mixed;
 boundary="------------000300070500000403050802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000300070500000403050802
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I noticed a problem in the split MTRR code that is special casing
ARR #3 on Cyrix 6x86(MX) / MII CPUs. I wrote the code for the
original (monolithic) mtrr.c, but I don't have my old Cyrix 6x86MX
mainboard anymore. The problem is obvious though, one liner fix is
attached.  Patrick Mochel should have been more careful. :-)

Best regards,
Zoltán Böszörményi


--------------000300070500000403050802
Content-Type: text/plain;
 name="mtrr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mtrr.diff"

--- arch/i386/kernel/cpu/mtrr/main.c.old	2003-06-11 11:09:43.000000000 +0200
+++ arch/i386/kernel/cpu/mtrr/main.c	2003-06-11 12:03:48.000000000 +0200
@@ -64,7 +64,7 @@
 static void set_mtrr(unsigned int reg, unsigned long base,
 		     unsigned long size, mtrr_type type);
 
-static unsigned int arr3_protected;
+extern int arr3_protected;
 
 void set_mtrr_ops(struct mtrr_ops * ops)
 {

--------------000300070500000403050802--

