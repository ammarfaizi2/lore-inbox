Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSI3P14>; Mon, 30 Sep 2002 11:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261811AbSI3P14>; Mon, 30 Sep 2002 11:27:56 -0400
Received: from dsl-213-023-038-108.arcor-ip.net ([213.23.38.108]:27538 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261666AbSI3P1z>;
	Mon, 30 Sep 2002 11:27:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] In-kernel module loader 1/7
Date: Mon, 30 Sep 2002 17:32:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20020919125906.21DEA2C22A@lists.samba.org> <1032461895.27865.54.camel@irongate.swansea.linux.org.uk> <20020919201140.GB17131@kroah.com>
In-Reply-To: <20020919201140.GB17131@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17w2XF-0005oW-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 September 2002 22:11, Greg KH wrote:
> On Thu, Sep 19, 2002 at 07:58:15PM +0100, Alan Cox wrote:
> > On Thu, 2002-09-19 at 19:38, Greg KH wrote:
> > > And with a LSM module, how can it answer that?  There's no way, unless
> > > we count every time someone calls into our module.  And if you do that,
> > > no one will even want to use your module, given the number of hooks, and
> > > the paths those hooks are on (the speed hit would be horrible.)
> > 
> > So the LSM module always says no. Don't make other modules suffer
> 
> Ok, I don't have a problem with that, I was just trying to point out
> that not all modules can know when they are able to be unloaded, as
> Roman stated.

Not being able to unload LSM would suck enormously.  At last count, we
knew how to do this:

  1) Unhook the function hooks (using a call table simplifies this)
  2) Schedule on each CPU to ensure all tasks are out of the module
  3) A schedule where the module count is incremented doesn't count

and we rely on the rule that and module code that could sleep must be
bracketed by inc/dec of the module count.

Did somebody come up with a reason why this will not work?

-- 
Daniel
