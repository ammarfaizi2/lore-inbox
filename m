Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbTFLGvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264765AbTFLGsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:48:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61150 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263542AbTFLGrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:47:47 -0400
Date: Thu, 12 Jun 2003 12:37:47 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patchset] Fix sign handling bugs in 2.5 -- 4/5; tun
Message-ID: <20030612070745.GE1146@llm08.in.ibm.com>
References: <20030612070330.GA1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612070330.GA1146@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.70/drivers/net/tun.c	Tue May 27 06:30:39 2003
+++ shb-tun-2.5.70/drivers/net/tun.c	Wed Jun 11 16:37:46 2003
@@ -185,7 +185,7 @@
 	size_t len = count;
 
 	if (!(tun->flags & TUN_NO_PI)) {
-		if ((len -= sizeof(pi)) < 0)
+		if ((len -= sizeof(pi)) > len)
 			return -EINVAL;
 
 		memcpy_fromiovec((void *)&pi, iv, sizeof(pi));
