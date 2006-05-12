Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWELWQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWELWQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWELWQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:16:54 -0400
Received: from main.gmane.org ([80.91.229.2]:9378 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750938AbWELWQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:16:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Schweizer <genstef@gentoo.org>
Subject: Re: [PATCH 2.6.17-rc3] Fix capi reload by unregistering the correct major
Followup-To: gmane.linux.kernel
Date: Sat, 13 May 2006 00:16:49 +0200
Message-ID: <e431gb$qaj$1@sea.gmane.org>
References: <e307i4$f1h$1@sea.gmane.org> <20060508130029.08a9a962.akpm@osdl.org> <e3qihe$3q2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-82-135-4-190.mnet-online.de
User-Agent: KNode/0.10.2
Cc: i4ldeveloper@listserv.isdn4linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after seeing your problems with my patch on -mm-commits, I actually think
this one might be better. It allows dynamic majors and does not break
anything :)
Please change my patch
- Stefan

--- drivers/isdn/capi/capi.c    2006-05-13 00:12:46.000000000 +0200
+++ drivers/isdn/capi/capi.c    2006-05-12 22:16:22.000000000 +0200
@@ -1499,7 +1499,9 @@
                printk(KERN_ERR "capi20: unable to get major %d\n",
capi_major);
                return major_ret;
        }
-       capi_major = major_ret;
+       if (major_ret != 0) {
+               capi_major = major_ret;
+       }
        capi_class = class_create(THIS_MODULE, "capi");
        if (IS_ERR(capi_class)) {
                unregister_chrdev(capi_major, "capi20");


