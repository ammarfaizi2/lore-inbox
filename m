Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271117AbTHMLZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271813AbTHMLZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:25:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:25762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271117AbTHMLZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:25:15 -0400
Date: Wed, 13 Aug 2003 04:25:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-Id: <20030813042544.5064b3f4.akpm@osdl.org>
In-Reply-To: <1060772769.8009.4.camel@localhost.localdomain>
References: <20030813045638.GA9713@middle.of.nowhere>
	<20030813014746.412660ae.akpm@osdl.org>
	<20030813091958.GA30746@gates.of.nowhere>
	<20030813025542.32429718.akpm@osdl.org>
	<1060772769.8009.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> Put the likely(pos) in the asm/prefetch for Athlon until someone can
>  figure out what is going on with some specific Athlons, 2.6 and certain
>  kernels (notably 4G/4G).

<riffles through random config options>

Like this?

What happens if someone runs a K6 kernel on a K7?

Or various other CPU types?  What is the matrix here?

I don't like the way this is headed...

--- 25/include/asm-i386/processor.h~athlon-prefetch-fix	2003-08-13 04:21:01.000000000 -0700
+++ 25-akpm/include/asm-i386/processor.h	2003-08-13 04:22:10.000000000 -0700
@@ -568,6 +568,10 @@ static inline void rep_nop(void)
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
+#ifdef CONFIG_MK7
+	if (unlikely(x == NULL))
+		return;		/* athlons like to oops in prefetch(0) */
+#endif
 	alternative_input(ASM_NOP4,
 			  "prefetchnta (%1)",
 			  X86_FEATURE_XMM,

_

