Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272574AbTHNSDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272579AbTHNSDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:03:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:1697 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272574AbTHNSDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:03:24 -0400
Date: Thu, 14 Aug 2003 11:03:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matt Wilson <msw@redhat.com>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow CLONE_THREAD
 without CLONE_DETACHED
In-Reply-To: <20030814175309.GC10889@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0308141101110.1692-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Aug 2003, Jamie Lokier wrote:
> 
> Don't forget to mention that software that may be run on 2.5 kernels
> needs to set both bits, else won't work as expected.

Well, the CLONE_DETACHED without CLONE_THREAD case was never legal, and my
current patch will actually warn about the newly disallowed case too. I've
not gotten any warnings with RH-9, and I don't think anybody else has a 
new enough glibc to even use CLONE_THREAD at all.

But yes, there will be a warning, at least for a time (and eventually 
we'll just return -EINVAL silently - ie the program will _fail_ the 
clone(), it won't just act strangely).

		Linus

