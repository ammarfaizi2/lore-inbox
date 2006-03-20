Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWCTTyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWCTTyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWCTTyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:54:09 -0500
Received: from terminus.zytor.com ([192.83.249.54]:19094 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964955AbWCTTyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:54:07 -0500
Message-ID: <441F0859.2010703@zytor.com>
Date: Mon, 20 Mar 2006 11:54:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       torvalds@osdl.org, akpm@osdl.org
Subject: Merge strategy for klibc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, as of this point, I think klibc is in quite good shape; my
testing so far is showing that it can be used as a drop-in replacement
for the kernel root-mounting code.

That being said, there is guaranteed to be breakage, for two reasons:

a. There are several architectures which don't have klibc ports yet.
    Since I don't have access to them, I can't really do them, either.
    It's usually a matter of an afternoon or less to port klibc to a
    new architecture, though, if you have a working development
    environment for it.

b. There are a gajillion options in the way Linux handles its root
    filesystem.  I have tried to implement them all, but I haven't been
    able to test some of the more exotic conditions, mostly due to the
    fact that every boot environment I set up takes a *lot* of time and
    maintenance.  This has in fact been the by far the bulk of the time
    I've spent on klibc, not writing code.

Thus, it's not clear to me what particular approach makes most sense for 
pushing upstream.

1. Mechanism: the easiest for me would of course be git pull, but I'm 
certainly willing to break it up into patches or any other useful way.

A diff of by git tree from 2.6.16 gives:

   766 files changed, 84024 insertions(+), 3059 deletions(-)


2. State: the current git tree cleans up the arch-specific code for i386 
and x86-64; other architectures are going to need some minor cleanup in 
setup.c or the equvalent.

The current git tree includes a number of utilities, like dash (sh), 
which aren't used by the default kinit configuration.  Additionally, 
right now kinit is built monolitically, in other words there isn't a 
CONFIG_ option to turn off nfsmount, for example.

Again, I'm more than willing to put the tree in any particular state 
that makes sense.


3. Path: it probably would make sense to push this into -mm first?


It's taken this long, I'd like to make this actually happen...

	-hpa

