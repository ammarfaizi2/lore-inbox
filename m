Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291676AbSBHRye>; Fri, 8 Feb 2002 12:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291678AbSBHRyY>; Fri, 8 Feb 2002 12:54:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5339 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291676AbSBHRyJ>;
	Fri, 8 Feb 2002 12:54:09 -0500
Date: Fri, 8 Feb 2002 12:54:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for duplicate /proc entries
In-Reply-To: <20020208174730.GA343@mis-mike-wstn>
Message-ID: <Pine.GSO.4.21.0202081251450.28514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Mike Fedyk wrote:

> On Fri, Feb 08, 2002 at 10:13:26AM -0600, Brent Cook wrote:
> > Maybe, someday there will be some sort of DEBUG flag to set in the kernel,
> > from which a slew of asserts and printk's will spring to life, pointing
> > out inconsistencies and bad assumptions. That is where this check would
> > probably work the best.
> > 
> 
> Actually, there are seperate debug config options for different subsystems,
> and I think that is good.  The real problem is finding a way to add another
> debug config option for procfs without littering the code with ifdefs...

	No point.  Check that file already exist and BUG() if it does.
Unconditionally.  There's no need to be nice to broken code and yes,
any code that tries to register existing procfs entry _is_ broken.
That was never supposed to work.

