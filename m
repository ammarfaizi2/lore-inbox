Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbUKWXEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUKWXEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUKWXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:03:36 -0500
Received: from mail.dif.dk ([193.138.115.101]:47069 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261517AbUKWXA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:00:27 -0500
Date: Wed, 24 Nov 2004 00:09:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
In-Reply-To: <41A38BF1.9060207@ammasso.com>
Message-ID: <Pine.LNX.4.61.0411240003300.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
 <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
 <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org> <41A38BF1.9060207@ammasso.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Timur Tabi wrote:

> Linus Torvalds wrote:
> 
> > which might warn on an architecture where "pid_t" is just sixteen bits wide.
> > Does that make the code wrong? Hell no.
> 
> Wouldn't something like "sizeof(pid_t) > 2" be a better test?  It certainly
> would be a lot easier to understand than comparing with 0xffff.
> 
That was not the point of the example Linus gave.
The example Linus gave was a function taking a pid_t argument and then 
comparing the value of the argument passed against 0xffff - the /value/ of 
the pid_t argument passed, not the size of the datatype.

        int fn(pid_t a)
        {
                if (a > 0xffff)
                        ...
        }

if pid_t is 16 bit, then the value can never be greater than 0xffff but, 
if pid_t is greater than 16 bit, say 32 bit, then the argument "a" could 
very well contain a value greater than 0xffff and then the comparison 
makes perfect sense. So, while you'd get a warning on architectures where 
pid_t is 16bit or less you won't get a warning when pid_t is greater than 
16 bit. "fixing" that warning would clearly be wrong, no argument about 
that.


--
Jesper Juhl

