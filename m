Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUA0IUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 03:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUA0IUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 03:20:43 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:12500 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262745AbUA0IUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 03:20:41 -0500
To: davidm@hpl.hp.com
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for ia64
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
	<20040120090004.48995f2a.akpm@osdl.org>
	<16401.57298.175645.749468@napali.hpl.hp.com>
	<16402.19894.686335.695215@cargo.ozlabs.ibm.com>
	<16405.41953.344071.456754@napali.hpl.hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 27 Jan 2004 03:11:03 -0500
In-Reply-To: <16405.41953.344071.456754@napali.hpl.hp.com>
Message-ID: <yq0y8rtreug.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

David,

I am just nitpicking here, but wouldn't it be better to stick to the
convention of all upper case defines for the #ifdef check?

Maybe use something like?
#define ARCH_EXTABLE_COMPARE_ENTRIES ia64_extable_compare_entries

Cheers,
Jes


@@ -18,7 +18,25 @@
 extern struct exception_table_entry __start___ex_table[];
 extern struct exception_table_entry __stop___ex_table[];
 
-#ifndef ARCH_HAS_SORT_EXTABLE
+#ifndef extable_compare_entries
+
+/*
+ * Compare exception-table entries L and R and return <0 if L is smaller, 0 if L and R are
+ * equal and >0 if L is bigger.
+ */
