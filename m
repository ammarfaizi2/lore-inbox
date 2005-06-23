Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVFWD0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVFWD0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVFWD0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:26:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262035AbVFWDZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:25:32 -0400
Date: Wed, 22 Jun 2005 20:24:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42BA271F.6080505@pobox.com>
Message-ID: <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
 <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com>
 <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com>
 <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
> Concrete example:  I have a git tree on local disk.  I need to find out 
> where, between 2.6.12-rc1 and 2.6.12, a driver broke.  This requires 
> that I have -ALL- linux-2.6.git/refs/tags on disk already, so that I can 
> bounce quickly and easily between tags.

Absolutely not.

I might have my private tags in my kernel, and you might have your private 
tags ("tested") in your kernel, so there is no such thing as "ALL".

The fact that BK had it was a BK deficiency, and just meant that you 
basically couldn't use tags at all with BK, the "official ones" excepted. 
It basically meant that nobody else than me could ever tag a tree. Do you 
not see how that violates the very notion of "distributed"?

This is _exactly_ the same thing as if you said "I want to merge with ALL
BRANCHES".  That notion doesn't exist. You can rsync the whole repository,
and you'll get all branches from that repository, that's really by virtue
of doing a filesystem operation, not because you asked git to get you all
branches.

A tag is even _implemented_ exactly like a branch, except it allows (but
does not require) that extra step of signing an object. The only
difference is literally whether it is in refs/branches or refs/tags.

> It is valuable to have a local copy of -all- tags, -before- you need 
> them.

You seem to not realize that "all tags" is a nonsensical statement in a 
distributed system.

If you want to have a list of official tags, why not just do exactly that? 
What's so hard with saying "ok, that place has a list of 'official' tags, 
let's fetch them".

How would you fetch them? You might use rsync, for example. Or maybe wget. 
Or whatever. The point is that this works already. You're asking for 
something nonsensical, outside of just a script that does

	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/

See? What's your complaint with just doing that?

			Linus
