Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753164AbWKFOBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbWKFOBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbWKFOBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:01:20 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:43142 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1753164AbWKFOBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:01:20 -0500
Date: Mon, 6 Nov 2006 18:03:29 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] a minor fix for set_mb() in Documentation/memory-barriers.txt
Message-ID: <20061106150329.GA226@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

set_mb() is used by set_current_state() which needs mb(), not wmb().
I think it would be right to assume that set_mb() implies mb(), all
arches seem to do just this.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- d/Documentation/memory-barriers.txt~	2006-11-06 17:43:36.000000000 +0300
+++ d/Documentation/memory-barriers.txt	2006-11-06 17:44:26.000000000 +0300
@@ -1016,7 +1016,7 @@ There are some more advanced barrier fun
 
  (*) set_mb(var, value)
 
-     This assigns the value to the variable and then inserts at least a write
+     This assigns the value to the variable and then inserts a full memory
      barrier after it, depending on the function.  It isn't guaranteed to
      insert anything more than a compiler barrier in a UP compilation.
 

