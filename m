Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286429AbRLTWeS>; Thu, 20 Dec 2001 17:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286430AbRLTWeJ>; Thu, 20 Dec 2001 17:34:09 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1786 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S286429AbRLTWdu>; Thu, 20 Dec 2001 17:33:50 -0500
Message-ID: <3C226708.FECAE3CD@mvista.com>
Date: Thu, 20 Dec 2001 14:32:40 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin A. Brooks" <martin@jtrix.com>
CC: Mark Hahn <hahn@physics.mcmaster.ca>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: asymmetric multiprocessing
In-Reply-To: <Pine.LNX.4.33.0112200912480.7795-100000@coffee.psychology.mcmaster.ca> <1008858802.431.43.camel@unhygienix>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin A. Brooks" wrote:
> 
> On Thu, 2001-12-20 at 14:13, Mark Hahn wrote:
> > not supported (and frowned upon by the spec).  the issue is TSC,
> > of course, and it's definitely not clear whether the normal case
> > (correctly configured SMP) should be burdoned by support for
> > mixed-clock chips.
> 
> I'm no expert on MP, hence I fail to see why differing clock speeds
> between CPUs should be a problem providing the system bus rates are
> constant. As each CPU would be rated differently as far as bogomips are
> concerned, couldn't the scheduler apply load accordingly?
> 
But then you are forcing the system to include cpu information each time
it reads the TSC.  For example, the TSC is currently used to provide the
sub jiffie resolution for the system clock.  If you also need to include
which cpu you run into a couple of problems: a) what if the start TSC is
read from a different cpu than the end TSC?  (In this case the start is
the last jiffie interrupt and the end is "now" when the time is being
requested.)  b.) The conversion to micro seconds depends on the clock
rate, i.e. the TSC clock rate.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
