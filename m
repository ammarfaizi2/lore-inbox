Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSHPOik>; Fri, 16 Aug 2002 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318426AbSHPOik>; Fri, 16 Aug 2002 10:38:40 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:16626 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318407AbSHPOij>; Fri, 16 Aug 2002 10:38:39 -0400
Date: Fri, 16 Aug 2002 10:42:26 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Dan Kegel <dank@kegel.com>, suparna@in.ibm.com,
       Andrea Arcangeli <andrea@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816104226.A19785@redhat.com>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com> <3D5D0186.7B7724BC@kegel.com> <20020816152133.B590@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020816152133.B590@kushida.apsleyroad.org>; from lk@tantalophile.demon.co.uk on Fri, Aug 16, 2002 at 03:21:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 03:21:33PM +0100, Jamie Lokier wrote:
> Dan Kegel wrote:
> > You can actually consider posix AIO using sigtimedwait() to pick up
> > completion notices to fit the definition of completion port if you
> > squint a bit.
> 
> ... with the bonus that it fits comfortably into a sigtimedwait() loop
> that's waiting for non-AIO things too.

The idea was to make completion events as light weight as possible -- they 
can be read from the queue without even entering kernel space.  Support for 
getting multiple completion events is also needed (sigtimed wait only pulls 
one signal at a time).  Nothing is stopping us from adding support to do 
an async sigtimedwait that provides a completion event when a signal arrives.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
