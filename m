Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVARTEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVARTEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVARTEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:04:31 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:45361 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261394AbVARTE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:04:27 -0500
Date: Tue, 18 Jan 2005 20:05:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
Message-ID: <20050118190513.GA16120@mars.ravnborg.org>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC363D.1090106@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hpa
> >It better be difficult. You want to recompile when changing gcc.
> >Try this untested patch.
> Sorry, but that's baloney.  Saying "it better be difficult" is 
> equivalent to saying "kbuild is smarter than you."

To give some background info about why kbuild does what it does.
A kernel being compiled partly with and partly without say -regparm=3
will result in a non-workable kernel.

The same goes for a kernel that is partly built using gcc 2.96, partly
using 3.3.4 for example.

So kbuild pr. default will force a recompile for any .o file where
opions to gcc differ, or name of gcc has changed. Today no check has
been implemented to check the actual gcc executable timestamp - and
neither is this planned.

Default behaviour today is to recompile if anything change.

But as hpa points outs this hits us with nfs mounted kernel tree when
performing a make install - because install has vmlinux as prerequsite.
So this leaves us with at least two possibilitites:
1) Unconditionally execute make install assuming vmlinux is up-to-date.
   make modules_install run unconditionally, so this is already know
   practice
2) Detect that aother user is running the build - and therefore skip
   the kernel and the module build.
   This is a rather intrusive change since with current kbuild structure
   it is rather difficult to stop this in all relevant cases.

	Sam
