Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291711AbSBTJ3J>; Wed, 20 Feb 2002 04:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291707AbSBTJ27>; Wed, 20 Feb 2002 04:28:59 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:57866 "HELO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with SMTP
	id <S287831AbSBTJ2v>; Wed, 20 Feb 2002 04:28:51 -0500
Date: Wed, 20 Feb 2002 10:28:50 +0100
From: Jan Hudec <bulb@ucw.cz>
To: =?iso-8859-2?Q?Rok_Pape=BE?= <rok.papez@kiss.uni-lj.si>, mylinuxk@yahoo.ca,
        linux-kernel@vger.kernel.org
Subject: Re: Communication between two kernel modules
Message-ID: <20020220102850.A4467@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	=?iso-8859-2?Q?Rok_Pape=BE?= <rok.papez@kiss.uni-lj.si>,
	mylinuxk@yahoo.ca, linux-kernel@vger.kernel.org
In-Reply-To: <20020218173229.47247.qmail@web14907.mail.yahoo.com> <02021819300201.00953@strader.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <02021819300201.00953@strader.home>; from rok.papez@kiss.uni-lj.si on Mon, Feb 18, 2002 at 07:30:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi, how can I call some kind of APIs from kernel mode,
> > such as open, ioctl and close? Because I need to use
> > some services of another kernel module from my kernel
> > module and I have no source code of the module which
> > provides the services. Now I can only access the
> > module in user space using the open, ioctl and close
> > APIs. Can I do the same thing in my kernel module?
> Create a user-space app that will ioctl into your driver and wait for 
> requests. When your module needs to call the other module it delivers request 
> to the user-space app wich in turn calls the other module and returns results 
> via another ioctl call.
> 
> Take care not to deadlock.. In user space app use fork() or threads and 
> handle module requests async...
> 
> Be ready to handle an event when your user-space app unexpectedly dies.

Seems way too complicated to me. You can do everything from kernel.
You probably shouldn't use file handles in kernel, but you can use
file structure. Just open via filp_open, ioctl via ->f_op->ioctl
and close via filp_close (it will fput the structure).

You have to be in process context, either your ioctl handler or kernel
thread would do.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
