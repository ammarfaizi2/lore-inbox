Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSJDAFt>; Thu, 3 Oct 2002 20:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSJDAFt>; Thu, 3 Oct 2002 20:05:49 -0400
Received: from dsl-213-023-021-061.arcor-ip.net ([213.23.21.61]:48524 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261398AbSJDAFs>;
	Thu, 3 Oct 2002 20:05:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rob Landley <landley@trommello.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] In-kernel module loader 1/7
Date: Fri, 4 Oct 2002 02:10:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20020919125906.21DEA2C22A@lists.samba.org> <E17w2XF-0005oW-00@starship> <20021003235152.B41E3397@merlin.webofficenow.com>
In-Reply-To: <20021003235152.B41E3397@merlin.webofficenow.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17xG33-0001ji-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 20:53, Rob Landley wrote:
> On Monday 30 September 2002 11:32 am, Daniel Phillips wrote:
> 
> > Not being able to unload LSM would suck enormously.  At last count, we
> > knew how to do this:
> >
> >   1) Unhook the function hooks (using a call table simplifies this)
> >   2) Schedule on each CPU to ensure all tasks are out of the module
> >   3) A schedule where the module count is incremented doesn't count
> >
> > and we rely on the rule that and module code that could sleep must be
> > bracketed by inc/dec of the module count.
> >
> > Did somebody come up with a reason why this will not work?
> 
> Preemption?

Turn it off.

> Scheduling doesn't guarantee making any specific amount of progress within 
> the kernel with preemption enabled.  I thought the preferred strategy was to 
> wait for the time slices to refill and then exhaust (since everybody has to 
> exhaust their time slices before anybody gets new ones.  Unless I've missed 
> something...?)

Probably ;-)

-- 
Daniel
