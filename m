Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWIYC6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWIYC6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 22:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWIYC6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 22:58:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751832AbWIYC6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 22:58:48 -0400
Date: Sun, 24 Sep 2006 19:55:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, junkio@cox.net
Subject: Re: git diff <-> diffstat
In-Reply-To: <20060925022208.GF4547@stusta.de>
Message-ID: <Pine.LNX.4.64.0609241949370.3952@g5.osdl.org>
References: <20060924161809.GA13423@havoc.gtf.org> <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
 <45172297.6070108@garzik.org> <Pine.LNX.4.64.0609241732580.3952@g5.osdl.org>
 <20060925011436.GC4547@stusta.de> <Pine.LNX.4.64.0609241858380.3952@g5.osdl.org>
 <20060925022208.GF4547@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Sep 2006, Adrian Bunk wrote:
> 
> Ah, OK. The truncates are something I wasn't used from diffstat 
> (diffstat always prints the complete name).

Yeah, I don't know what the right solution is.

Especially with renames (but even without), diffstat-like output can get 
some _really_ long lines, and since I think it's important to get the 
actual _stat_ part to line up (so that you can really see where the big 
changes are), I felt it was more important to get that lining up than it 
was to see the first part of the filename.

But yeah, we should probably have a flag to allow longer (and shorter) 
lines, and another to control whether we truncate to strictly honor that 
flag or not.

That said, I think the current behaviour is likely at least the right 
default one. It's quite readable once you get used to it, and the renames 
do _not_ get truncated in the "summary" part at the end, since then there 
is nothing to line up with.

So for an example of this, just do

	git show --summary --stat -M 06a36db1

where you have an already fairly long pathname that is then renamed to 
_another_ long pathname.

		Linus
