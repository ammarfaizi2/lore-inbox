Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVAYVxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVAYVxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVAYVxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:53:45 -0500
Received: from waste.org ([216.27.176.166]:43665 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262132AbVAYVub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:50:31 -0500
Date: Tue, 25 Jan 2005 13:50:15 -0800
From: Matt Mackall <mpm@selenic.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] SHA1 clarify kerneldoc
Message-ID: <20050125215015.GQ12076@waste.org>
References: <7.314297600@selenic.com> <200501252307.21993.vda@port.imtp.ilyichevsk.odessa.ua> <20050125211401.GO12076@waste.org> <200501252331.19527.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501252331.19527.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:31:19PM +0200, Denis Vlasenko wrote:
> On Tuesday 25 January 2005 23:14, Matt Mackall wrote:
> > On Tue, Jan 25, 2005 at 11:07:21PM +0200, Denis Vlasenko wrote:
> > > On Friday 21 January 2005 23:41, Matt Mackall wrote:
> > > > - * @W:      80 words of workspace
> > > > + * @W:      80 words of workspace, caller should clear
> > > 
> > > Why?
> > 
> > Are you asking why should the caller clear or why should it be cleared at all?
> > 
> > For the first question, having the caller do the clear avoids
> > redundant clears on repeated calls.
> > 
> > For the second question, forward security. If an attacker breaks into
> > the box shortly after a secret is generated, he may be able to recover
> > the secret from such state.
> 
> Whoops. I understood a comment as 'caller should clear prior to use'
> and this seems to be untrue (code overwrites entire W[80] vector
> without using prior contents).
> 
> Now I think that you most probably meant 'caller should clear AFTER use'.
> If so, comment should be amended.

Indeed.

Index: rc2mm1/lib/sha1.c
===================================================================
--- rc2mm1.orig/lib/sha1.c	2005-01-25 09:31:59.000000000 -0800
+++ rc2mm1/lib/sha1.c	2005-01-25 13:48:34.000000000 -0800
@@ -25,11 +25,15 @@
  *
  * @digest: 160 bit digest to update
  * @data:   512 bits of data to hash
- * @W:      80 words of workspace, caller should clear
+ * @W:      80 words of workspace (see note)
  *
  * This function generates a SHA1 digest for a single. Be warned, it
  * does not handle padding and message digest, do not confuse it with
  * the full FIPS 180-1 digest algorithm for variable length messages.
+ *
+ * Note: If the hash is security sensitive, the caller should be sure
+ * to clear the workspace. This is left to the caller to avoid
+ * unnecessary clears between chained hashing operations.
  */
 void sha_transform(__u32 *digest, const char *in, __u32 *W)
 {


-- 
Mathematics is the supreme nostalgia of our time.
