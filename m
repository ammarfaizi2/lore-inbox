Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUFKN31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUFKN31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 09:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUFKN31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 09:29:27 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:44706 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263725AbUFKN3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 09:29:25 -0400
Date: Fri, 11 Jun 2004 06:28:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Clemens Schwaighofer <gullevek@gullevek.org>
Cc: linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
Message-Id: <20040611062829.574db94f.pj@sgi.com>
In-Reply-To: <40C9AF48.2040807@gullevek.org>
References: <40C9AF48.2040807@gullevek.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens wrote:
> I think I have a similar problem like I had before:


I think that this should be the same solution as was suggested before
by William Lee Irwin III:



Index: mm1-2.6.7-rc3/include/linux/cpumask.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/linux/cpumask.h	2004-06-09 08:06:54.000000000 -0700
+++ mm1-2.6.7-rc3/include/linux/cpumask.h	2004-06-09 22:30:18.000000000 -0700
@@ -248,9 +248,9 @@
 #endif
 
 #define CPU_MASK_NONE							\
-{ {									\
+((cpumask_t) { {							\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
-} }
+} })
 
 #define cpus_addr(src) ((src).bits)
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
