Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277652AbRJKAa5>; Wed, 10 Oct 2001 20:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277705AbRJKAaj>; Wed, 10 Oct 2001 20:30:39 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33784
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277652AbRJKAaW>; Wed, 10 Oct 2001 20:30:22 -0400
Date: Wed, 10 Oct 2001 17:30:47 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: safemode <safemode@speakeasy.net>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010173047.B3795@mikef-linux.matchmail.com>
Mail-Followup-To: safemode <safemode@speakeasy.net>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
	Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
	Robert Love <rml@tech9.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au> <20011010120009.851921E7C9@Cantor.suse.de> <20011010153653.Q726@athlon.random> <20011010234211Z277533-761+17907@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010234211Z277533-761+17907@vger.kernel.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 07:42:31PM -0400, safemode wrote:
> On Wednesday 10 October 2001 09:36, Andrea Arcangeli wrote:
> > On Wed, Oct 10, 2001 at 08:00:04AM -0400, safemode wrote:
> > > OK, i copied the mp3 into /dev/shm and without any renicing of anything
> > > it plays fine during dbench 32.  so the problem is disk access taking too
> > > long.
> > >
> > > Which is strange since i'm running dbench on a separate hdd on a totally
> > > different controller.
> >
> > then if you know it's not disk congestion, it's most probably due the vm
> > write throttling.
> >
> > Andrea
> 
> How is it that a process at the same priority as allowed to throttle the 
> kernel's vm and starve other processes at the same priority.  That sounds 
> like dbench is being allowed to preempt other processes at the same priority. 
>  even if it is indirect preemption. The effect is the same. 

The problem is that the disk subsystem doesn't take into account the
priority of the process initiating the heavy (or any for that matter) IO.

AFAICT, the only way to get fair disk access is to modify (shorten) the
elevator queue lengths (which IMHO are much too long).  Check out elvtune
(I'm testing "-r 500 -w 750" right now) in the util-linux package.

Mike
