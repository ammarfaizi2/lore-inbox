Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUAEVfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUAEVfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:35:09 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:2750 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265919AbUAEVfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:35:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 5 Jan 2004 13:34:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: John Gardiner Myers <jgmyers@speakeasy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch/revised] wake_up_info() ...
In-Reply-To: <Pine.LNX.4.58.0401051239110.2153@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0401051332060.17134-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Linus Torvalds wrote:

> 
> 
> On Mon, 5 Jan 2004, John Gardiner Myers wrote:
> >
> > It would seem better if info were a void *, to permit sending more than 
> > a single unsigned long.
> 
> The argument against that is that since there is basically no 
> synchronization here, you can't pass a pointer to some random object. So 
> by default, you should think of the cookie as "pass-by-value", ie not a 
> pointer. That way there are no liveness issues: there is no issue about 
> what happens to the data when the recipient is actually scheduled 
> (possibly _much_ much after the actual wakeup).

An argoument in favour of the "void *" would be that there might be 
situations were a little structure needs to be passed, that will be copied 
by the target of the wakeup (callback) in its own data structure. But as 
you said, we already do "unsigned long" -> "pointer" conversions inside 
the kernel, so it does not really matter. Let's stick with the unsigned 
long version then.



- Davide


