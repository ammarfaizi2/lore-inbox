Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132715AbRDCXaI>; Tue, 3 Apr 2001 19:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132716AbRDCX36>; Tue, 3 Apr 2001 19:29:58 -0400
Received: from monza.monza.org ([209.102.105.34]:62469 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132715AbRDCX3p>;
	Tue, 3 Apr 2001 19:29:45 -0400
Date: Tue, 3 Apr 2001 16:28:10 -0700
From: Tim Wright <timw@splhi.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
        torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
Message-ID: <20010403162810.B770@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
	torvalds@transmeta.com, hpa@transmeta.com,
	linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <20010403120911.B4561@nightmaster.csn.tu-chemnitz.de> <E14kPZz-0007tk-00@the-village.bc.nu> <20010403142024.Z8155@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010403142024.Z8155@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Tue, Apr 03, 2001 at 02:20:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 02:20:24PM +0200, Ingo Oeser wrote:
> On Tue, Apr 03, 2001 at 01:06:33PM +0100, Alan Cox wrote:
> > Device numbers/names have to be constant in order to detect
> > disk layout changes across boots.
> 
> Names stay constant, but why the NUMBERS? The names should stay
> constant and represent the actual layout on each busses (say:
> sane hierachic enumeration) of course.
> 

This ignores the issue that in some cases you cannot give a physical location.
Take the case of fibre-channel connected disks, potentially using multi-path
I/O. There is no "actual layout" since you don't have a fixed physical path.
At that point you have to have a more sophisticated naming scheme than the
physical location of the disk, since physical location loses its meaning.

You absolutely must avoid device name slippage. Whether this involves major
and minor numbers is pretty much orthogonal. Major and minor numbers provided
a nice and simple way for the kernel to map a device open into a driver and an
argument to said driver. There are obviously other (more complex ways) of
achieving the same thing. An obvious answer for hard disks is some form of
labelling. Equally obviously, this does not solve the problem of e.g.
fibre-channel connected tape drives.

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
