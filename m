Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSGQQIG>; Wed, 17 Jul 2002 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGQQIG>; Wed, 17 Jul 2002 12:08:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19729 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315277AbSGQQIF>;
	Wed, 17 Jul 2002 12:08:05 -0400
Message-ID: <3D3598F0.FBBA9DB6@zip.com.au>
Date: Wed, 17 Jul 2002 09:18:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/13] lseek speedup
References: <3D35012B.EE9B1ABB@zip.com.au> <5.1.0.14.2.20020717103038.00a8c7a0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> At 06:31 17/07/02, Andrew Morton wrote:
> >This is a fairly dopey patch to fix up the i_sem contention in lseek.
> >Better ideas are welcome, but I'm offline until Monday so don't think
> >I'm ignoring them...
> 
> I am afraid I don't have any better ideas but I don't think your patch is
> safe. )-:

It wasn't a very good idea in the first place.  Forgot to take
the new lock over in the updaters of f_pos.

And it's attempting to cater for a buggy application on a 32-bit
machine, SMP, where the fd is shared.  It's hard to justify
putting any locking in lseek for that.  (Then again, people
should use pread() more..)

Except for readdir().  Now, why are we taking i_sem for lseek/readdir
exclusion and not a per-file lock?

-
