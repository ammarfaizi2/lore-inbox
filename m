Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTJYUOf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbTJYUOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:14:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64718 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262790AbTJYUOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:14:33 -0400
Date: Sat, 25 Oct 2003 21:14:30 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test9
Message-ID: <20031025201427.GT7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 12:09:10PM -0700, Linus Torvalds wrote:
 
> If it corrupts data, is a security issue, or causes lockups or just basic
> nonworkingness: and this happens on hardware that _normal_ people are
> expected to have, then it's critical.  Otherwise, it's noise and should
> wait.

Hmm...  Do you count the stuff like "driver foo dereferences after kfree()"
as major when fix is to reorder two consequent lines in said driver?  I'm
perfectly happy with sitting on that until 2.6.0 or later, but we might be
better off with a separate tree that would contain *only* such stuff and
would keep track of it for later merges.

Proposed rules:
	a) all changes must be local and separate.  Anything that affects
more than one place is either splittable, in which case it's more than
one change, or doesn't belong there.
	b) chunks stay separate until they go into the main tree.  IOW,
they are fed one by one (when merges are OK) and they become separate
changesets.
	c) all chunks must be mergable into -STABLE.  IOW, the rules are
the same as for 2.6.1 - as far as merging into that tree is concerned,
we are not in -RC anymore.

Hell, I could even start using BK for that...
