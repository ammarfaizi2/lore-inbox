Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317895AbSFSOsU>; Wed, 19 Jun 2002 10:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317899AbSFSOsT>; Wed, 19 Jun 2002 10:48:19 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:5547 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S317895AbSFSOsR>;
	Wed, 19 Jun 2002 10:48:17 -0400
Message-ID: <041c01c217a0$3aa34520$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0206181915001.1773-100000@penguin.transmeta.com>
Subject: Re: linux 2.5.23
Date: Wed, 19 Jun 2002 10:47:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm...looks like ITERATE_MDDEV interaction with _raw_spin_lock is hosed....I dont' quite see the problem

Line 754 is:
ITERATE_MDDEV(mddev,tmp) {

  gcc -Wp,-MD,./.md.o.d -D__KERNEL__ -I/usr/src/linux-2.5.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-point
er -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENA
ME=md -DEXPORT_SYMTAB  -c -o md.o md.c
md.c: In function `md_print_devices':
md.c:754: parse error before `do'
md.c:748: warning: unused variable `mddev'
md.c:747: warning: unused variable `rdev'
md.c:746: warning: unused variable `tmp2'
md.c:746: warning: unused variable `tmp'
md.c: At top level:
md.c:754: parse error before `while'
md.c:754: parse error before `&'
md.c:754: warning: type defaults to `int' in declaration of `_raw_spin_lock'
md.c:754: warning: function declaration isn't a prototype
md.c:754: conflicting types for `_raw_spin_lock'
/usr/src/linux-2.5.23/include/asm/spinlock.h:117: previous declaration of `_raw_spin_lock'
md.c:754: warning: data definition has no type or storage class
md.c:754: parse error before `&'
md.c:754: warning: type defaults to `int' in declaration of `_raw_spin_lock'
md.c:754: warning: function declaration isn't a prototype
md.c:754: warning: data definition has no type or storage class
md.c:757: warning: type defaults to `int' in declaration of `rdev'


