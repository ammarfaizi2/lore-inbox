Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbUKTDFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUKTDFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUKTDD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:03:59 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:63732 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S263099AbUKTDBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:01:22 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
Date: Sat, 20 Nov 2004 12:04:37 +0900
User-Agent: KMail/1.5.4
Cc: hari@in.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       varap@us.ibm.com
References: <419CACE2.7060408@in.ibm.com> <20041119153052.21b387ca.akpm@osdl.org> <1100912759.4987.207.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1100912759.4987.207.camel@dyn318077bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411201204.37750.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've forgotten CC-ing.

On Saturday 20 November 2004 10:05, Badari Pulavarty wrote:

> 4) Load the second kernel to be booted using
>
>    kexec -p <second-kernel> --args-linux --append="root=<root-dev> dump
>    init 1 memmap=exactmap memmap=640k@0 memmap=32M@16M"
>
> But kexec doesn't seem to like option "-p".
> Even when I removed "-p", its complaining about "--args-linux"


I also have the kexec which does not have "-p" option.
Instead of using "-p" option, I use "-l" option after changing the kexec
as follows.

--- kexec-tools-1.98/kexec/kexec.c.orig	2004-10-31 19:42:34.000000000 +0900
+++ kexec-tools-1.98/kexec/kexec.c	2004-10-31 19:43:01.000000000 +0900
@@ -243,7 +243,7 @@ static int my_load(const char *type, int
 	if (sort_segments(segments, nr_segments) < 0) {
 		return -1;
 	}
-	result = kexec_load(entry, nr_segments, segments, 0);
+	result = kexec_load(entry, nr_segments, segments, 1);
 	if (result != 0) {
 		/* The load failed, print some debugging information */
 		fprintf(stderr, "kexec_load failed: %s\n",


