Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbUBBUIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbUBBUHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:07:38 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:39047 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266037AbUBBUEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:04:46 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 21:04:44 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 39/42]
Message-ID: <20040202200444.GM6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


st5481_b.c:122: warning: concatenation of string literals with __FUNCTION__ is deprecated
[etc]
st5481_usb.c:134: warning: concatenation of string literals with __FUNCTION__ is deprecated
[etc]

__FUNCTION__ shouldn't be concatenated with other literals.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/isdn/hisax/st5481.h linux-2.4/drivers/isdn/hisax/st5481.h
--- linux-2.4-vanilla/drivers/isdn/hisax/st5481.h	Fri Jun 13 16:51:34 2003
+++ linux-2.4/drivers/isdn/hisax/st5481.h	Sat Jan 31 19:10:56 2004
@@ -219,13 +219,13 @@
 #define L1_EVENT_COUNT (EV_TIMER3 + 1)
 
 #define ERR(format, arg...) \
-printk(KERN_ERR __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_ERR __FILE__ ": %s: " format "\n" , __FUNCTION__ , ## arg)
 
 #define WARN(format, arg...) \
-printk(KERN_WARNING __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_WARNING __FILE__ ": %s: " format "\n" , __FUNCTION__ , ## arg)
 
 #define INFO(format, arg...) \
-printk(KERN_INFO __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_INFO __FILE__ ": %s: " format "\n" , __FUNCTION__ , ## arg)
 
 #include "isdnhdlc.h"
 #include "fsm.h"

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Do, or do not. There is no try.
