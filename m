Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbTJHAyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 20:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTJHAyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 20:54:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:4803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262929AbTJHAyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 20:54:54 -0400
Date: Tue, 7 Oct 2003 17:54:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert White <rwhite@casabyte.com>
cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com>
Message-ID: <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Oct 2003, Robert White wrote:
> 
> What is gained by having the independent file descriptor context that would
> be *broken* for lack of that independence?

You're coming at it from the wrong end. Sharing resources is inherently
bad. If there is no reason to share, you shouldn't share.

The reason people use threads is that sharing the VM space has real 
advantages: it makes context switching much cheaper (fewer hw resources in 
the form of TLB usages) and it allows for much faster synchronization 
through a shared address space.

But the same isn't true of file descriptors or a lot of other software-
level abstractions. There are no inherent advantages to sharing, and in
fact sharing just gives more opportunity for race conditions, bad
interaction etc.

For example, one reason _not_ to share is that the subthread may want to 
be as invisible to the "main thread" as possible. That's just good 
programming practice - trying to isolate and encapsulate as much data as 
possible.

The same way you shouldn't make all your variables global, you shouldn't 
make all your data structures global unless you have a reason.

		Linus

