Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVFURIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVFURIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVFURGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:06:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262188AbVFUREX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:04:23 -0400
Date: Tue, 21 Jun 2005 10:06:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
In-Reply-To: <42B838BC.8090601@pobox.com>
Message-ID: <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506211304320.2915@skynet>
 <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Jeff Garzik wrote:
> 
> Slight tangent...  it would be nice if you would write a 2-line 
> git-checkout-script, which provides the modern version of
> 
> 	git-read-tree -m HEAD && git-checkout-cache -q -f -u -a
> 
> Note that I do depend on this command blowing away working dir changes, 
> but maybe you would want that to be a separate arg.

Added. Feel free to try it out, but it's very lightly tested.

You can do just "git checkout" and it will checkout the current HEAD, but 
won't overwrite anything old. Use the "-f" flag to force overwrite. 

It can also take a new HEAD, ie you can check out the parent of the 
current HEAD by doing

	git checkout HEAD^


and if you actually want to set the HEAD to that parent you can do so with 
the "-u" flag, so

	git checkout -u HEAD^

is basically equivalent to "undo the topmost commit".

It's not quite your "switch", though, because it will always _write_ to
the current HEAD, it won't be switching the current HEAD around to another
branch. I almost think that behavkiour would be more useful, I'll think
about how to do it sanely.

		Linus
