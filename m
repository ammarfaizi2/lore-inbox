Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUFUNA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUFUNA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUFUNA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:00:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:40621 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266214AbUFUNA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:00:58 -0400
Date: Mon, 21 Jun 2004 17:01:25 +0200
From: Andi Kleen <ak@suse.de>
To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
Cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 shows K7 with Pentium Pro erratum [Re: New version of
 early CPU detect]
Message-Id: <20040621170125.322f3297.ak@suse.de>
In-Reply-To: <20040621120416.GA2722@noc.xeon.eu.org>
References: <20040423043001.4bb05d5f.ak@suse.de>
	<20040621120416.GA2722@noc.xeon.eu.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004 14:04:16 +0200
Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org> wrote:


> 
> As it is, the family/model numbers seems to match, but it's obviously an
> AMD product..


Does this patch fix the problem?


-Andi


diff -u linux-2.6.7-work/arch/i386/kernel/cpu/common.c-o linux-2.6.7-work/arch/i386/kernel/cpu/common.c
--- linux-2.6.7-work/arch/i386/kernel/cpu/common.c-o	2004-06-16 12:22:43.000000000 +0200
+++ linux-2.6.7-work/arch/i386/kernel/cpu/common.c	2004-06-21 16:59:08.000000000 +0200
@@ -143,8 +143,9 @@
 	char *v = c->x86_vendor_id;
 	int i;
 
+	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	for (i = 0; i < X86_VENDOR_NUM; i++) {
-		if (cpu_devs[i]) {
+		if (cpu_devs[i] || early) {
 			if (!strcmp(v,cpu_devs[i]->c_ident[0]) ||
 			    (cpu_devs[i]->c_ident[1] && 
 			     !strcmp(v,cpu_devs[i]->c_ident[1]))) {
