Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSANTPY>; Mon, 14 Jan 2002 14:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSANTOD>; Mon, 14 Jan 2002 14:14:03 -0500
Received: from chmls05.mediaone.net ([24.147.1.143]:32999 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S288959AbSANTMk>; Mon, 14 Jan 2002 14:12:40 -0500
Date: Mon, 14 Jan 2002 13:58:02 -0500
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <20020114135802.A4762@pimlott.ne.mediaone.net>
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <F50839283B51D211BC300008C7A4D63F0C10759D@eukgunt002.uk.eu.ericsson.se> <20020114111141.A14332@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114111141.A14332@thyrsus.com>
User-Agent: Mutt/1.3.23i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 11:11:41AM -0500, Eric S. Raymond wrote:
> Michael Lazarou (ETL) <Michael.Lazarou@etl.ericsson.se>:
> > Doesn't this mean that you would need a fully functional kernel
> > before you get to run the autoconfigurator?
> 
> Yes, but this was always true.

I think the point people are getting at is:  If you're re-detecting
things that have already been detected, doesn't it seem you're going
about the problem the wrong way?

Most distributors need to solve essentially the same problem you're
solving (detect hardware and install drivers), but without compiling
a kernel (if only to spare the user the wait).  To the extent that
they are successful (and they will presumably put considerable
effort into it), your compile-time probes are superfluous--you're
better off piggy-backing on the distribution's hardware detection.
Eg, derive your .config from the modules the distribution has
decided to load, or--even simpler--just compile a kernel with the
same .config as the distributor's kernel, and let the boot-time
scripts take care of the rest.  The drawback is that this differs
across distributions--but see below.

Even if you can usually do a better job, you have two major
handicaps:  One, you may have to repeat questions that the
distribution already asked, annoying the user.  Two, if you ever
screw up something the distribution had working, the user will curse
you.

Which leads me to conclude that your compile-time autodetection,
while cool, is a dead-end as far as helping Cousin Billie (though I
do support the ultimate goal of letting him compile a kernel).
There are some scenarios where you win, but not enough IMO.

To correct this, retarget the project to solve the distributors'
problem.  Ie, add a back-end that specifies modules and module
options, instead of a kernel .config.  Assuming you do a good enough
job, and meet the distributor's other requirements (eg, running in
an install environment), then they will use your system for their
install-time hardware detection.  You can store the results in a
standard (across distributions!) format, which administrators will
love (and which can be used by various to-be-written utilities).
Finally, you can later use the same database for compiling a
"stripped-down" custom kernel.

Andrew
