Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271148AbTHRAqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271153AbTHRAqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:46:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:39040 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271148AbTHRAqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:46:30 -0400
Date: Mon, 18 Aug 2003 01:46:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] use simple_strtoul for unsigned kernel parameters
Message-ID: <20030818004618.GA5094@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The largest "unsigned int" value doesn't fit in a "long", on many machines.
So we should use simple_strtoul, not simple_strtol, to decode these values.

Enjoy,
-- Jamie

--- orig-2.5.75/kernel/params.c	2003-07-08 21:44:26.000000000 +0100
+++ laptop-2.5.75/kernel/params.c	2003-08-17 03:17:40.116594605 +0100
@@ -165,9 +165,9 @@
 	}
 
 STANDARD_PARAM_DEF(short, short, "%hi", long, simple_strtol);
-STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", long, simple_strtol);
+STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", unsigned long, simple_strtoul);
 STANDARD_PARAM_DEF(int, int, "%i", long, simple_strtol);
-STANDARD_PARAM_DEF(uint, unsigned int, "%u", long, simple_strtol);
+STANDARD_PARAM_DEF(uint, unsigned int, "%u", unsigned long, simple_strtoul);
 STANDARD_PARAM_DEF(long, long, "%li", long, simple_strtol);
 STANDARD_PARAM_DEF(ulong, unsigned long, "%lu", unsigned long, simple_strtoul);
 
