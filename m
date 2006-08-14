Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbWHNT2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWHNT2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWHNT2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:28:12 -0400
Received: from dsl254-015-118.sea1.dsl.speakeasy.net ([216.254.15.118]:55651
	"HELO www2.muking.org") by vger.kernel.org with SMTP
	id S932678AbWHNT2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:28:11 -0400
Message-ID: <44E0CEC9.2050308@hilman.org>
Date: Mon, 14 Aug 2006 12:28:09 -0700
From: Kevin Hilman <kevin@hilman.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Linux-atm-general@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] net/atm compile error on ARM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atm_proc_exit() is declared as __exit, and thus in .exit.text.  On
some architectures (ARM) .exit.text is discarded at compile time, and
since atm_proc_exit() is called by some other __init functions, it
results in a link error.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: ixp4xx/net/atm/proc.c
===================================================================
--- ixp4xx.orig/net/atm/proc.c
+++ ixp4xx/net/atm/proc.c
@@ -507,7 +507,7 @@ err_out:
 	goto out;
 }

-void __exit atm_proc_exit(void)
+void atm_proc_exit(void)
 {
 	atm_proc_dirs_remove();
 }
