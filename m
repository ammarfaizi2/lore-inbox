Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTJINWC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTJINWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:22:02 -0400
Received: from ns.suse.de ([195.135.220.2]:37795 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262127AbTJINV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:21:57 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Subject: genksyms bug: Warning: "per_cpu__local_per_cpu_offset" [...] has no
 CRC!
From: Andreas Schwab <schwab@suse.de>
X-Yow: Are you still an ALCOHOLIC?
Date: Thu, 09 Oct 2003 15:21:54 +0200
Message-ID: <jey8vua6ml.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this warning when building 2.6.0-test[567] for ia64 with
MODVERSIONS enabled.  This is a bug in genksyms, it can't cope with some
arguments of __typeof__.  The following patch will fix that.  Actually the
argument of __typeof__ is an abstract declarator, but the genksyms parser
has no production for that; decl_specifier_seq also matches some invalid
constructs, but I don't think this is a problem in practice, since the
compiler will reject them.

Andreas.

--- linux-2.6.0-test7/scripts/genksyms/parse.y.~1~	2003-10-08 21:24:04.000000000 +0200
+++ linux-2.6.0-test7/scripts/genksyms/parse.y	2003-10-09 15:03:38.000000000 +0200
@@ -197,7 +197,7 @@ storage_class_specifier:
 type_specifier:
 	simple_type_specifier
 	| cvar_qualifier
-	| TYPEOF_KEYW '(' type_specifier ')'
+	| TYPEOF_KEYW '(' decl_specifier_seq ')'
 
 	/* References to s/u/e's defined elsewhere.  Rearrange things
 	   so that it is easier to expand the definition fully later.  */

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
