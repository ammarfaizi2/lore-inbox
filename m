Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTGAREj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTGAREj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:04:39 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:37613 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id S262955AbTGAREh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:04:37 -0400
Date: Tue, 1 Jul 2003 19:18:58 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: chaffee@cs.berkeley.edu, urban@teststation.com
Subject: [bug?] How to stuff 21 bits in __u16
Message-ID: <20030701171858.GB9668@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chaffee@cs.berkeley.edu,
	urban@teststation.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I have a question to definition from nls.h (both 2.4.21 and 2.5.56):

The utf-8 decoding stuff seems to handle all characters up to
0x7fff_ffff. But then it supposes to store them in wchar_t and it is
defined as __u16. To me it seems like a bug (which should moreover be
trivial to fix with something like:)

--- linux-2.4.21/include/linux/nls.h.orig	2003-06-30 10:12:37.000000000 +0200
+++ linux-2.4.21/include/linux/nls.h	2003-07-01 19:07:17.000000000 +0200
@@ -4,7 +4,7 @@
 #include <linux/init.h>
 
 /* unicode character */
-typedef __u16 wchar_t;
+typedef __u32 wchar_t;
 
 struct nls_table {
 	char *charset;

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
