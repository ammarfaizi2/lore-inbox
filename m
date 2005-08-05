Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVHEWe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVHEWe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVHEWe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:34:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261586AbVHEWe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:34:56 -0400
Date: Fri, 5 Aug 2005 15:33:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Loschwitz <madkiss@madkiss.org>
Cc: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Message-Id: <20050805153344.5fb12313.akpm@osdl.org>
In-Reply-To: <20050805214954.GA25533@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan>
	<Pine.LNX.4.61.0508051538390.6245@chaos.analogic.com>
	<20050805214954.GA25533@minerva.local.lan>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Loschwitz <madkiss@madkiss.org> wrote:
>
> On Fri, Aug 05, 2005 at 03:40:26PM -0400, linux-os (Dick Johnson) wrote:
> > 
> > On Fri, 5 Aug 2005, Martin Loschwitz wrote:
> > 
> > > Hi folks,
> > >
> > > I just ran into the following problem: Having updated my box to 2.6.12.3,
> > > I tried to start YaST2 and noticed a kernel panic (see below). Some quick
> > > debugging brought the result that the kernel crashes while some user (not
> > > even root ...) tries to access /proc/ioports. Is this a known problem and
> > > if so, is a fix available?
> > >
> > > Ooops and ksymoops-output is attached.
> > >
> > 
> > This can happen if a module is unloaded that doesn't free its
> > resources! Been there, done that.
> > 
> 
> "This can happen" is not an acceptable explanation, I think.

It's a very accurate one though.

The most common cause of this bug is that some buggy kernel module has been
unloaded.  It forgot to release its I/O region.  When you later come along
to look in /proc/ioports the kernel goes to fetch information from the
memory which is "owned" by the module which isn't there any more.  Crash.

So if you can identify which kernel module was loaded and then unloaded,
we'll fix it up.

