Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVHBU2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVHBU2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 16:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVHBU2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 16:28:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11517 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261764AbVHBU2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 16:28:33 -0400
Message-ID: <42EFD6F6.4020304@mvista.com>
Date: Tue, 02 Aug 2005 13:26:30 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Re: [PATCH] NMI watch dog notify patch
References: <12270.1122693891@ocs3.ocs.com.au> <42EEA910.5060902@mvista.com>
In-Reply-To: <42EEA910.5060902@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------020705010809040706000608"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020705010809040706000608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It seems that the subject patch generates a warning (missed it on the 
compile).  Here is a patch to eliminate the warning.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------020705010809040706000608
Content-Type: text/plain;
 name="fix_notify_die_warn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_notify_die_warn.patch"

Source: MontaVista Software, Inc. George Anzinger<george@mvista.com>
Type: Defect Fix 

Description:
	This patch eliminates the warning generated in die_nmi() when
	calling notify_die() by adding "const" to notify_die()'s
	definition.

Signed-off-by: George Anzinger <george@mvista.com>
	
Index: linux-2.6.13-rc/include/asm-i386/kdebug.h
===================================================================
--- linux-2.6.13-rc.orig/include/asm-i386/kdebug.h
+++ linux-2.6.13-rc/include/asm-i386/kdebug.h
@@ -41,7 +41,7 @@ enum die_val {
 	DIE_PAGE_FAULT,
 };
 
-static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
+static inline int notify_die(enum die_val val, const char *str,struct pt_regs *regs,long err,int trap, int sig)
 {
 	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
 	return notifier_call_chain(&i386die_chain, val, &args);

--------------020705010809040706000608--
