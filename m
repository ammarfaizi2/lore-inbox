Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVJaA61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVJaA61 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVJaA61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:58:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932390AbVJaA60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:58:26 -0500
Date: Sun, 30 Oct 2005 16:58:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rob Landley <rob@landley.net>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <200510301731.47825.rob@landley.net>
Message-ID: <Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org> <200510300644.20225.rob@landley.net>
 <Pine.LNX.4.64.0510301435520.27915@g5.osdl.org> <200510301731.47825.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Oct 2005, Rob Landley wrote:
> 
> I know there isn't an absolute or stable ordering, but can't a temporary 
> ordering be exported?

Not generally, no. And definitely not easily.

> I was under the impression that the bk->cvs gateway squashed changes into a 
> sort of order, way back when.

I have to say that the bk->cvs gateway is actually a very impressive 
linearization, and I don't even know how it did it. But even that one 
wasn't perfect - occasionally it ended up with big patches for merges.

Using "git bisect" to generate successive bisections (and then building up 
a linearization patch from that) would work, but it would result in some 
_really_ strange things: it would basically have one patch do one thing, 
then the next patch might _undo_ that, and do another, and then the third 
patch would re-do it and do them both together.

And that's really sometimes the best linearization you can do. But that's 
just too strange and confusing, I think. And the patches would be horribly 
inefficient.

At that point I'd rather teach people to use "git bisect" natively. It 
wouldn't be any less confusing than the patches ;)

		Linus
