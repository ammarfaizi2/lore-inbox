Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWAPMSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWAPMSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWAPMSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:18:34 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:28978 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750700AbWAPMSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:18:33 -0500
Date: Mon, 16 Jan 2006 21:18:34 +0900
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] omit symbol size field in print_symbol()
Message-ID: <20060116121834.GD539@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116121611.GA539@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't find useful usage for the symbol size in print_symbol().
And symbolsize seems to be fixed when vmlinux or modules are compiled.
So we can calculate it from vmlinux or modules.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
----
 kallsyms.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

--- 2.6-git/kernel/kallsyms.c.orig	2006-01-11 14:50:37.000000000 +0900
+++ 2.6-git/kernel/kallsyms.c	2006-01-11 14:52:23.000000000 +0900
@@ -246,10 +246,9 @@ int __print_symbol(const char *fmt, unsi
 		sprintf(buffer, "0x%lx", address);
 	else {
 		if (modname)
-			sprintf(buffer, "%s+%#lx/%#lx [%s]", name, offset,
-				size, modname);
+			sprintf(buffer, "%s+%#lx [%s]", name, offset, modname);
 		else
-			sprintf(buffer, "%s+%#lx/%#lx", name, offset, size);
+			sprintf(buffer, "%s+%#lx", name, offset);
 	}
 	return printk(fmt, buffer);
 }
