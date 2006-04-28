Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWD1QPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWD1QPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWD1QPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:15:12 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:4824 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030471AbWD1QPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:15:11 -0400
Date: Fri, 28 Apr 2006 11:15:43 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <20060428151543.GA7397@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> <200604281333.41358.blaisorblade@yahoo.it> <20060428114823.GA3641@ccure.user-mode-linux.org> <200604281554.32665.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604281554.32665.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 03:54:31PM +0200, Blaisorblade wrote:
> Additionally, if this flag ever goes into clone, it mustn't be named 
> CLONE_TIME, but CLONE_NEWTIME (or CLONE_NEWUTS). And given CLONE_NEWNS, it's 
> IMHO ok to have unshare(CLONE_NEWTIME) to mean "unshare time namespace", even
> if it's incoherent with unshare(CLONE_FS) - the incoherency already exists 
> with CLONE_NEWNS.

I wonder if they should be CLONE_* at all.  Given that we are likely
to run out of free CLONE_* bits, unshare will have to reuse bits that
don't have anything to do with sharing resources (CSIGNAL,
CLONE_VFORK, etc), and it doesn't seem that nice to have two different
CLONE_* flags with the same value, different meaning, only one of
which can actually be used in clone.

It seems better to use UNSHARE_*, with the current bits that are
common to unshare and clone being defined the same, i.e.
	#define UNSHARE_VM CLONE_VM

				Jeff
