Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbUB1BN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUB1BN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:13:56 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:34288 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263239AbUB1BNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:13:52 -0500
Subject: Re: [patch] u64 casts
From: Albert Cahalan <albert@users.sf.net>
To: davidm@hpl.hp.com
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <16447.58524.257563.252138@napali.hpl.hp.com>
References: <1077915522.2255.28.camel@cube>
	 <16447.56941.774257.925722@napali.hpl.hp.com>
	 <1077920213.2233.44.camel@cube>
	 <16447.58524.257563.252138@napali.hpl.hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077922424.2232.54.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Feb 2004 17:53:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 19:45, David Mosberger wrote:
> >>>>> On 27 Feb 2004 17:16:53 -0500, Albert Cahalan <albert@users.sourceforge.net> said:
> 
>   Albert> Supposing that this is the case, you may get warnings.
> 
> Well, then do it on your own kernel/system.  I'm not interested in
> spending time on this now, so please don't touch ia64 unless you
> verified that all the other pieces are in place.

Remember, that is only if all of:

1. glibc improperly uses raw kernel headers
2. usage is in such a way that warnings happen
3. you rebuild glibc with these kernel headers

If this is really the case, the warnings may be
eliminated by running a 1-line sed script over
the headers as they are imported into glibc.
It's something like this:  s/__u64/u_int64_t/

In return, you can have type-safety w/o warnings
during the kernel build.

In my example, suppose that foo is a pointer
to u64. You'd like to print the u64. If by
mistake you use the pointer itself, you won't
be getting a warning. The cast hides it.


