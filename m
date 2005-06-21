Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVFUSG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVFUSG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVFUSG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:06:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262159AbVFUSGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:06:18 -0400
Date: Tue, 21 Jun 2005 11:08:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
In-Reply-To: <42B8542A.9020700@pobox.com>
Message-ID: <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506211304320.2915@skynet>
 <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com>
 <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com>
 <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org> <42B8542A.9020700@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Jeff Garzik wrote:
> 
> If I want my working dir updated to reflect the desired branch -- the 
> whole purpose of git-switch-tree -- I would have to do
> 
> 	git-checkout-script && switch HEAD && git-checkout-script

No, you don't understand. The git-checkout-script already takes a 
parameter to indicate _what_ to check out. It just defaults to head.

So you'd do

	git-checkout-script branch && switch branch

and you'd be done.

Anyway, I liked the branch semantics for "git checkout" so much that I 
just made it do that by default. In other words, if you do

	git checkout 'branch'

it will both check out the new branch contents and switch HEAD to branch. 
It will refuse to overwrite any data, but as before, you can force that 
with "git checkout -f branch" instead.

If the argument to "git checkout" isn't a branch-name, but some other 
name (like "v2.6.12" or an extended expression like "HEAD^" for "parent of 
HEAD"), it will just check it out, but it obviously won't be switching any 
branches around (and it will leave HEAD untouched).

These seem like sane and useful semantics, and your "switch" script should 
really fall out as "git checkout -f".

		Linus
