Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUIXVL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUIXVL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268831AbUIXVL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:11:26 -0400
Received: from scrye.com ([216.17.180.1]:44433 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S262279AbUIXVLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:11:23 -0400
Date: Fri, 24 Sep 2004 15:09:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
X-Draft-From: ("scrye.linux.kernel" 70809)
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
	<20040924143714.GA826@openzaurus.ucw.cz>
Message-Id: <20040924210958.A3C5AA2073@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

Pavel> Hi!
>> Was trying to swsusp my 2.6.9-rc2-mm1 laptop tonight. It churned
>> for a while, but didn't hibernate. Here are the messages.
>> 
>> ....................................................................................................
>> .........................swsusp: Need to copy 34850 pages Sep 23
>> 16:53:37 voldemort kernel: hibernate: page allocation
>> failure. order:8, mode:0x120 Sep 23 16:53:37 voldemort kernel:
Pavel> Out of memory... Try again with less loaded system. 

The system was no more loaded than usual. I have 1GB memory and 4GB of
swap defined. I almost never touch swap. It might have been 100mb into
the 4Gb of swap when this happened. 

What would cause it to be out of memory? 
swsup needs to be reliable... rebooting when you are using your memory
kinda defeats the purpose of swsusp. 

Felipe W Damasio <felipewd@terra.com.br> sent me a patch, but I
haven't had a chance to try it yet:

- --- linux-2.6.9-rc2-mm2/kernel/power/swsusp.c.orig	2004-09-23 23:46:49.292975768 -0300
+++ linux-2.6.9-rc2-mm2/kernel/power/swsusp.c	2004-09-24 00:07:01.933626368 -0300
@@ -657,6 +657,9 @@
 	int diff = 0;
 	int order = 0;
 
+	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
+	nr_copy_pages += 1 << order;
+
 	do {
 		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
 		if (diff) {


kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBVI0m3imCezTjY0ERAgI1AJ0VatDEm27SAh2dvS65XwNNpReSEACeNBkn
uRXNP9tQcUlEZ1BAKON1nSo=
=3rnm
-----END PGP SIGNATURE-----
