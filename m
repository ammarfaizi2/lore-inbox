Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUBSBCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUBSBCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:02:11 -0500
Received: from dp.samba.org ([66.70.73.150]:40888 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267312AbUBSBCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:02:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16436.2817.900018.285167@samba.org>
Date: Thu, 19 Feb 2004 12:01:53 +1100
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <E1Atbi7-0004tf-O7@localhost>
References: <1q4Si-658-5@gated-at.bofh.it>
	<1q7no-8ss-7@gated-at.bofh.it>
	<1qfb7-7s5-19@gated-at.bofh.it>
	<1qmPm-6Gl-11@gated-at.bofh.it>
	<1qpWI-1Sa-1@gated-at.bofh.it>
	<1qqpO-2lx-3@gated-at.bofh.it>
	<1qqzv-2tr-3@gated-at.bofh.it>
	<1qqJc-2A2-5@gated-at.bofh.it>
	<1qHAR-2Wm-49@gated-at.bofh.it>
	<1qIwr-5GB-11@gated-at.bofh.it>
	<1qIwr-5GB-9@gated-at.bofh.it>
	<1qIQ1-5WR-27@gated-at.bofh.it>
	<1qIZt-6b9-11@gated-at.bofh.it>
	<1qJsF-6Be-45@gated-at.bofh.it>
	<E1Atbi7-0004tf-O7@localhost>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal,

 > Evil question: do you need to be case-preserving? 'Cause if not, you
 > could simply squash all incoming filenames from case-insensitive clients
 > to some canonical form (say, all lower-case) and use that.

yes, we have to be case preserving, but thats not the problem. Keeping
some name mapping in user space or xattrs is tedious but conceptually
easy and potentially quite efficient.

The problem is that Samba isn't the only program to be accessing these
directories. Multi-protocol file servers and file servers where users
also have local access are common. That means we can't assume that
some other filesystem user hasn't created a file which matches in a
case-insensitive manner. That means we need to do an awful lot of
directory scans.

I also understand the decision Linus has made that we won't be doing
anything fundamental at the filesystem level to fix this, so we will
just have to live with it. 

Cheers, Tridge
