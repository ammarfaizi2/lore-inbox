Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267711AbUBSCoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267712AbUBSCoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:44:54 -0500
Received: from [140.239.227.29] ([140.239.227.29]:5251 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267711AbUBSCov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:44:51 -0500
Date: Wed, 18 Feb 2004 21:44:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: tridge@samba.org
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040219024426.GA3901@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, tridge@samba.org,
	Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
References: <1qqzv-2tr-3@gated-at.bofh.it> <1qqJc-2A2-5@gated-at.bofh.it> <1qHAR-2Wm-49@gated-at.bofh.it> <1qIwr-5GB-11@gated-at.bofh.it> <1qIwr-5GB-9@gated-at.bofh.it> <1qIQ1-5WR-27@gated-at.bofh.it> <1qIZt-6b9-11@gated-at.bofh.it> <1qJsF-6Be-45@gated-at.bofh.it> <E1Atbi7-0004tf-O7@localhost> <16436.2817.900018.285167@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16436.2817.900018.285167@samba.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 12:01:53PM +1100, tridge@samba.org wrote:
> The problem is that Samba isn't the only program to be accessing these
> directories. Multi-protocol file servers and file servers where users
> also have local access are common. That means we can't assume that
> some other filesystem user hasn't created a file which matches in a
> case-insensitive manner. That means we need to do an awful lot of
> directory scans.

Actually, not necessarily.  What if Samba gets notifications of all
filename renames and creates in the directory, so that after the
initial directory scan, it can keep track of what filenames are
present in the directory?  It can then "prove the negative", as you
put it, without having to continuously do directory scans.

Yeah, there can be some race conditions, but Samba already has to deal
with the race condition where it tries to create "MaKeFiLe" either
just before or just after a Posix process creates "Makefile".  

						- Ted
