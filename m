Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTLZCMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 21:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbTLZCMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 21:12:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:12260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264450AbTLZCMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 21:12:18 -0500
Date: Thu, 25 Dec 2003 18:12:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-2?Q?=A3ukasz?= Osipiuk <l.osipiuk@zodiac.mimuw.edu.pl>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Pasza <pasza@zodiac.mimuw.edu.pl>, Paulinka <ofca@astercity.net>
Subject: Re: Strange process hangs on 2.6.0
In-Reply-To: <20031225211556.GA26469@lucash.localdomain>
Message-ID: <Pine.LNX.4.58.0312251809310.14452@home.osdl.org>
References: <20031225211556.GA26469@lucash.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Dec 2003, [iso-8859-2] ?ukasz Osipiuk wrote:
> 
> I am getting strange process hangs on 2.6.0 (stable). The same problem
> also occurred on many of test kernels (all that i checked out).

Sounds like the bash bug that is long-time (and that is just a lot harder 
to trigger on 2.4.x).

The problem is a timing issue in the bash pipeline setup, and if the 
child reads from stdin runs before the parent has fully set up the 
tty process group, the command will get stuck in stopped state.

Fedora core 1 is reported to have a fixed bash, so if you are RH-based, 
the easiest fix should be to just upgrade to that.

> emacs draws himself in the terminal but is not responding.
> Only SIGKILL manages to terminate it.

SIGCONT will fix it, but yeah, it's not something you want happening.

		Linus
