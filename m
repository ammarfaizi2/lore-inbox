Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbTGLFIM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 01:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbTGLFIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 01:08:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267634AbTGLFIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 01:08:11 -0400
Date: Fri, 11 Jul 2003 22:23:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: Bug in open() function (?)
Message-Id: <20030711222300.7627a811.akpm@osdl.org>
In-Reply-To: <200307120511.h6C5BCSe017963@turing-police.cc.vt.edu>
References: <20030712011716.GB4694@bouh.unh.edu>
	<16143.25800.785348.314274@cargo.ozlabs.ibm.com>
	<20030712024216.GA399@bouh.unh.edu>
	<200307112309.08542.jcwren@jcwren.com>
	<20030711203809.3c320823.akpm@osdl.org>
	<200307120511.h6C5BCSe017963@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Fri, 11 Jul 2003 20:38:09 PDT, Andrew Morton said:
> > "J.C. Wren" <jcwren@jcwren.com> wrote:
> > >
> > > I was playing around today and found that if an existing file is opened wit
> h 
> > >  O_TRUNC | O_RDONLY, the existing file is truncated.
> > 
> > Well that's fairly idiotic, isn't it?
> 
> Not idiotic at all

Sigh.  I meant the kernel behaviour is idiotic.  Returning -EINVAL would
have been much better behaviour.

> 
> > The Open Group go on to say "The result of using O_TRUNC with O_RDONLY is
> > undefined" which is also rather silly.
> > 
> > I'd be inclined to leave it as-is, really.
> 
> I hate to think how many programmers are relying on the *documented* behavior to
> prevent data loss during debugging/test runs....

We've lived with it for this long.

The behaviour is "undefined".  Any application which uses O_RDONLY|O_TRUNC
is buggy.

If we were to alter the behaviour now, any buggy-but-happens-to-work app
which is accidentally using O_RDONLY|O_TRUNC may break.  And now is not the
time to break things.

Given that the behaviour is undefined, the behaviour which we should
implement is clearly "whatever 2.4 is doing".  So let's leave it alone.
