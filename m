Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTJMSna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 14:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTJMSna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 14:43:30 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:47589 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S261863AbTJMSn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 14:43:29 -0400
Message-ID: <3F8AF1F0.9080606@superonline.com>
Date: Mon, 13 Oct 2003 21:41:52 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7-pac1
Content-Type: multipart/mixed;
 boundary="------------060508030105050504090503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508030105050504090503
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

drivers/char/rocket.c is missing the tty->count  -->
atomic_read(&tty->count) change. Patch attached.

Regards;
Özkan Sezer

--------------060508030105050504090503
Content-Type: text/plain;
 name="rocket.c-tty-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rocket.c-tty-fix.patch"

--- ./drivers/char/rocket.c.orig	2003-10-13 12:58:33.000000000 +0300
+++ ./drivers/char/rocket.c	2003-10-13 20:10:05.000000000 +0300
@@ -1052,7 +1052,7 @@
 		restore_flags(flags);
 		return;
 	}
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always

--------------060508030105050504090503--

