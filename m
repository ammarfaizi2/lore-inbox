Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbVKHSiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVKHSiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVKHSiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:38:22 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:16132 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030293AbVKHSiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:38:21 -0500
Message-ID: <4370F09C.1050306@vmware.com>
Date: Tue, 08 Nov 2005 10:38:20 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
Cc: axboe@suse.de, htejun@hotmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: + elevator-init-fixes.patch added to -mm tree
References: <200511080351.jA83psjw016612@shell0.pdx.osdl.net>
In-Reply-To: <200511080351.jA83psjw016612@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------050307050909010102080909"
X-OriginalArrivalTime: 08 Nov 2005 18:38:20.0434 (UTC) FILETIME=[97946F20:01C5E493]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050307050909010102080909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

akpm@osdl.org wrote:

>The patch titled
>
>     Elevator init fixes
>
>has been added to the -mm tree.  Its filename is
>
>     elevator-init-fixes.patch
>  
>

In addition to the first patch, which is probably goodness, I found the 
cause of my panic - applying this patch fixes it and now I am booting.


--------------050307050909010102080909
Content-Type: text/plain;
 name="elevator-obviously-broken-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="elevator-obviously-broken-fix"


Index: linux-2.6.14/drivers/block/elevator.c
===================================================================
--- linux-2.6.14.orig/drivers/block/elevator.c	2005-11-07 08:07:15.000000000 -0800
+++ linux-2.6.14/drivers/block/elevator.c	2005-11-08 02:14:35.727328656 -0800
@@ -155,9 +155,10 @@
  	/*
  	 * If the given scheduler is not available, fall back to no-op.
  	 */
- 	if (!(e = elevator_find(chosen_elevator)))
+ 	if ((e = elevator_find(chosen_elevator)))
+		elevator_put(e);
+	else
  		strcpy(chosen_elevator, "noop");
-	elevator_put(e);
 }
 
 static int __init elevator_setup(char *str)

--------------050307050909010102080909--
