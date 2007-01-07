Return-Path: <linux-kernel-owner+w=401wt.eu-S964955AbXAGTTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbXAGTTa (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbXAGTTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:19:30 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:48098 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964956AbXAGTT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:19:29 -0500
Date: Sun, 7 Jan 2007 11:19:00 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] math-emu/setcc: avoid gcc extension
Message-Id: <20070107111900.9d434162.randy.dunlap@oracle.com>
In-Reply-To: <974f8eb0d5984af6726a130082453916@kernel.crashing.org>
References: <20070106221947.8e01d404.randy.dunlap@oracle.com>
	<33e707f92df6b89a1c22f337f230cf32@kernel.crashing.org>
	<20070107104555.015aa79f.randy.dunlap@oracle.com>
	<974f8eb0d5984af6726a130082453916@kernel.crashing.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 20:12:42 +0100 Segher Boessenkool wrote:

> There's an extra tab in that last line.  Could you also
> please fix the indenting (use a tab, not spaces) -- I know
> it was there originally, but since there are only a few
> lines in that file like that...  :-)

how's this one?
---
From: Randy Dunlap <randy.dunlap@oracle.com>

setcc() in math-emu is written as a gcc extension statement expression
macro that returns a value.  However, it's not used that way and it's
not needed like that, so just make it a do-while non-extension macro
so that we don't use an extension when it's not needed.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/math-emu/status_w.h        |    5 +++--

---
 arch/i386/math-emu/status_w.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-2620-rc2.orig/arch/i386/math-emu/status_w.h
+++ linux-2620-rc2/arch/i386/math-emu/status_w.h
@@ -48,9 +48,10 @@
 
 #define status_word() \
   ((partial_status & ~SW_Top & 0xffff) | ((top << SW_Top_Shift) & SW_Top))
-#define setcc(cc) ({ \
-  partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
-  partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
+#define setcc(cc) do { \
+	partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
+	partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); \
+} while (0)
 
 #ifdef PECULIAR_486
    /* Default, this conveys no information, but an 80486 does it. */

