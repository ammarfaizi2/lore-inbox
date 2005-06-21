Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVFUPld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVFUPld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVFUPkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:40:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26789 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262132AbVFUPht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:37:49 -0400
Date: Tue, 21 Jun 2005 08:39:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
In-Reply-To: <Pine.LNX.4.58.0506211304320.2915@skynet>
Message-ID: <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506211304320.2915@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Dave Airlie wrote:
>
> fatal: Entry 'Documentation/DocBook/scsidrivers.tmpl' would be overwritten
> by merge. Cannot merge.
> 
> but I haven't touched that tree so I shouldn't get merge issues..
> 
> whatsup?

The most common issue is that your index is not in sync. For many 
operations, that's just goign to slow things down a lot (ie a diff migth 
take a long time instead of being instantaneous), but for a merge it's 
considered an error.

Does "git-diff-files -p" show any output? That's a dead give-away.

Do "git-update-cache --refresh" to make sure your index file matches your 
working directory.

I guess I can make the "git pull" script do that automatically (some other
scripts do, like "git commit", which also depends on having an up-to-date
index).

		Linus
