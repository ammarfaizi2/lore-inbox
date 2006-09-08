Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752077AbWIHEKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWIHEKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWIHEKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:10:47 -0400
Received: from nef2.ens.fr ([129.199.96.40]:37135 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1752077AbWIHEKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:10:46 -0400
Date: Fri, 8 Sep 2006 06:10:34 +0200
From: David Madore <david.madore@ens.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908041034.GB24135@clipper.ens.fr>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907225429.GA30916@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 06:10:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 12:54:29AM +0200, Pavel Machek wrote:
> You contradict yourself.

I don't see how that is.  I understand that you could be unconvinced
by my reasoning and by my arguments, but I don't see how they are
contradictory.

The bottom line is that, whereas for root making syscalls fail (or,
worse, in the case of setuid(), behave subtly diffently) is a radical
change, for non-root it is something which should always be expected
(fork() can fail for lack of resources, write() can fail for quota
exhaution, etc.), and not something an attacker should be able to
exploit.

>			   Yes, you are decreasing security of suid
> non-root programs, and yes, someone will take advantage of that. Plus,
> you can easily do away without this risk.

I wish I could offer more assurance, but unfortunately the solutions
which do away with the risk come with a great cost:

> Just add all "usual" capabilities when execing
> suid/sgid-anything.

This makes it trivial to regain capabilities: just create a program
suid yourself and exec it.  OK, we can say that "yourself" won't work,
but you still only need to find another uid to hijack...  Not too
satisfactory.  Perhaps if we create a capability to add the 's' bit to
anything?  That's a bit messy, but perhaps feasible.

>		      Alternatively disallow suid/sgid-anything exec
> when all "usual" capabilities are not present.

This is probably too stringent: remove any trivial capability
whatsoever and you lose a rather important ability.

But certainly this is a matter for some debate...

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
