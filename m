Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264753AbTE1O0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTE1O0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:26:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55825 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264753AbTE1O0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:26:37 -0400
Date: Wed, 28 May 2003 07:39:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ryan Anderson <ryan@michonline.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sparse errors
In-Reply-To: <20030528053832.GH585@michonline.com>
Message-ID: <Pine.LNX.4.44.0305280738540.7569-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 May 2003, Ryan Anderson wrote:
>
> Some symbols with type SYM_NODE are getting ctype->base_type==NULL,
> causing a segfault in type_difference:422.

Fixed like this, causing the proper warning..

		Linus

---
# This is a BitKeeper generated patch for the following project:
# Project Name: TSCT - The Silly C Tokenizer
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.345   -> 1.346  
#	             parse.c	1.97    -> 1.98   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/28	torvalds@home.transmeta.com	1.346
# Check whether a parameter declaration is a type before trying
# to parse it as a type.
# --------------------------------------------
#
diff -Nru a/parse.c b/parse.c
--- a/parse.c	Wed May 28 07:38:53 2003
+++ b/parse.c	Wed May 28 07:38:53 2003
@@ -886,6 +886,10 @@
 			break;
 		}
 		
+		if (!lookup_type(token)) {
+			warn(token->pos, "non-ANSI parameter list");
+			break;
+		}
 		token = parameter_declaration(token, &sym);
 		/* Special case: (void) */
 		if (!*list && !sym->ident && sym->ctype.base_type == &void_ctype)

