Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWFXLD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWFXLD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 07:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWFXLD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 07:03:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36049 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750725AbWFXLD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 07:03:26 -0400
Subject: Re: i386 ABI and the stack
From: Arjan van de Ven <arjan@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org, 76306.1226@compuserve.com, ak@muc.de,
       akpm@osdl.org
In-Reply-To: <787b0d920606231943x7aad43bwb108b6a88b678b1a@mail.gmail.com>
References: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>
	 <Pine.LNX.4.64.0606231844460.6483@g5.osdl.org> <449C9C6D.7050905@zytor.com>
	 <Pine.LNX.4.64.0606231907290.6483@g5.osdl.org>
	 <787b0d920606231943x7aad43bwb108b6a88b678b1a@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 13:03:18 +0200
Message-Id: <1151146998.3181.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 22:43 -0400, Albert Cahalan wrote:
> On 6/23/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > On Fri, 23 Jun 2006, H. Peter Anvin wrote:
> > > >
> > > > The x86-64 ABI has a 128-byte(*) zone that is safe from signals etc, so you
> > > > can use a small amount of stack below the stackpointer safely. Not so on
> > > > x86.
> > >
> > > Adding a small redzone like this to i386 would be easy, though -- just drop
> > > the stack pointer by that much when creating a signal frame.  128 bytes isn't
> > > enough to interfere with libraries.
> >
> > However, any binaries created with that in mind would be
> > buggy-by-definition on older kernels, so I don't think it's worth it.
> 
> Since gcc-2.96 would access 256 bytes below the stack pointer
> (according to the valgrind man page), the kernel needs to allow
> for this in signal handlers anyway.

only a handful buggy editions of that compiler did in a few corner
cases. And they were really buggy, and they were corner cases. Nobody
should be using a compiler like that; and nobody is expected to compile
software with a broken version of that compiler (iirc the window in
which it was broken was really small). There is a limit to userspace
brokenness that the kernel should work around. This imo is on the other
side of the line.

