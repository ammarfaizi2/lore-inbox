Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbTI3NxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTI3NxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:53:07 -0400
Received: from chaos.sr.unh.edu ([132.177.249.105]:63193 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S261434AbTI3NxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:53:03 -0400
Date: Tue, 30 Sep 2003 09:50:14 -0400 (EDT)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: "David S. Miller" <davem@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>, <bunk@fs.tum.de>,
       <acme@conectiva.com.br>, <netdev@oss.sgi.com>, <pekkas@netcore.fi>,
       <lksctp-developers@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
In-Reply-To: <20030930022410.08c5649c.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0309300940030.4956-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003, David S. Miller wrote:

> I think they are the same.  It's module building depending upon the
> kernel image being up to date.
> 
> modules: vmlinux image
> 	... blah blah blah
> 
> or however you want to express it in the makefiles.

I strongly disagree with this. What the makefiles currently do is correct, 
i.e. if you "make modules" you'll only get updated modules, you didn't ask 
for an updated vmlinux, and so you don't get it. The module you get is 
built correctly, i.e. you'd get the same result if you had rebuilt vmlinux 
before, since the building of the module does not depend on a "correct" 
vmlinux at all.

If in just about any project you type "make some_object.o", you don't 
expect make to recompile and rebuild the rest of the project, either, you 
ask it to 'make' something, and will build exactly that something and the 
prerequisites necessary to get it right.

A sidenote is that if you are using modversions, building the modules
correctly needs versioning information from vmlinux, so in that case we
need vmlinux to be up-to-date. And that's why in this case vmlinux will be
rebuilt first (if something changed) - otherwise the modules you were
asking for wouldn't be correct. But the fact the you get an updated
vmlinux is just a side-effect, you didn't ask for it, and thus you can't
rely on it.

Think about the meaning of "make".


With respect to the actual discussion, my opinion is that it's desirable 
to have the core kernel not change depending on whether or not something 
is compiled modular, but I believe there are cases which justify an 
exception, and IPv6 seems to be one of them. Modversions will catch this
and prevent the user from inserting the module and accidentally crash the 
system, so I think it's all fine.


--Kai


