Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbTDAGco>; Tue, 1 Apr 2003 01:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbTDAGco>; Tue, 1 Apr 2003 01:32:44 -0500
Received: from granite.he.net ([216.218.226.66]:54535 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S262065AbTDAGcn>;
	Tue, 1 Apr 2003 01:32:43 -0500
Date: Mon, 31 Mar 2003 22:44:39 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>,
       azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030331224439.A7000@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <20030327172516.GA32667@kroah.com> <20030330192312.GB6666@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030330192312.GB6666@zaurus.ucw.cz>; from pavel@ucw.cz on Sun, Mar 30, 2003 at 09:23:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 09:23:12PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > >	       	Floating point values XXX.X or XXX.XX in degrees Celcius.
> > > 
> > > If we're restructuring it, I think we should also agree on _one_ common 
> > > denominator for all values ie. mVolt and milli-Degree Celsius, so that 
> > > no userspace program ever again has know how to convert them to 
> > > user-readable values and every user can just cat the values and doesn't 
> > > have to wonder if it's centi-Volt, milli-Volt, centi-Degree, dezi-Degree 
> > > or whatever.
> > 
> > Um, that's what my proposal stated.  Do you not agree with it?  (You're
> > quoting the existing document above, not my proposed changes.)
> 
> Well, you had cV for PSU voltages and
> mV for cpu core voltage. I guess mV
> and mili-deg-C everywhere would be
> nicer. 

I was trying to keep consistant with what the old /proc values were
reported as.  I'll go fix that up.

As for why no floating point, it's a pain in the but to both output a
fixed point number from the kernel into floating point, and to parse a
floating point number from userspace within the kernel, turning it into
a fixed point number.  With the proposal I wrote up, none of that is
needed, and all userspace has to do is divide by a factor of 10 to get
the proper value.

It's much simpler and easier to validate we got it right code.  If
you're still not convinced take a look at the code in
drivers/i2c/i2c-proc.c::i2c_parse_reals() for an example of some hairy
code...

thanks,

greg k-h
