Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTJCCyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 22:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTJCCyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 22:54:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43143 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263618AbTJCCyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 22:54:37 -0400
Date: Fri, 3 Oct 2003 03:53:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Ulrich Drepper <drepper@redhat.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Message-ID: <20031003025338.GA15089@mail.shareable.org>
References: <1065139380.736.109.camel@cube> <Pine.LNX.4.44.0310021720510.7833-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310021720510.7833-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And it may or may not make sense to not have a "/proc/<nn>/task/<yy>/fd"
> directory at all if the thread shares file descriptors with the thread 
> group leader. That would be a fairly easy optimization.

If you make /proc/.../fd return the same inode numbers for the
identical file descriptor tables, that would be just as good for fuser
performance.

fuser would stat() each of the /proc/<nn>/task/<yy>/fd entries and see
that they're the same as the group leader.

It is the same number of operations as checking for the non-existence
of /proc/<nn>/task/<yy>/fd entries, but more flexible.

Alternatively you could make the task fd directories be symbolic
links to the group leader fd directory.

-- Jamie
