Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWCPXxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWCPXxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWCPXxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:53:50 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:48025 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751253AbWCPXxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:53:50 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Date: Thu, 16 Mar 2006 23:53:36 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dvctq0$c0o$1@taverner.CS.Berkeley.EDU>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net>
Reply-To: daw-usenet@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1142553216 12312 128.32.168.222 (16 Mar 2006 23:53:36 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Thu, 16 Mar 2006 23:53:36 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
>nah, the only place that using symbolic names for true and false
>is a problem is when someone #defines or enums them bassackwards.

Here's another danger associated with #define TRUE:
    int x = ...;
    if (x == TRUE)
        do_something();
A surprise happens if x is initialized to something other than 0 or 1.
Looks like there maybe as many as a hundred instances of the above
pattern in the kernel.  Most of them seem safe, but I don't know whether
they all are, and there are too many for me to check them all.

For instance, take a look at net/core/ethtool.c:ethtool_set_rx_csum()
and drivers/net/ixgb/ixgb_ethtool.c:ixgb_set_rx_csum() and
drivers/net/ixgb/ixgb_main.c:ixgb_configure_rx() for how it handles
adapter->rx_csum to see one example that strikes me as dubious.
