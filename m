Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTFIUpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTFIUpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:45:43 -0400
Received: from gateway.penguincomputing.com ([64.243.132.186]:58008 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S261932AbTFIUpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:45:42 -0400
Date: Mon, 9 Jun 2003 13:26:37 -0700 (PDT)
From: Dan Carpenter <dcarpenter@penguincomputing.com>
X-X-Sender: <dcarpenter@ddcarpen1.penguincompting.com>
To: <linux-kernel@vger.kernel.org>
cc: <ppokorny@penguincomputing.com>
Subject: Re: memtest86 on the opteron
Message-ID: <Pine.LNX.4.33.0306091320500.2640-100000@ddcarpen1.penguincompting.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all,

Here is the patch for the CPU ID.

regards,
dan carpenter
Penguin Computing

--- init.c.orig	Mon Jun  9 10:23:10 2003
+++ init.c	Mon Jun  9 10:25:44 2003
@@ -402,6 +402,16 @@
 			}
 			l1_cache = cpu_id.cache_info[3];
 			l1_cache += cpu_id.cache_info[7];
+                case 15:
+                        switch(cpu_id.model) {
+                        case 5:
+				cprint(LINE_CPU, 0, "AMD Opteron");
+				off = 11;
+				l1_cache = cpu_id.cache_info[3];
+				l1_cache += cpu_id.cache_info[7];
+				l2_cache = (cpu_id.cache_info[11] << 8);
+				l2_cache += cpu_id.cache_info[10];
+                        }
 		}
 		break;



