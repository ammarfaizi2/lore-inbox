Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSBNBXw>; Wed, 13 Feb 2002 20:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSBNBXl>; Wed, 13 Feb 2002 20:23:41 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:33678 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289299AbSBNBXX>;
	Wed, 13 Feb 2002 20:23:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] sys_sync livelock fix
Date: Thu, 14 Feb 2002 02:27:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Bill Davidsen <davidsen@tmr.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com> <E16bA59-0002Qa-00@starship.berlin> <3C6B0A70.D11DFC2A@zip.com.au>
In-Reply-To: <3C6B0A70.D11DFC2A@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16bAgV-0002R2-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 14, 2002 01:53 am, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > What's the theory behind writing the data both before and after the commit?
> 
> see fsync_dev().  It starts I/O against existing dirty data, then
> does various fs-level syncy things which can produce more dirty
> data - this is where ext3 runs its commit, via brilliant reverse
> engineering of its calling context :-(.

OK, so it sounds like cleaning that up with an ext3-specific super->sync would
be cleaner for what it's worth, and save a little cpu.

> It then again starts I/O against new dirty data then waits on it again.  And
> then again.  There's quite a lot of overkill there.  But that's OK, as long
> as it terminates sometime.

/me doesn't comment

-- 
Daniel
