Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264079AbTH1PzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTH1PzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:55:12 -0400
Received: from mail.ccur.com ([208.248.32.212]:30471 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264079AbTH1PzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:55:08 -0400
Date: Thu, 28 Aug 2003 11:54:52 -0400
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bad definition of cpus_complement
Message-ID: <20030828155451.GA16156@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the definitions of cpus_complement is broke.  Also, cpus_complement is
the only cpus_* definition which operates in-place rather than in (dst,src)
form.  I will submit a patch to convert if there is interest.

Joe

--- include/asm-generic/cpumask_up.h.orig	2003-08-27 06:08:38.000000000 -0400
+++ include/asm-generic/cpumask_up.h	2003-08-28 11:45:09.000000000 -0400
@@ -28,7 +28,7 @@
 
 #define cpus_complement(map)						\
 	do {								\
-		cpus_coerce(map) = !cpus_coerce(map);			\
+		cpus_coerce(map) = ~cpus_coerce(map);			\
 	} while (0)
 
 #define cpus_equal(map1, map2)		(cpus_coerce(map1) == cpus_coerce(map2))

