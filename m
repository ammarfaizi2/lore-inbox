Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263157AbUKBF1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUKBF1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274946AbUKBF1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:27:48 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:31248 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S376785AbUKAW2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:28:42 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fchown on unix domain sockets?
Date: Mon, 1 Nov 2004 22:27:51 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cm6d97$uts$1@abraham.cs.berkeley.edu>
References: <200410312255.00621.jmc@xisl.com> <Pine.LNX.4.53.0411011517570.29275@yvahk01.tjqt.qr> <200411011441.56524.jmc@xisl.com> <Pine.LNX.4.53.0411011546050.30106@yvahk01.tjqt.qr>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1099348071 31676 128.32.168.222 (1 Nov 2004 22:27:51 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 1 Nov 2004 22:27:51 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt  wrote:
>How about setting the permissions beforehand?

This makes you susceptible to TOCTTOU (race condition) attacks in some
cases.  Often, the only way to change ownership or permissions of a file
you want to operate on securely is to use fchown()/fchmod() etc.

It came as a surprise to me that open() + fchown()/fchmod() does not
work in some cases that chown()/chmod() do.  I wonder whether this has
any effect on applications.  Could this result in security holes in
applications that are unaware of this property?
