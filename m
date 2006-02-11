Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWBKPZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWBKPZy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWBKPZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:25:54 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:54932 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932320AbWBKPZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:25:53 -0500
Date: Sat, 11 Feb 2006 16:25:18 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Phillip Susi <psusi@cfl.rr.com>, Marc Koschewski <marc@osknowledge.org>,
       linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git
Message-ID: <20060211152518.GB5721@stiffy.osknowledge.org>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com> <20060210210006.GA5585@stiffy.osknowledge.org> <43ED04E9.9040900@cfl.rr.com> <Pine.LNX.4.61.0602111614050.17942@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602111614050.17942@yvahk01.tjqt.qr>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g25bf368b-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Engelhardt <jengelh@linux01.gwdg.de> [2006-02-11 16:16:58 +0100]:

> >
> > If that is what is going on, there is nothing linux can do about it; it's a
> > limitation of the hardware.  The IDE controller can only accept one command at
> > a time, so if that command takes a while to complete, the other drive on the
> > same channel can not be accessed until the first command completes. 
> 
> CD blanking only takes "one" command for the whole operation, as 
> e.g. compared to CD writing where you always have to push out data packets.

The cdrecord man page says this:

	Setting the -immed flag will request the command to return immediately while
	the operation proceeds in background, making the bus usable for the other
	devices and avoiding the system freeze.  This is an experimental feature which
	may work or not, depending on the model of the CD/DVD writer.  A correct 
	solution would be to set up a correct cabling but there seem to be notebooks
	around that have been set up the wrong way by the manufacturer.  As it is
	impossible to fix this problem in notebooks, the -immed option has been added.

It how can the bus run the command sent on the device 'in the background' when
it can only process _one_ request at a time?

To me it sound like the foreground process (cdrecord) fork()s a process to blank
the CD-RW. Clear. But you said the bus is not able to do so... I'm not getting
this.

> 
> Why I think it's just one (note the quotes): You can interrupt/kill 
> cdrecord in the midst of blanking a CD, and blanking will continue to the 
> 'end' (either fast blank or full blank, whichever was sent)
> 
> As mentioned some time earlier, I had similar, but not the same issues. I 
> could continue accessing the harddrive - otherwise mplayer would have 
> stopped immediately, but it played at least until EOF.
> 
> > If the system doesn't come back though after sufficient time has gone by for
> > the burn to complete, then this is probably not what is happening.  I'd suggest
> > using magic-sysreq to force an unmount and reboot, then see if there's anything
> > in the logs. 
> 
> 
> Jan Engelhardt
> -- 
> 

Marc
