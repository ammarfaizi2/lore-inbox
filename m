Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUD0XNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUD0XNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUD0XNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:13:44 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:62671 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264305AbUD0XNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:13:42 -0400
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
From: Rusty Russell <rusty@rustcorp.com.au>
To: Marc Boucher <marc@linuxant.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, pmarques@grupopie.com,
       c-d.hailfinger.kernel.2004@gmx.net, jon787@tesla.resnet.mtu.edu,
       malda@slashdot.org
In-Reply-To: <20040427165819.GA23961@valve.mbsi.ca>
References: <20040427165819.GA23961@valve.mbsi.ca>
Content-Type: text/plain
Message-Id: <1083107550.30985.122.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 09:12:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 02:58, Marc Boucher wrote:
> Actually, we also have no desire nor purpose to prevent tainting. The purpose
> of the workaround is to avoid repetitive warning messages generated when
> multiple modules belonging to a single logical "driver"  are loaded (even when
> a module is only probed but not used due to the hardware not being present).

You lied about the license, rather than submit a one-line change to
kernel/module.c.

This shows a lack of integrity that I find personally repulsive.

Name: Only Print Taint Message Once
Status: Trivial

Only print the tainted message the first time.  Its purpose is to warn
users that we can't support them, not to fill their logs.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22310-linux-2.6.6-rc2-bk5/kernel/module.c .22310-linux-2.6.6-rc2-bk5.updated/kernel/module.c
--- .22310-linux-2.6.6-rc2-bk5/kernel/module.c	2004-04-22 08:04:00.000000000 +1000
+++ .22310-linux-2.6.6-rc2-bk5.updated/kernel/module.c	2004-04-28 09:03:31.000000000 +1000
@@ -1131,7 +1131,7 @@ static void set_license(struct module *m
 		license = "unspecified";
 
 	mod->license_gplok = license_is_gpl_compatible(license);
-	if (!mod->license_gplok) {
+	if (!mod->license_gplok && !(tainted & TAINT_PROPRIETARY_MODULE)) {
 		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
 		       mod->name, license);
 		tainted |= TAINT_PROPRIETARY_MODULE;

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

