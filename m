Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbTJPEMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTJPEMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:12:36 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:38785
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262677AbTJPEMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:12:35 -0400
Date: Thu, 16 Oct 2003 00:12:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] constant_test_bit doesn't like my gcc
In-Reply-To: <20031015211012.5daac8fc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0310160008530.2328@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com>
 <20031015211012.5daac8fc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> >  cpu_has_foo and friends don't work at all with my gcc 3.2.2-5 and i'm 
> >  branching off into all sorts of tests (which is another story...). i also 
> >  took the liberty of removing the const volatile...
> 
> The volatile is rather important.

Good point, how about;

Index: linux-2.6.0-test7-mm1/include/asm-i386/bitops.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test7-mm1/include/asm-i386/bitops.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bitops.h
--- linux-2.6.0-test7-mm1/include/asm-i386/bitops.h	15 Oct 2003 09:02:10 -0000	1.1.1.1
+++ linux-2.6.0-test7-mm1/include/asm-i386/bitops.h	16 Oct 2003 04:10:37 -0000
@@ -241,7 +241,7 @@ static int test_bit(int nr, const volati
 
 static __inline__ int constant_test_bit(int nr, const volatile unsigned long * addr)
 {
-	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
+	return ((1UL << (nr & 31)) & (addr[nr >> 5])) != 0;
 }
 
 static __inline__ int variable_test_bit(int nr, const volatile unsigned long * addr)
