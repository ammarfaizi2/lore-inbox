Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTEOCDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbTEOCDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:03:25 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:50886 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263653AbTEOCDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:03:24 -0400
Date: Wed, 14 May 2003 19:17:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
Message-Id: <20030514191735.6fe0998c.akpm@digeo.com>
In-Reply-To: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 02:16:08.0478 (UTC) FILETIME=[F25093E0:01C31A87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> I've been able to pinpoint the culprit of this: it's the
>  "make-KOBJ_NAME-match-BUS_ID_SIZE.patch" patch that it's causing the
>  oops for me when booting 2.5.69.mm5.
> 
>  Reverting this patch solves the oops for me.

I might have screwed that patch up.

This is the second half of it.  When it crashed, did you have the below
change in place as well?

Index: include/linux/device.h
===================================================================
RCS file: /home/scm/linux-2.5/include/linux/device.h,v
retrieving revision 1.48
diff -u -u -r1.48 device.h
--- include/linux/device.h	29 Apr 2003 17:30:20 -0000	1.48
+++ include/linux/device.h	13 May 2003 07:47:39 -0000
@@ -35,7 +35,7 @@
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
 #define DEVICE_ID_SIZE		32
-#define BUS_ID_SIZE		20
+#define BUS_ID_SIZE		KOBJ_NAME_LEN
 
 
 enum {
-


