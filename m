Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268908AbRG0RvJ>; Fri, 27 Jul 2001 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268912AbRG0Ru7>; Fri, 27 Jul 2001 13:50:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40202 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268908AbRG0Ruq>; Fri, 27 Jul 2001 13:50:46 -0400
Subject: Re: ext3-2.4-0.9.4
To: leg+@andrew.cmu.edu (Lawrence Greenfield)
Date: Fri, 27 Jul 2001 18:52:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Lawrence Greenfield" at Jul 27, 2001 01:41:40 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QBmR-00069y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> These are tangential issues.  Not everybody uses IDE disks.  I'm not
> asking for things that are impossible.  Just because sometimes the

Actually if I remember rightly the problem is mathematically insoluble

> The application can avoid the wrong file problem by zeroing out data
> before releasing it to the OS to reallocate.

When you zero out the data what order do you want those writes in relative
to the rename

> An async fsync allows me to issue multiple fsyncs and then wait for
> all of them to complete, hopefully in the same framework that I would
> do async I/O (but that's an argument for another day).

Ok.. right that makes more sense. So you actually want 'begin_fsync' and
'wait_fsync_all' type stuff

>    Doing reliabile transactions on disk is a hard problem. That is why oracle
>    and friends have spent many man years of research on this kind of problem. 
>    Current unix mailers do the smoke mirrors and prayer bit to reduce the
>    probability a little that is all, regardless of fs and os.
> 
> Isn't the point of the operating system to try to make it as easy as
> possible to do these things correctly?

The OS doesnt have enough information. To do transactions you must know the
entire material that corresponds to the transaction and bound it. That isnt
something the kernel has the knowledge about.

The job of the OS is to make the simple things easy, and the hard possible.
Not to burden the simple with the cost of the hard. That why the chattr +S
is such a nice solution in many ways

Alan
