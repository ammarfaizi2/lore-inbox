Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTLBSHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLBSEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:04:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:45456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262603AbTLBSE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:04:28 -0500
Date: Tue, 2 Dec 2003 10:04:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
In-Reply-To: <20031202063912.GD16507@lug-owl.de>
Message-ID: <Pine.LNX.4.58.0312020956120.1519@home.osdl.org>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet>
 <Pine.LNX.4.44.0312012302310.9674-100000@raven.themaw.net>
 <20031201153316.B3879@infradead.org> <200312020223.55505.snpe@snpe.co.yu>
 <20031202063912.GD16507@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Dec 2003, Jan-Benedict Glaw wrote:
>
> On Tue, 2003-12-02 02:23:55 +0000, snpe <snpe@snpe.co.yu>
> wrote in message <200312020223.55505.snpe@snpe.co.yu>:
> > Is there linux-abi for 2.6 kernel ?
>
> Nobody really cares about ABI (at least, not enough to keep one stable)
> while there's a good API. That requires sources, though, but that's a
> good thing...

People care _deeply_ about the user-visible Linux ABI - I personally think
backwards compatibility is absolutely _the_ most important issue for any
kernel, and breaking user-land ABI's is simply not done.

Sometimes we tweak user-visible stuff (for example, removing truly
obsolete system calls), but even then we're very very careful. Like
printing out warning messages for several _years_ before actually removing
the functionality.

The one exception tends to be "system management" ABI's, ie stuff that
normal programs don't use. So kernel updates do sometimes require new
utilities for doing things like firewall configuration, hardware setup
(ethernet tools, ifconfig etc), or - in the case of 2.6 - module loading
and unloading. Even that is frowned upon, and there has to be a good
reason for it.

At times, we've modified semantics of existing system behaviour subtly:
either to conform to standards, or because of implementation issues. It
doesn't happen often, and if it is found to break existing applications it
is not done at all (and the thing is fixed by adding a new system call
with the proper semantics, and leaving the old one broken).

You are, however, correct when it comes to internal kernel interfaces: we
care not at all about ABI's, and even API's are fluid and are freely
changed if there is a real technical reason for it. But that is only true
for the internal kernel stuff (where source is obviously a requirement
anyway).

		Linus
