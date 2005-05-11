Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVEKQXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVEKQXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEKQXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:23:10 -0400
Received: from solarneutrino.net ([66.199.224.43]:51464 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S261993AbVEKQV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:21:59 -0400
Date: Wed, 11 May 2005 12:21:59 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: DRI lockup on R200, 2.6.11.7
Message-ID: <20050511162159.GA19046@tau.solarneutrino.net>
References: <20050426202916.GA2635@xarello> <21d7e99705042801227ed5438e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d7e99705042801227ed5438e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:22:36AM +0100, Dave Airlie wrote:
> On 4/26/05, foo@porto.bmb.uga.edu <foo@porto.bmb.uga.edu> wrote:
> > Using 2.6.11.7, I'm experiencing the same problem as reported here:
> > http://lkml.org/lkml/2005/3/12/99
> > 
> > Except it happens for me after X is running.  X locks up, only the mouse
> > pointer moves, X spins doing this:
> > 
> > --- SIGALRM (Alarm clock) @ 0 (0) ---
> > rt_sigreturn(0xe)                       = -1 EBUSY (Device or resource busy)
> > ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)
> > ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)

Another one today, but it's a little different now.  I got to see this
happen from the beginning today.  A few minutes before the crash, 3D
operations become very slow.  When X hangs, it's now doing this:

--- SIGALRM (Alarm clock) @ 0 (0) ---
rt_sigreturn(0xe)                       = -1 EBUSY (Device or resource busy)
ioctl(5, 0xc0406429, 0x7ffffffff490)    = -1 EBUSY (Device or resource busy)
ioctl(5, 0xc0406429, 0x7ffffffff490)    = -1 EBUSY (Device or resource busy)

It seems to only happen when there are two or more opengl programs
running.  I killed X again, but the machine was still very slow.
Investigating, I found the two GL processes still running, both eating
lots of cycles.  Before I could find out what they were doing, xdm
restarted X, which caused a machine reset.  I know this because I was
(confusedly) stracing the new X as it was coming up.  X was stat(2)ing
the video driver modules right before the reset...

-ryan
