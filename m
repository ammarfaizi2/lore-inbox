Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932899AbWKLNoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbWKLNoh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWKLNoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:44:37 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:35202 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932899AbWKLNog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:44:36 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
Date: Sun, 12 Nov 2006 14:43:52 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200611112334.28889.bero@arklinux.org> <4556D9C0.3050103@qumranet.com>
In-Reply-To: <4556D9C0.3050103@qumranet.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YUyVFvPL1zgJI5j"
Message-Id: <200611121443.52887.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_YUyVFvPL1zgJI5j
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday, 12. November 2006 09:22, Avi Kivity wrote:
> Bernhard Rosenkraenzer wrote:
> > drivers/kvm/kvm_main.c: In function 'kvm_dev_ioctl_run':
> > drivers/kvm/kvm_main.c:153: error: 'asm' operand has impossible
> > constraints drivers/kvm/kvm_main.c:158: error: 'asm' operand has
> > impossible constraints

The attached patch makes it compile (but I'm not 100% sure it's the right 
thing to do, I'm not very experienced with gcc-style asm).

--Boundary-00=_YUyVFvPL1zgJI5j
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kvm_main-compilefix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kvm_main-compilefix.patch"

--- linux-2.6.18/drivers/kvm/kvm_main.c.ark	2006-11-12 14:40:09.000000000 +0100
+++ linux-2.6.18/drivers/kvm/kvm_main.c	2006-11-12 14:38:51.000000000 +0100
@@ -150,12 +150,12 @@
 
 static void load_fs(u16 sel)
 {
-	asm ("mov %0, %%fs" : : "g"(sel));
+	asm ("mov %0, %%fs" : : "m"(sel));
 }
 
 static void load_gs(u16 sel)
 {
-	asm ("mov %0, %%gs" : : "g"(sel));
+	asm ("mov %0, %%gs" : : "m"(sel));
 }
 
 #ifndef load_ldt

--Boundary-00=_YUyVFvPL1zgJI5j--
