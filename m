Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVIMHC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVIMHC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 03:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVIMHCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 03:02:55 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:7303 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932421AbVIMHCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 03:02:55 -0400
Date: Tue, 13 Sep 2005 10:02:38 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       jirislaby@gmail.com, lion.vollnhals@web.de
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
In-Reply-To: <20050912234200.10b2abe7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509131001400.31456@sbz-30.cs.Helsinki.FI>
References: <200509130010.38483.lion.vollnhals@web.de> <43260817.7070907@gmail.com>
 <84144f0205091221431827b126@mail.gmail.com> <200509130033.11109.dtor_core@ameritech.net>
 <20050912234200.10b2abe7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > FWIW I also prefer spelling out the structure I am allocating.

On Mon, 12 Sep 2005, Andrew Morton wrote:
> It hurts readability.  Quick question: is this code correct?
> 
> 	dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
> 
> you don't know.  You have to go hunting down the declaration of `dev' to
> find out.

Andrew, how about something like this?

			Pekka

[PATCH] CodingStyle: memory allocation

This patch adds a new chapter on memory allocation to Documentation/CodingStyle.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 CodingStyle |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletion(-)

Index: 2.6-mm/Documentation/CodingStyle
===================================================================
--- 2.6-mm.orig/Documentation/CodingStyle
+++ 2.6-mm/Documentation/CodingStyle
@@ -410,7 +410,26 @@ Kernel messages do not have to be termin
 Printing numbers in parentheses (%d) adds no value and should be avoided.
 
 
-		Chapter 13: References
+		Chapter 13: Allocating memory
+
+The kernel provides the following general purpose memory allocators:
+kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
+documentation for further information about them.
+
+The preferred form for passing a size of a struct is the following:
+
+	p = kmalloc(sizeof(*p), ...);
+
+The alternative form where struct name is spelled out hurts readability and
+introduces an opportunity for a bug when the pointer variable type is changed
+but the corresponding sizeof that is passed to a memory allocator is not.
+
+Casting the return value which is a void pointer is redundant. The conversion
+from void pointer to any other pointer type is guaranteed by the C programming
+language.
+
+
+		Chapter 14: References
 
 The C Programming Language, Second Edition
 by Brian W. Kernighan and Dennis M. Ritchie.
