Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSJZWKG>; Sat, 26 Oct 2002 18:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbSJZWKG>; Sat, 26 Oct 2002 18:10:06 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:40210 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S261616AbSJZWKF>; Sat, 26 Oct 2002 18:10:05 -0400
Message-ID: <3DBB156E.8AB7C79D@compuserve.com>
Date: Sat, 26 Oct 2002 18:21:34 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Oliver Neukum <oliver@neukum.name>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44-ac3 usb audio - illegal sleep call
References: <3DBAA320.B02AB7FC@compuserve.com> <200210261902.32626.oliver@neukum.name> <3DBADB56.C782BD1D@compuserve.com> <20021026185333.GA2876@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> 
> On Sat, Oct 26, 2002 at 02:13:42PM -0400, Kevin Brosius wrote:
> > Oliver Neukum wrote:
> > >
> > >
> > > Am Samstag, 26. Oktober 2002 16:13 schrieb Kevin Brosius:
> > > > I've been trying to get USB up to test a audio device and just managed
> > > > to get it all working to some extent.  When using xmms to play audio
> > > > (usb audio module - oss soundcore) I see the following kernel messages
> > > > repeatedly, maybe once a second or so:
> > >
> > > Go edit usbout_completed() and usbin_completed(). Change the GFP_KERNEL
> > > in usb_submit_urb to GFP_ATOMIC.
> > > Does that help ?
> > >
> > >         Regards
> > >                 Oliver
> >
> >
> > Hi guys,
> >   No... Well, actually, it does change which function gives the
> > warning.  Now usbout_sync_completed is complaining.
> 
> Heh, can you change that instance of GFP_KERNEL to GFP_ATOMIC too?
> 
> thanks,

Yes, I went ahead and tried that.  I also had do it in usbout_start()
and usbin_sync_completed().  Now I can play audio without any of those
warnings showing up in the log.

This may be unrelated, but I also see the usb audio device fail after
some uses.  For example, using xine with the oss output module will only
play audio for a short time, then audio stops.  After that point it is
impossible to restore audio function from everything I've tried.  I am
unable to kill -9 xine successfully, and unable to rmmod the usb audio
driver to try and reload it.  Only a full reboot will bring it back to
life (I'm sure there are things I haven't tried...)

-- 
Kevin
