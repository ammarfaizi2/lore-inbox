Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbTDRRrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTDRRrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:47:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55564 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263184AbTDRRrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:47:41 -0400
Date: Fri, 18 Apr 2003 11:00:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Rusty Trivial Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] kstrdup
In-Reply-To: <3EA02E55.80103@pobox.com>
Message-ID: <Pine.LNX.4.44.0304181055290.2950-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Apr 2003, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > On Fri, 18 Apr 2003, Jeff Garzik wrote:
> > 
> >>You should save the strlen result to a temp var, and then s/strcpy/memcpy/
> > 
> > No, you should just not do this. I don't see the point.
> 
> strcpy has a test for each byte of its contents, and memcpy doesn't.
> Why search 's' for NULL twice?

No, my point is that kstrdup() _itself_ just shouldn't be done. I don't
see it as being worthy of kernel support. Most of the kernel string data
structures are NOT random zero-ended strings anyway: they are either
strictly limited in some ways ("ends in '\0', but limited to PATH_MAX), or
they are explicitly sized ("struct qstr").

I don't much personally like C strings. Explicit lengths tend to have a
lot of advantages, and while a lot of the standard C infrastructure is for 
zero-ended strings, they do end up being even worse in the kernel than in 
user space (think buffer overflows and limited allocations in general).

			Linus

