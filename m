Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTKKDIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264234AbTKKDIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:08:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:61828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264233AbTKKDIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:08:16 -0500
Date: Mon, 10 Nov 2003 19:07:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Andrew Morton <akpm@osdl.org>, Dag Brattli <dag@brattli.net>,
       Jean Tourrilhes <jt@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <irda-users@lists.sourceforge.net>
Subject: Re: [PATCH] irda: fix type of struct irda_ias_set.attribute.irda_attrib_string.len
In-Reply-To: <Pine.LNX.4.44.0311101856130.2881-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311101900120.2881-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Nov 2003, Linus Torvalds wrote:
> 
> No, please don't.

Btw, this is a general thing with warnings that the compiler spits out.

Some compiler warnings are for perfectly ok code.

Sometimes the warning itself is fundamentally broken (the sign warnings 
that gcc used to spit out), sometimes it's because the code is 100% right 
for some abstract reason that the compiler can't figure out.

An example of such an "abstract reason" is exactly something like this 
case, where the user really didn't _care_ too deeply about the type he was 
checking, and was caring a lot more about a totally _independent_ sanity 
check, which just happened to be unrelated to the type size. In this case, 
having the compiler just silently notice that "oh, this can't happen, 
because I know the range in this case" is ok.

And if the code is right, just re-write it in a form that avoids the 
warning. So

	if (a = b) {

should become

	a = b;
	if (a) {

because it's clearer _and_ avoids the warning (don't just blindly add a
parenthesis).

That's why I hate the "sign compare" warning of gcc so much - it warns 
about things that you CANNOT sanely write in any other way. That makes 
that particular warning _evil_, since it encourages people to write crap 
code.

In this case, the warning is easily avoided by splitting the code up a 
bit, and accepting an unnecessary cast (which hopefully the compiler may 
eventually notice it unnecessary). And as the warning in general is good, 
that's fine - the warning does not generally _encourage_ bad programming.

		Linus

