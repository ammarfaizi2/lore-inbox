Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTEMWdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTEMWdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:33:46 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:56260 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261787AbTEMWdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:33:44 -0400
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <1052865981.3ec175bd59bc9@netmail.pipex.net>
Date: Tue, 13 May 2003 23:46:21 +0100
From: "Shaheed R. Haque" <srhaque@iee.org>
Cc: <linux-kernel@vger.kernel.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net> <1050177383.3e986f67b7f68@netmail.pipex.net> <1050177751.2291.468.camel@localhost> <1050222609.3e992011e4f54@netmail.pipex.net> <1050244136.733.3.camel@localhost> <1052826556.3ec0dbbc1d993@netmail.pipex.net> <20030513130257.78ab1a2e.akpm@digeo.com>
In-Reply-To: <20030513130257.78ab1a2e.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail 2.2.0-pre13
X-PIPEX-username: aozw65%dsl.pipex.com
X-Originating-IP: 81.86.202.62
X-Usage: Use of PIPEX NetMail is subject to the PIPEX Terms and Conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Andrew Morton <akpm@digeo.com>:

> "Shaheed R. Haque" <srhaque@iee.org> wrote:
> >
> > - Add ability to restrict the the default CPU affinity mask so that 
> >  sys_setaffinity() can be used to implement exclusive access to a CPU.
> 
> Why is this useful?

Because it allows one to dedicate a CPU to a process. For example, lets say you
have a quad processor,and want to run joe-random stuff on CPU 0, but a
specialised program on CPUs 1, 2, 3 that does not want to compete with
joe-random stuff.

With sys_setaffinity(), one can set the affinity of the special program to
0xe...but the default affinity for all the joe-random stuff is still 0xf (from
cpu_online_map)! Since its impractical to to modify every single joe-random
executable to set its affinity to 0x1, a way is needed to set the default. The
logical place is in init(), a.k.a. kernel/fork.c.

I hope that make sense.

Thanks, Shaheed


