Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262431AbSJESWM>; Sat, 5 Oct 2002 14:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSJESWM>; Sat, 5 Oct 2002 14:22:12 -0400
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:30191 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S262431AbSJESWK>;
	Sat, 5 Oct 2002 14:22:10 -0400
Date: Sat, 5 Oct 2002 20:27:40 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021005182740.GC16200@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033841462.1247.3716.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 02:11:02PM -0400, Robert Love wrote:
> On Sat, 2002-10-05 at 05:07, Thomas Lang?s wrote:
> 
> > We have a fairly large installation on-campus, and we have some problems
> > with the current linux-kernel (and older ones) - namely that processes
> > entering D-state will stay there forever (given that the right event got
> > them there in the first place).  This right event is killing the 
> > autofs-daemon.  Doing this will result in heavy load because of lots
> > of D-state processes, and you can't kill any of the D-state processes.
> > Why shouldn't one be able to kill processes that has entered D-state?
> > We have to reboot our servers to get rid of this problem, and it's
> > rather annoying.
> 
> Because they are in uninterruptible sleep.  They are doing something
> important, presumably in a critical section, and have no wake-up path
> for signals or errors.
> 
> Finally, they probably hold a semaphore.  In short, you cannot kill
> them, nor would you want to.
> 
> I would simplify the question and ask why are you killing the autofs
> daemon?  Clearly this is a recipe for disaster.

On the other hand it's a bug if a process stays in D-state for time of
order of seconds or more. Unfortunately it's impossible to avoid this
in networking filesystems with current state of VFS (in 2.4). Even there
though, it's a bug if it's indefinite.

These problems were already discussed on LKML, you might want to search
the archive. IIRC this is a known problem of OpenAFS (not in standart
kernel). It was reported with various drivers for some 2.4.x kernels
too.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
