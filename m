Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTEFEj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbTEFEj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:39:27 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:16289 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S262358AbTEFEj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:39:26 -0400
Subject: [CFT] klibc-based userspace ipconfig and nfsroot replacements
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1052196718.15298.17.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 May 2003 21:51:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done some work within the framework of klibc and initramfs to
replace the in-kernel ipconfig and nfsroot code.  A snapshot of the
klibc CVS tree is available at:

    http://www.speakeasy.org/~bos/klibc-20020505.tar.bz2

This contains a klibc tree that builds against 2.5.68 and 2.5.69 (at
least on x86), along with three programs of interest:

      * ipconfig was written by Russell King several months ago.  I've
        removed bit rot from the code and made some changes so that it
        handles both DHCP and static configuration.
      * nfsmount is a filesystem mounter for NFS v2 and v3, UDP and
        TCP.  Tested only against Linux servers so far.
      * kinit is a single statically-linked binary that incorporates
        both ipconfig and nfsmount, and which can be dropped into an
        initramfs filesystem for use as /sbin/init.  It parses
        /proc/cmdline for "ip=" and "nfsroot=" sections, performs IP
        configuration, NFS mounting, and finally does a pivot_root to
        the freshly-mounted filesystem.

I don't yet have quite enough hardware handy to be able to test the last
10 lines of code in kinit without substantial inconvenience, but It
Should Work (TM).

If you're interested in kicking the tyres and ironing out problems, you
may want to subscribe to the klibc mailing list so that HPA and others
can see what's going on:

    http://www.zytor.com/mailman/listinfo/klibc

Otherwise, please send problem reports to me directly.

	<b

