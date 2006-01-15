Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751883AbWAOJsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWAOJsF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 04:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWAOJsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 04:48:05 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:2298 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751883AbWAOJsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 04:48:04 -0500
From: Junio C Hamano <junkio@cox.net>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Move read_mostly definition to asm/cache.h
References: <20060111173321.GC28018@quicksilver.road.mcmartin.ca>
	<Pine.LNX.4.64.0601110951210.5073@g5.osdl.org>
	<7vslruqx5w.fsf@assigned-by-dhcp.cox.net>
	<20060112053618.GH25353@tachyon.int.mcmartin.ca>
Date: Sun, 15 Jan 2006 01:48:02 -0800
In-Reply-To: <20060112053618.GH25353@tachyon.int.mcmartin.ca> (Kyle McMartin's
	message of "Thu, 12 Jan 2006 00:36:18 -0500")
Message-ID: <7vu0c57rfx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle McMartin <kyle@parisc-linux.org> writes:

> Alternatively, if I had (I haven't touched the tree, just format-patch'd
> which looked right) used git-reset --hard HEAD and been up to date
> (working tree and index file) with whatever ended up being pointed
> to by HEAD, right?

Yes.

> I'll try to remember the symbolic-ref thing for next time, usually when
> this happens I just blow away the last commit and try again, but I felt
> adventurous today. :)

After making the mistake of committing to "master":

	$ git commit ;# oops, to the master
        $ git show-branch origin master read-mostly
	!  [origin] latest update from Linus
         * [master] latest for read-mostly
        --
         * [master] latest for read-mostly
        +* [origin] last update from Linus

you could do this, which would be easier to visualize:

	$ git branch read-mostly ;# may need branch "-f" if exists.
        $ git reset --hard HEAD^ ;# rewind the current head by one.

Which would give you this:

        $ git show-branch origin master read-mostly
	!   [origin] latest update from Linus
         *  [master] latest update from Linus
          ! [read-mostly] latest for read-mostly
        --
          ! [read-mostly] latest for read-mostly
        +*! [origin] last update from Linus

