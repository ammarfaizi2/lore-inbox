Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbTGKUVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbTGKUT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:19:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19986 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S266620AbTGKUTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:19:09 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Style question: Should one check for NULL pointers?
Date: 11 Jul 2003 13:33:18 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ben6ue$mj9$1@cesium.transmeta.com>
References: <Pine.LNX.4.44L0.0307102233230.12370-100000@netrider.rowland.org> <3F0EC9C9.4090307@inet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F0EC9C9.4090307@inet.com>
By author:    Eli Carter <eli.carter@inet.com>
In newsgroup: linux.dev.kernel
> > 
> > Not really needed, since a segfault will produce almost as much 
> > information as a BUG_ON().  Certainly it will produce enough to let a 
> > developer know that the pointer was NULL.
> 
> Your first message said, "I see no reason for pure paranoia, 
> particularly if it's not commented as such."  A BUG_ON() call makes it 
> clear that the condition should never happen.  Dereferencing a NULL 
> leaves the question of whether NULL is an unhandled case or invalid 
> input.  BUG_ON() is an explicit paranoia check, and with a bit of 
> preprocessing magic, you could compile out all of those checks.
> 
> So it documents invalid input conditions, allows you to eliminate the 
> checks in the name of speed or your personal preference, or use them to 
> help with debugging/testing.
> 

... but it also bloats the code, in this case, in many ways
needlessly.  You don't want to compile out all BUG_ON()'s, just the
ones that wouldn't be checked for anyway.

In fact, have a macro that explicitly tests for nullness by
dereferencing a pointer might be a good idea; on most architectures it
will be a lot cheaper than BUG_ON() (which usually requires an
explicit test), and the compiler at least has a prayer at optimizing
it out.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
