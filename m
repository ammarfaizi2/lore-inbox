Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753748AbWKRBJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbWKRBJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 20:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbWKRBJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 20:09:50 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:38926 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S1753748AbWKRBJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 20:09:49 -0500
Date: Sat, 18 Nov 2006 02:09:46 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] emit logging when a process receives a fatal signal
Message-ID: <20061118010946.GB31268@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sun Nov 19 00:08:47 CET 2006
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that sometimes processes disappear on some heavily used system
of mine without any logging. So I've written a patch against 2.6.18.2
which emits logging when a process emits a fatal signal.

Signed-off-by: Folkert van Heusden <folkert@vanheusden.com>

--- linux-2.6.18.2/kernel/signal.c	2006-11-04 02:33:58.000000000 +0100
+++ linux-2.6.18.2.new/kernel/signal.c	2006-11-17 15:59:13.000000000 +0100
@@ -706,6 +706,15 @@
 	struct sigqueue * q = NULL;
 	int ret = 0;
 
+	if (sig == SIGQUIT || sig == SIGILL  || sig == SIGTRAP ||
+	    sig == SIGABRT || sig == SIGBUS  || sig == SIGFPE  ||
+	    sig == SIGSEGV || sig == SIGXCPU || sig == SIGXFSZ ||
+	    sig == SIGSYS  || sig == SIGSTKFLT)
+	{
+		printk(KERN_WARNING "Sig %d send to %d owned by %d.%d (%s)\n",
+			sig, t -> pid, t -> uid, t -> gid, t -> comm);
+	}
+
 	/*
 	 * fast-pathed signals for kernel-internal things like SIGSTOP
 	 * or SIGKILL.


Folkert van Heusden

www.vanheusden.com/multitail - multitail is tail on steroids. multiple
               windows, filtering, coloring, anything you can think of
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
