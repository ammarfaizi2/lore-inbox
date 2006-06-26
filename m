Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWFZF3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWFZF3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWFZF3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 01:29:49 -0400
Received: from xenotime.net ([66.160.160.81]:17630 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964781AbWFZF3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 01:29:48 -0400
Date: Sun, 25 Jun 2006 22:32:29 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] zlib inflate: fix function definitions
Message-Id: <20060625223229.95ac6e16.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix function definitions to be ANSI-compliant:
lib/zlib_inflate/inffast.c:68:1: warning: non-ANSI definition of function 'inflate_fast'
lib/zlib_inflate/inftrees.c:33:1: warning: non-ANSI definition of function 'zlib_inflate_table'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 lib/zlib_inflate/inffast.c  |    6 +++---
 lib/zlib_inflate/inftrees.c |    9 ++-------
 2 files changed, 5 insertions(+), 10 deletions(-)

--- linux-2617-g9.orig/lib/zlib_inflate/inffast.c
+++ linux-2617-g9/lib/zlib_inflate/inffast.c
@@ -63,10 +63,10 @@
       bytes, which is the maximum length that can be coded.  inflate_fast()
       requires strm->avail_out >= 258 for each loop to avoid checking for
       output space.
+
+    - @start:	inflate()'s starting value for strm->avail_out
  */
-void inflate_fast(strm, start)
-z_streamp strm;
-unsigned start;         /* inflate()'s starting value for strm->avail_out */
+void inflate_fast(z_streamp strm, unsigned start)
 {
     struct inflate_state *state;
     unsigned char *in;      /* local strm->next_in */
--- linux-2617-g9.orig/lib/zlib_inflate/inftrees.c
+++ linux-2617-g9/lib/zlib_inflate/inftrees.c
@@ -29,13 +29,8 @@ const char inflate_copyright[] =
    table index bits.  It will differ if the request is greater than the
    longest code or if it is less than the shortest code.
  */
-int zlib_inflate_table(type, lens, codes, table, bits, work)
-codetype type;
-unsigned short *lens;
-unsigned codes;
-code **table;
-unsigned *bits;
-unsigned short *work;
+int zlib_inflate_table(codetype type, unsigned short *lens, unsigned codes,
+			code **table, unsigned *bits, unsigned short *work)
 {
     unsigned len;               /* a code's length in bits */
     unsigned sym;               /* index of code symbols */


---
