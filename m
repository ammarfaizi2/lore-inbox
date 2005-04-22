Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVDVIWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVDVIWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 04:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVDVIWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 04:22:20 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:54688 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261868AbVDVIWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 04:22:16 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: x86_64: Bug in new out of line put_user()
From: Alexander Nyberg <alexn@telia.com>
To: Brian Gerst <bgerst@didntduck.org>, torvalds@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org,
       nicolas@boichat.ch
In-Reply-To: <42684603.5050500@didntduck.org>
References: <1114038609.500.2.camel@localhost.localdomain>
	 <42684603.5050500@didntduck.org>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 10:22:14 +0200
Message-Id: <1114158134.917.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian, thanks for seeing this. (me goes hiding...)

The labels after the last put_user patch were misplaced so 
exceptions on the real mov instructions would not be handled.

Index: test/arch/x86_64/lib/putuser.S
===================================================================
--- test.orig/arch/x86_64/lib/putuser.S	2005-04-22 10:04:25.000000000 +0200
+++ test/arch/x86_64/lib/putuser.S	2005-04-22 10:06:29.000000000 +0200
@@ -49,8 +49,8 @@
 	jc 20f
 	cmpq threadinfo_addr_limit(%r8),%rcx
 	jae 20f
-2:	decq %rcx
-	movw %dx,(%rcx)
+	decq %rcx
+2:	movw %dx,(%rcx)
 	xorl %eax,%eax
 	ret
 20:	decq %rcx
@@ -64,8 +64,8 @@
 	jc 30f
 	cmpq threadinfo_addr_limit(%r8),%rcx
 	jae 30f
-3:	subq $3,%rcx
-	movl %edx,(%rcx)
+	subq $3,%rcx
+3:	movl %edx,(%rcx)
 	xorl %eax,%eax
 	ret
 30:	subq $3,%rcx
@@ -79,8 +79,8 @@
 	jc 40f
 	cmpq threadinfo_addr_limit(%r8),%rcx
 	jae 40f
-4:	subq $7,%rcx
-	movq %rdx,(%rcx)
+	subq $7,%rcx
+4:	movq %rdx,(%rcx)
 	xorl %eax,%eax
 	ret
 40:	subq $7,%rcx


