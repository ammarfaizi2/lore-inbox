Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318105AbSHDGLZ>; Sun, 4 Aug 2002 02:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318107AbSHDGLZ>; Sun, 4 Aug 2002 02:11:25 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:24583 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318105AbSHDGLZ>; Sun, 4 Aug 2002 02:11:25 -0400
Date: Sun, 4 Aug 2002 08:14:55 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: large file IO starving ls -l
In-Reply-To: <aihmso$2m2$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208040811140.31781-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002, Linus Torvalds wrote:

> In article <Pine.LNX.4.44.0208032253260.23040-100000@pc40.e18.physik.tu-muenchen.de>,
> Roland Kuhn  <rkuhn@e18.physik.tu-muenchen.de> wrote:
> >
> >Now the question is: who keeps ls from returning? The command never hits 
> >the disk (reads in above histogram do not increase), but stays for many 
> >seconds (up to one minute) in state D.
> 
> ext2 used to have similar issues with the superblock lock - where things
> like block allocation (very much in the write path) would grab the
> superblock lock, and completely destroy interactive feel even for
> processes that didn't need to do IO, because the superblock lock was
> often grabbed even if the data was actually cached (sb locking needed
> just to _look_up_ the physical block so that you could look up the
> cached data in the buffer cache). 
> 
> Al Viro largely fixed in for ext2, which now uses lock_super() a lot
> less. But a lot of filesystems are based on the old ext2 locking, and
> may have inherited some of the worst parts..
> 
Thanks for the hint, I will try to have a look at the reiserfs code. Could 
you give me a hint where this lock usually is taken?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

