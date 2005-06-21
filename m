Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVFURnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVFURnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVFURnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:43:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262143AbVFURnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:43:42 -0400
Date: Tue, 21 Jun 2005 10:42:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
In-Reply-To: <42B84E20.7010100@pobox.com>
Message-ID: <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506211304320.2915@skynet>
 <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com>
 <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Jeff Garzik wrote:
> 
> The reason I requested git-checkout-script is to make git-switch-tree 
> pretty much trivial.  The new git-switch-tree will sit on top of 
> git-checkout-script, like
> 
> 	if $1
> 		switch HEAD to refs/heads/$1
> 	git-checkout-script

Actually, I'd suggest doing the git-checkout-script _first_. That way you 
_can_ use the careful version, which refuses to switch if it would cause 
information to be lost. Ie something like

	git-checkout-script $1 && switch HEAD to refs/heads/$1

should do it.

(And then you can choose to use the "-f" flag or not to
git-checkout-script depending on whether you want to force it).

Anyway, I think the branch switching behaviour is useful enough that I 
should make git-checkout-script understand the notion of switching to a 
new branch natively.

		Linus
