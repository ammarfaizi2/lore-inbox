Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTESBw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 21:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbTESBw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 21:52:29 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:9664 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262299AbTESBw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 21:52:28 -0400
Date: Sun, 18 May 2003 22:05:17 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030519020517.GA25691@arizona.localdomain>
References: <20030518163537.GZ8978@holomorphy.com> <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [129.44.45.170] at Sun, 18 May 2003 21:05:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 07:24:17PM +0200, Peter T. Breuer wrote:
> Though I've got quite good at finding and removing deadlocks in my old
> age, there are still two popular ways that the rest of the world's
> prgrammers often shoot themselves in the foot with a spinlock:
> 
>    a) sleeping while holding the spinlock
>    b) taking the spinlock in a subroutine while you already have it
[...]
> The second method is used by programmers who aren't aware that some
> obscure subroutine takes a spinlock, and who recklessly take a lock
> before calling a subroutine (the very thought sends shivers down my
> spine ...).

Recursive spinlocks only hide the problem - consider programmers who take
lock B and recklessly call a subroutine that takes lock A followed be lock
B.  The resulting code will appear to work fine, but may have introduced a
subtle AB-BA deadlock.  I'd rather have a coding defect that reliably and
consistently causes a deadlock than one that causes deadlocks in rare
timing related cases.

>A popular scenario involves not /knowing/ that your routine
> is called by the kernel with some obscure lock already held, and then
> calling a subroutine that calls the same obscure lock.

If the kernel invokes a callback with an obscure lock held (that is
promiscuous enough to be grabbed in other helper sub-routines), then its
probably a bug - why not just fix it?

-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
