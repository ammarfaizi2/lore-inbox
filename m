Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266372AbUFWQZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266372AbUFWQZD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265786AbUFWQTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:19:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17591 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266565AbUFWQLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:11:34 -0400
Date: Wed, 23 Jun 2004 17:11:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries.Brouwer@cwi.nl
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: _POSIX_SYMLOOP_MAX
Message-ID: <20040623161134.GE12308@parcelfarce.linux.theplanet.co.uk>
References: <UTC200406231435.i5NEZFQ08577.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200406231435.i5NEZFQ08577.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:35:15PM +0200, Andries.Brouwer@cwi.nl wrote:
> (cf http://marc.theaimsgroup.com/?l=linux-kernel&m=102426036209591&w=2)

Hrm...  Actually, after looking through that thread again, I have to admit
that I'm not happy with my reaction back then (basically, "it's ugly and
pointless, let's forget it unless something saner develops out of it").
It _was_ ugly and broken in that form, all right, but now I wonder how much
of the idea behind the current symlink patchkit had come from (successfully
forgotten) background thinking of how that something saner might look like ;-/

In case if that's what had happened, I owe Andries an apology for sloppiness -
it can be considered as fixed and sanitized version of his idea and all I can
say in defense is that I really did not remember his stuff when I came up with
that.  Which is not worth much, obviously.  And in any case I should've
checked the archives and look for related stuff that had come up earlier.
My apologies.  [cc'd to l-k since the symlink stuff had been posted there,
possibly with missing credit]

The differences between the current patchkit and patch in question are:
	a) no cleanup flags, just a method that does cleanup.  Obvious, much
cleaner, easy to do and mentioned as possibility in the original.
	b) no special "done" flag for "we don't have anything left for us to
traverse", just the usual check for "no string given" (aka. "is it NULL?").
	c) no magic flags => no problem with getting them clobbered
	d) no prototype changes, we just call a helper that stores pointer into
array in nameidata.  I wonder why Andries hadn't done that, BTW - especially
if there was a planned work on removing recursion; in that case array is an
obvious thing to do.  And that doesn't break existing filesystems.
	e) bunch of leaks in failure paths of foo_follow_link() fixed
	f) ->readlink() cleanup.  It could be actually done in either variant
and is fairly natural thing to do.
