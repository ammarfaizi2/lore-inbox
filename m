Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUAFXXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbUAFXXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:23:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:35744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265967AbUAFXXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:23:50 -0500
Date: Tue, 6 Jan 2004 15:23:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Richard Henderson <rth@redhat.com>
cc: David Mosberger-Tang <David.Mosberger@acm.org>, davidm@mostang.com,
       linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
In-Reply-To: <20040106223302.GB18646@redhat.com>
Message-ID: <Pine.LNX.4.58.0401061515370.9166@home.osdl.org>
References: <16PqK-8eK-1@gated-at.bofh.it> <16RiU-2kO-1@gated-at.bofh.it>
 <16S5h-3no-5@gated-at.bofh.it> <ug3casyegk.fsf@panda.mostang.com>
 <20040106223302.GB18646@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Richard Henderson wrote:
> 
> In ANSI C you've no alternative except memcpy, since you can't cast
> the pointer and reference the object via some other type (assuming
> neither type is char, yadda yadda).

Sure you have. You can _always_ change

	(a ? b : c) = d;

to

	tmp = d;
	a ? (b = tmp) : (c = tmp);

which is not pretty, but with some macro abuse it won't be horrible. In 
fact, once you do that, you might as well just do a real "if" statement. 

Especially if you're going to continue to use (less odious) gcc-specific
stuff you can probably automate it fairly well with a replacement that
uses "typeof" and expresstion statements to do that "tmp" variable
properly.

Ie it might be _slightly_ more complex than running a "sed" script over
the sources, but it shouldn't be that much worse.

		Linus
