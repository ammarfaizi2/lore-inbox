Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVARTmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVARTmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVARTix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:38:53 -0500
Received: from hera.kernel.org ([209.128.68.125]:61420 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261408AbVARTgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:36:13 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: kbuild: Implicit dependence on the C compiler
Date: Tue, 18 Jan 2005 19:35:43 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <csjoef$gkt$1@terminus.zytor.com>
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com> <20050118190513.GA16120@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1106076944 17054 127.0.0.1 (18 Jan 2005 19:35:44 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 18 Jan 2005 19:35:44 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050118190513.GA16120@mars.ravnborg.org>
By author:    Sam Ravnborg <sam@ravnborg.org>
In newsgroup: linux.dev.kernel
> 
> To give some background info about why kbuild does what it does.
> A kernel being compiled partly with and partly without say -regparm=3
> will result in a non-workable kernel.
> 
> The same goes for a kernel that is partly built using gcc 2.96, partly
> using 3.3.4 for example.
> 
> So kbuild pr. default will force a recompile for any .o file where
> opions to gcc differ, or name of gcc has changed. Today no check has
> been implemented to check the actual gcc executable timestamp - and
> neither is this planned.
> 

I would argue that "name of gcc has changed" is possibly a condition
that does more harm than good.  It is just as frequently used to have
wrappers, like distcc, as it is to have different versions.

(FWIW, nothing is more obnoxious than having the kernel tree blown
away when you try to compile in the one missing driver needed to talk
to the rest of your distcc cluster.)

> Default behaviour today is to recompile if anything change.
> 
> But as hpa points outs this hits us with nfs mounted kernel tree when
> performing a make install - because install has vmlinux as prerequsite.
> So this leaves us with at least two possibilitites:
> 1) Unconditionally execute make install assuming vmlinux is up-to-date.
>    make modules_install run unconditionally, so this is already know
>    practice
> 2) Detect that aother user is running the build - and therefore skip
>    the kernel and the module build.
>    This is a rather intrusive change since with current kbuild structure
>    it is rather difficult to stop this in all relevant cases.

I say unconditionally do make install, but there really, REALLY, need
to be a way to override this check manually.

	-hpa
