Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVLFNcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVLFNcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLFNcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:32:24 -0500
Received: from agmk.net ([217.73.31.34]:39172 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S932568AbVLFNcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:32:23 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Questions on __initdata
Date: Tue, 6 Dec 2005 14:32:12 +0100
User-Agent: KMail/1.9
References: <20051204151533.13df37c6.khali@linux-fr.org> <200512041741.43591.arnd@arndb.de> <20051205203730.GA2753@linux-mips.org>
In-Reply-To: <20051205203730.GA2753@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cLZlDshVr09KEFq"
Message-Id: <200512061432.12693.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_cLZlDshVr09KEFq
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Dnia poniedziałek, 5 grudnia 2005 21:37, Ralf Baechle napisał:

> blurb.c: At top level:
> blurb.c:3: error: somevariable causes a section type conflict

This was a gcc bug. The current gcc mainline works fine.

-- 
to_be || !to_be == 1, to_be | ~to_be == -1

--Boundary-00=_cLZlDshVr09KEFq
Content-Type: text/plain;
  charset="utf-8";
  name="id-336.s"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="id-336.s"

	.file	"id.c"
	.section	.initdata,"aw",@progbits
	.align 4
	.type	somevariable.0, @object
	.size	somevariable.0, 4
somevariable.0:
	.zero	4
	.section	.inittext,"ax",@progbits
	.p2align 4,,15
.globl somefunc
	.type	somefunc, @function
somefunc:
	movl	somevariable.0, %edx
	addl	%edx, %eax
	movl	%eax, somevariable.0
	ret
	.size	somefunc, .-somefunc
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.3.6 (PLD Linux)"

--Boundary-00=_cLZlDshVr09KEFq
Content-Type: text/plain;
  charset="utf-8";
  name="id-420.s"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="id-420.s"

	.file	"id.c"
	.section	.inittext,"ax",@progbits
	.p2align 4,,15
.globl somefunc
	.type	somefunc, @function
somefunc:
	addl	somevariable.1299, %eax
	movl	%eax, somevariable.1299
	ret
	.size	somefunc, .-somefunc
	.section	.initdata,"aw",@progbits
	.align 4
	.type	somevariable.1299, @object
	.size	somevariable.1299, 4
somevariable.1299:
	.zero	4
	.ident	"GCC: (GNU) 4.2.0 20051201 (experimental)"
	.section	.note.GNU-stack,"",@progbits

--Boundary-00=_cLZlDshVr09KEFq
Content-Type: text/x-csrc;
  charset="utf-8";
  name="id.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="id.c"

int __attribute__((section(".inittext"))) somefunc(int x)
{
    static int __attribute__((section(".initdata"))) somevariable;
    somevariable += x;
    return somevariable;
}

--Boundary-00=_cLZlDshVr09KEFq--
