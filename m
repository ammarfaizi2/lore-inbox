Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTFMIsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbTFMIsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:48:46 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:1664 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S265264AbTFMIsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:48:45 -0400
Message-Id: <200306130902.h5D92SB2004557@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: inbox
To: Arjan van de Ven <arjanv@redhat.com>
cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>,
       Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD .. 
In-Reply-To: Message from Arjan van de Ven <arjanv@redhat.com> 
   of "Fri, 13 Jun 2003 08:28:57 -0000." <20030613082857.G30329@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 13 Jun 2003 11:02:27 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arjan van de Ven wrote:
> On Fri, Jun 13, 2003 at 10:27:52AM +0200, Rob van Nieuwkerk wrote:
> > 
> > Arjan van de Ven wrote:
> > > On Fri, Jun 13, 2003 at 01:12:57AM +0200, Rob van Nieuwkerk wrote:
> > > > FYI:
> > > > It appears that somewhere between RH kernels 2.4.18-27.7.x and 2.4.20-18.9
> > > > something has changed so that my application needs a O_SYNC too besides
> > > > the O_DIRECT to make sure that writes will be synchronous.  If I leave
> > > > the O_SYNC out with 2.4.20-18.9 the write will happen physically 35
> > > > seconds after the write() was done.
> > > 
> > > O_DIRECT is nothing but a hint and the 2.4.20-18.9 kernel decides to not
> > > honor it
> > 
> > Hi Arjan,
> > 
> > Do you mean that the 2.4.20-18.9 kernel always ignores the O_DIRECT flag ?
> 
> yes.

Hi Arjan,

OK, that would explain why I see an old problem (*) re-appear in my 
application that was solved/worked-around by using O_DIRECT when using
2.4.20-18.9.

Just to make sure I understand it correctly, is it like this: ?
   "Kernel 2.4.20-18.9 completely ignores the O_DIRECT flag.  Not only the
    "synchronous writes part" but also you will get read-ahead despite
    using O_DIRECT.  The 2.4.20-18.9 with O_DIRECT behaviour is similar to
    the 2.4.18-27.7.x without O_DIRECT (concerning synchronity of write()
    and the number of physical media reads & writes)."

Just curious: what is the reason for ignoring O_DIRECT in 2.4.20-18.9 ?
Interactivity behaviour ?

	Greetings,
	Rob van Nieuwkerk


(*) I have an application that runs from CompactFlash that uses a Philips
    webcam (pwc driver).  It turned out that too much CompactFlash access
    (in PIO mode) causes the camera(driver?) to stall and never wake up
     again :-(  I only log 2048 byte records to a raw partition.  With
    O_DIRECT and proper data aligning I could reduce the CF-access to
    exactly 4 512 byte sector writes.  This was enough to never trigger
    the problem.
