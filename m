Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVITMb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVITMb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVITMb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:31:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62992 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964998AbVITMb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:31:56 -0400
Date: Tue, 20 Sep 2005 13:31:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Al Viro <viro@ftp.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050920123149.GA29112@flint.arm.linux.org.uk>
Mail-Followup-To: Pekka J Enberg <penberg@cs.Helsinki.FI>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <84144f0205092004187f86840c@mail.gmail.com> <20050920114003.GA31025@flint.arm.linux.org.uk> <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 03:20:18PM +0300, Pekka J Enberg wrote:
> Well, yes, but for initialization, I would prefer something like what Al 
> Viro suggested. To me, initialization is a separate issue from kmalloc. I 
> do get your point but I just don't think sizeof(struct foo) is the answer.

No matter, and no matter what CodingStyle says, I won't be changing
my style of kmalloc for something which I disagree with.

Since some of the other major contributors to the kernel appear to
also disagree with the statement, I think that the entry in
CodingStyle must be removed.

Plus, this means that kernel janitors should _not_ fix up code to
follow the sizeof(*p) style.

---

It isn't clear that the use of p = kmalloc(sizeof(*p), ...) is
preferred over p = kmalloc(sizeof(struct foo), ...) - in fact,
there are some good reasons to use the latter form.

Therefore, the choice of which to use should be left up to the
developer concerned, and not written in to the coding style.

For discussion, please see the thread:
      http://lkml.org/lkml/2005/9/18/29

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -410,26 +410,7 @@ Kernel messages do not have to be termin
 Printing numbers in parentheses (%d) adds no value and should be avoided.
 
 
-		Chapter 13: Allocating memory
-
-The kernel provides the following general purpose memory allocators:
-kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
-documentation for further information about them.
-
-The preferred form for passing a size of a struct is the following:
-
-	p = kmalloc(sizeof(*p), ...);
-
-The alternative form where struct name is spelled out hurts readability and
-introduces an opportunity for a bug when the pointer variable type is changed
-but the corresponding sizeof that is passed to a memory allocator is not.
-
-Casting the return value which is a void pointer is redundant. The conversion
-from void pointer to any other pointer type is guaranteed by the C programming
-language.
-
-
-		Chapter 14: References
+		Chapter 13: References
 
 The C Programming Language, Second Edition
 by Brian W. Kernighan and Dennis M. Ritchie.



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
