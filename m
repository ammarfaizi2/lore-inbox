Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUHBWmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUHBWmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUHBWmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:42:35 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:18451 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S264386AbUHBWmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:42:33 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] get_random_bytes returns the same on every boot
Date: Mon, 2 Aug 2004 22:42:17 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cemg09$hun$1@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.58.0407222254440.3652@pingvin.fazekas.hu>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1091486537 18391 128.32.168.222 (2 Aug 2004 22:42:17 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 2 Aug 2004 22:42:17 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balint Marton  wrote:
>At boot time, get_random_bytes always returns the same random data, as if
>there were a constant random seed.  [This is because no entropy is
>available yet.]

Are there any consequences of this for security?  A number of network
functions call get_random_bytes() to get unguessable numbers; if those
numbers are guessable, security might be compromised.  Note that most init
scripts save randomness state from the last reboot and fill it into the
entropy pool after boot, but before then any callers to get_random_bytes()
might be vulnerable.  Has anyone ever audited all places that call
get_random_bytes() to see if any of them might pose a security exposure
during the window of time between boot and execution of init scripts?
For instance, are TCP sequence numbers, SYN cookies, etc. vulnerable?

(Needless to say, seeding the pool with just the time of day and the
system hostname is not enough to defend against such attacks.)
