Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVHHT5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVHHT5C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHHT5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:57:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932246AbVHHT5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:57:01 -0400
Date: Mon, 8 Aug 2005 12:56:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: "David S. Miller" <davem@davemloft.net>, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
In-Reply-To: <20050808194249.GA6729@kroah.com>
Message-ID: <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org>
References: <20050808.103304.55507512.davem@davemloft.net>
 <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
 <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Aug 2005, Greg KH wrote:
> 
> Hm, how do you revert a git patch?

Something like this?

	#!/bin/sh
	. git-sh-setup-script || die "Not a git archive"
	rev=$(git-rev-parse --verify --revs-only "$@") || exit
	git-diff-tree -R -p $rev | git-apply --index &&
		echo "Revert $rev" | git commit

Just name it "git-revert-script" and it might do what you want to do.

It may not have the nicest error messages: if you try to revert a merge
(which won't have a diff), git-apply will say something like

	fatal: No changes

which isn't exactly being helpful. And the revert message could be made 
more interesting (like putting the first line of the description of what 
we reverted into the message instead of just the revision number).

		Linus
