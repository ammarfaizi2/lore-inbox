Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290772AbSBFUJb>; Wed, 6 Feb 2002 15:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290782AbSBFUJU>; Wed, 6 Feb 2002 15:09:20 -0500
Received: from unthought.net ([212.97.129.24]:56473 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S290772AbSBFUJO>;
	Wed, 6 Feb 2002 15:09:14 -0500
Date: Wed, 6 Feb 2002 21:09:12 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Dave Francheski <davef@seven-systems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gprof / profiling support ?
Message-ID: <20020206210912.L14729@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Dave Francheski <davef@seven-systems.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C5C1E8A.9D0FFAD3@torque.net> <LBEMJABKBLOPOMBFFMDEKECOCBAA.davef@seven-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <LBEMJABKBLOPOMBFFMDEKECOCBAA.davef@seven-systems.com>; from davef@seven-systems.com on Tue, Feb 05, 2002 at 03:20:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 03:20:47PM -0800, Dave Francheski wrote:
> I'm trying to profile an application
> using the 'gprof' utility, and in particular
> get timing information from the profile.
> 
> For some reason, the output from gprof
> displays 
> 
> "no time accumulated"
> 
> and I see no cumulative/self seconds
> at all.  However, all of the call counts
> appear to be correct.
> 
> I suspect that the sampling rate using
> by gprof/linux is simply two slow, given
> the particular application I'm running.
> 
> Can anybody help me obtain timing information
> from gprof and/or point me to a better
> source for application profiling in general?

This is way OT for linux-kernel, but here goes:

If you application runs for a very short amount of time (say, less than a
second) the profile will probably be dominated by glibc startup, application
initializations and exit routines.   It's useless.   That you don't have
time accumulated is the least of your problems - even with the times, your
profile would be random numbers and random function names.

In order to profile *anything* - you should make sure that it runs for a while
(I would say minutes at least, but it depends very much on the complexity of
your application, eg. number of functions involved, and how their run-time is
affected by data input and the environment (timing-sensitive threaded
applications etc.)).  You simply need a good data sample, otherwise any data
you have will be dominated by noise, and your profile will be random.

If it's a very small computational routine, simply put it in a
   for (int i = 0; i != 100000; i++) { ... }

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
