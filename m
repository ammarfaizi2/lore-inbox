Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317503AbSG3Ax6>; Mon, 29 Jul 2002 20:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSG3Ax6>; Mon, 29 Jul 2002 20:53:58 -0400
Received: from brynhild.MtRoyal.AB.CA ([142.109.10.24]:61918 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S317503AbSG3Ax5>; Mon, 29 Jul 2002 20:53:57 -0400
Date: Mon, 29 Jul 2002 18:56:57 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Andrew Theurer <habanero@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
In-Reply-To: <200207291842.16145.habanero@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207291849530.20963-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Andrew Theurer wrote:

> On Monday 29 July 2002 7:37 pm, Alan Cox wrote:
> > On Mon, 2002-07-29 at 21:58, Andrew Theurer wrote:
> > > Agreed, we need some sort of irqbalance, and I intend to test with Ingo's
> > > and Andrea's approaches. With that addition, I may even see an
> > > improvement with hyperthreading. But for an rc release, I think it would
> > > be prudent to revert the "new code" for default hyperthreading behavior,
> > > and attack the whole problem in 2.4.20 or later release.
> >
> > Because your personal workload is slower ?
> 
> Well, I would think some here would be interested in samba performance.   
> However, If 4-way P4 systems are considered rare at this point I guess it's 
> not important enough to revert.  FYI, after testing 2P with and without 
> hyperthreading, it's much faster.  481 Mbps for no hyperthreading and 605 
> Mbps with.  If I can get even close to that improvement with 4 processors, 
> I'll be very happy.   

Hyperthreading only helps if you are running a process when uses a lot
of concurrent process binding up CPU time (IE, more runnable processes
waiting then there are CPUs).  I/O won't be much effected, and I found
that it actually gave a performance hit to turn it on if you weren't using
it (about 5%, maybe) if you are not utilizing the existing processors.

Of course, if you are already talking a single, dual, or quad P4 at 1.8GHz
or something, 5% sounds like a lot, but if you're not using it
that heavily you won't actually notice the 5% loss in performance (well,
unless you are watching some kind of image rendering software do it's
thing? =).

Some tests I performed in April are at http://www.hardrock.org/HT-results/

You can see in the kernel compile output the difference.

Regards
James Bourne
> 
> -Andrew Theurer
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."


