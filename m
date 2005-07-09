Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVGIJwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVGIJwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 05:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVGIJwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 05:52:22 -0400
Received: from twin.jikos.cz ([213.151.79.26]:41885 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S261479AbVGIJwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 05:52:21 -0400
Date: Sat, 9 Jul 2005 11:52:17 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: u u <userstack@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.x.x Execution Process Question
In-Reply-To: <96968b4e05070819286482937c@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0507091150030.7118@twin.jikos.cz>
References: <96968b4e05070819286482937c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, u u wrote:

> Im looking for some help on some research I am conducting. Im trying to
> understand the complete execution process from start to finish of an ELF
> executable object on the i386 platform in particular, but x86_64 works
> as well. So far I have come up with the following:
> Shell passes arguments and environment to execve() -> sys_execve() ->
> do_execve() -> search_binary_handler() -> ?

If you are looking specifically for handling of the ELF format, then you 
have stopped your sequence sooner than it began to be interesting :)

search_binary_handler() then passes, in the case of the ELF object, the 
control to the function load_elf_binary(), implemented in fs/binfmt_elf.c

This is the place where the "execve() process" starts being object-type 
specific.

> 2.0 and 2.2. Im trying to find out the specifics of it all, for example
> which registers are zeroed out before passing control to userspace and
> where it happens. How does the stack look when control is passed? These
> types of specifics are what I had in mind.

You will find all this in load_elf_binary() and it's surroudings.

-- 
JiKos.
