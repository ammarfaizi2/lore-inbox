Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUKHSHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUKHSHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUKHSFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:05:49 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:49670 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261151AbUKHSEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:04:14 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Date: Mon, 8 Nov 2004 19:04:13 +0100
User-Agent: KMail/1.7.1
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de>
In-Reply-To: <20041108163101.GA13234@stusta.de>
Cc: Adrian Bunk <bunk@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411081904.13969.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 of November 2004 17:31, you wrote:
> On Mon, Nov 08, 2004 at 05:19:35PM +0100, Andi Kleen wrote:
> > > Rethinking it, I don't even understand the sprintf example in your
> > > changelog entry - shouldn't an inclusion of kernel.h always get it
> > > right?
> >
> > Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str)
> > transparently.
>
> Which gcc is "Newer"?
>
> My gcc 3.4.2 didn't show this problem.

#include <stdio.h>
#include <string.h>
char buf[128];
void test(char *str)
{
    sprintf(buf, "%s", str);
}

gcc -Wall sp.c -S -O2 -fomit-frame-pointer -mregparm=3

        .file   "sp.c"
        .text
        .p2align 4,,15
.globl test
        .type   test, @function

test:
        movl    %eax, %edx
        movl    $buf, %eax
        jmp     strcpy

        .size   test, .-test
        .comm   buf,128,32
        .section        .note.GNU-stack,"",@progbits
        .ident  "GCC: (GNU) 3.4.3 (PLD Linux)"

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
