Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUIXGGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUIXGGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUIXGDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:03:53 -0400
Received: from chello083144090118.chello.pl ([83.144.90.118]:6411 "EHLO pluto")
	by vger.kernel.org with ESMTP id S268502AbUIXGDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:03:23 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Donald Duckie <schipperke2000@yahoo.com>
Subject: Re: unresolved symbol __udivsi3_i4
Date: Fri, 24 Sep 2004 08:01:56 +0200
User-Agent: KMail/1.7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040924021050.689.qmail@web53608.mail.yahoo.com>
In-Reply-To: <20040924021050.689.qmail@web53608.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409240801.57848.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 of September 2004 04:10, Donald Duckie wrote:
> hi!
>
> can somebody please help me how to overcome this
> problem:
> unresolved symbol __udivsi3_i4

the kernel module tries to use a divide operation on machine
that doesn't support that. this could be caused by %,/ operators
or floating point arithmetic. gcc uses emulation in these cases.

# objdump -T /lib/libgcc_s.so.1|grep div
000024c0 g    DF .text  00000162  GLIBC_2.0   __divdi3
00002b80 g    DF .text  000001ed  GCC_3.0     __udivmoddi4
00002870 g    DF .text  00000120  GLIBC_2.0   __udivdi3

you can link module with libgcc.a or fix it.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
