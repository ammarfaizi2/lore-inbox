Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWH1U3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWH1U3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWH1U3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:29:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48911 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751487AbWH1U3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:29:52 -0400
Date: Mon, 28 Aug 2006 16:29:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] Add section on function return values to CodingStyle
Message-ID: <Pine.LNX.4.44L0.0608281629140.6800-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as776) adds a new chapter to Documentation/CodingStyle,
explaining the circumstances under which a function should return
0 for failure and non-zero for success as opposed to a negative
error code for failure and 0 for success.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Index: mm/Documentation/CodingStyle
===================================================================
--- mm.orig/Documentation/CodingStyle
+++ mm/Documentation/CodingStyle
@@ -532,6 +532,40 @@ appears outweighs the potential value of
 something it would have done anyway.
 
 
+		Chapter 16: Function return values and names
+
+Functions can return values of many different kinds, and one of the
+most common is a value indicating whether the function succeeded or
+failed.  Such a value can be represented as an error-code integer
+(-Exxx = failure, 0 = success) or a "succeeded" boolean (0 = failure,
+non-zero = success).
+
+Mixing up these two sorts of representations is a fertile source of
+difficult-to-find bugs.  If the C language included a strong distinction
+between integers and booleans then the compiler would find these mistakes
+for us... but it doesn't.  To help prevent such bugs, always follow this
+convention:
+
+	If the name of a function is an action or an imperative command,
+	the function should return an error-code integer.  If the name
+	is a predicate, the function should return a "succeeded" boolean.
+
+For example, "add work" is a command, and the add_work() function returns 0
+for success or -EBUSY for failure.  In the same way, "PCI device present" is
+a predicate, and the pci_dev_present() function returns 1 if it succeeds in
+finding a matching device or 0 if it doesn't.
+
+All EXPORTed functions must respect this convention, and so should all
+public functions.  Private (static) functions need not, but it is
+recommended that they do.
+
+Functions whose return value is the actual result of a computation, rather
+than an indication of whether the computation succeeded, are not subject to
+this rule.  Generally they indicate failure by returning some out-of-range
+result.  Typical examples would be functions that return pointers; they use
+NULL or the ERR_PTR mechanism to report failure.
+
+
 
 		Appendix I: References
 

