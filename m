Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSGHMam>; Mon, 8 Jul 2002 08:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSGHMal>; Mon, 8 Jul 2002 08:30:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316880AbSGHMak>;
	Mon, 8 Jul 2002 08:30:40 -0400
Date: Mon, 8 Jul 2002 13:33:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Dave Hansen <haveblue@us.ibm.com>, Matthew Wilcox <willy@debian.org>,
       Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020708133321.S27706@parcelfarce.linux.theplanet.co.uk>
References: <3D28FE72.1080603@us.ibm.com> <Pine.GSO.4.21.0207072258350.24900-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0207072258350.24900-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Jul 07, 2002 at 11:06:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 11:06:32PM -0400, Alexander Viro wrote:
> The thing being, if you are already contended you are playing "I'll release
> CPU now" vs. "I'll spin in hope that contender will go away right now".
> 
> IOW, it's a win only if you get contention often and for short intervals.
> Which is a very good indication that something is rotten with your locking
> scheme.  Like, say it, having lost the control over the amount of locks
> as the result of brainde^Woverenthusiastic belief that fine-grained ==
> good.  With everything that follows from that...

So let's get some numbers.  It really shouldn't be hard to make our
current semaphores spin a little before they sleep.  If we get some
numbers showing it does help then either we need this change in mainline
or we need to fix our locking.

-- 
Revolutions do not require corporate support.
