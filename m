Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263241AbSJ1Kds>; Mon, 28 Oct 2002 05:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSJ1Kds>; Mon, 28 Oct 2002 05:33:48 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15111 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263241AbSJ1Kdq>; Mon, 28 Oct 2002 05:33:46 -0500
Message-Id: <200210281034.g9SAYip26620@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Roberto Nibali <ratz@drugphish.ch>
Subject: Re: New csum and csum_copy routines - and a test/benchmark program
Date: Mon, 28 Oct 2002 13:27:04 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org
References: <200210280819.g9S8Jfp25782@Port.imtp.ilyichevsk.odessa.ua> <3DBCF9D0.4030602@drugphish.ch>
In-Reply-To: <3DBCF9D0.4030602@drugphish.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 October 2002 06:48, Roberto Nibali wrote:
> Denis Vlasenko wrote:
> > I took some time to develop a little test/benchmark program
> > for csum and csum_copy routines (used in networking).
> > It has grown to include following features:
>
> I needed the attached patch with changes to make it work on my
> machine. Could you comment on it, please? Also a Makefile would be
> nicer ;).

Applied except for a bug ;) see below

--- timing_csum_copy.3/csum_kpf.S       Mon Oct 28 13:35:30 2002
+++ timing_csum_copy.3-ratz/csum_kpf.S  Mon Oct 28 09:43:21 2002
@@ -73,7 +73,7 @@
 40:
        PREFETCH(256(%esi))
 41:
-       addl/*  -128(%esi), %eax
+       addl    -128(%esi), %eax
        adcl    -124(%esi), %eax
        adcl    -120(%esi), %eax
        adcl    -116(%esi), %eax
@@ -97,7 +97,7 @@
        adcl    -44(%esi), %eax
        adcl    -40(%esi), %eax
        adcl    -36(%esi), %eax
-       adcl*/  -32(%esi), %eax
+       adcl    -32(%esi), %eax
        adcl    -28(%esi), %eax
        adcl    -24(%esi), %eax
        adcl    -20(%esi), %eax

No no no. First instruction nas to be an addl, that's why
there is a weird comment.  Just comment out lines
from addl -128... to adcl -36... and change adcl -23.. to addl

# as --version
GNU assembler 2.13.90.0.6 20021002
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `i386-pc-linux-gnu'.

What's yours?
--
vda
