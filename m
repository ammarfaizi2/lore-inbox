Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVKJVSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVKJVSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVKJVSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:18:40 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:47370 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932086AbVKJVSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:18:39 -0500
Date: Thu, 10 Nov 2005 22:02:55 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Staubach <staubach@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] poll(2) timeout values
Message-ID: <20051110210255.GF11266@alpha.home.local>
References: <437375DE.1070603@redhat.com> <1131642956.20099.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131642956.20099.39.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 05:15:56PM +0000, Alan Cox wrote:
> On Iau, 2005-11-10 at 11:31 -0500, Peter Staubach wrote:
> > Clearly, the timeout calculations problem can be fixed without changing
> > the arguments to the sys_poll() routine.  However, it is cleaner to fix
> > it this way by ensuring the sizes and types of arguments match.
> 
> There really is no need for the kernel API to match the userspace one,
> many of our others differ between the syscall interface which is most
> definitely 'exported' in one sense and the POSIX interface which is
> defined by libc, posix and the LSB etc
> 
> No argument about the timeout fix.

I posted a different fix here about a month ago (but I sent it 3 times,
as it was twice wrong). Andrew was about to merge it in his tree but I
have not checked yet. It was different in the sense that it used
msecs_to_jiffies() to do the arithmetic in the best possible way depending
on the HZ value and the ints size. Most of the time (when 1000 % HZ == 0),
it will simplify the operations to a single divide by a constant and
correctly check for integer overflows. Eg, with HZ=250, a simple 2 bits
right shift will replace a multiply followed by an divide.

I'll check whether 2.6.14-mm1 has it, otherwise I can repost it.

Cheers,
Willy

