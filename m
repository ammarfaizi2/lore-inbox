Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRKFQzb>; Tue, 6 Nov 2001 11:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279788AbRKFQzV>; Tue, 6 Nov 2001 11:55:21 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:56582 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S279778AbRKFQzI>;
	Tue, 6 Nov 2001 11:55:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 6 Nov 2001 17:45:13 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: volodya@mindspring.com
Cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
Message-ID: <20011106174513.A7462@bytesex.org>
In-Reply-To: <20011105225201.A17854@bytesex.org> <Pine.LNX.4.20.0111061033150.4730-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0111061033150.4730-100000@node2.localnet.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > drivers to ask for specific minor numbers (so you can give your devices
> > fixed minor numbers using insmod options).  And this has _NOTHING_ to do
> > with the API visible to the applications.
> 
> It has to do with the API visible to the driver.

Yes.  Why do you mix the two?  These are completely separate issues.

> > Such clashes shouldn't happen as v4l has ioctl number ranges for driver
> > private stuff which can be used for such tests and shouldn't cause
> > clashes with new, official ioctls.
> 
> I did not know that - thanks. Where do I find notes on this ?

BASE_VIDIOCPRIVATE is defined in videodev.h and used by various drivers
in drivers/media/video

> > Beside that I don't see why breaking applications is a problem for
> > _experimental_ interfaces.  On the one hand you want to have the
> 
> It is a problem because I want as many people as possible to try them.
> This is the only way to work out installation dependent bugs. There is a
> lot of variety out there: Redhat, Mandrake, Slackware, Suse, ix86,
> PowerPC, Alpha, Sparc.. Each is a little different.

And how installation issues are related to API design / testing?

> > flexibility to change interfaces easily to test them, on the other hand
> > you care alot about compatibility and stuff.  You can't get both, I
> > don't see a way to do that without making either the drivers or the
> > applications (or both) very complex.
> 
> Now here you are wrong. C have not changed in a while and you can still
> write any programs in it ;) As for complexity.. I don't mind 10000 line
> file if it is backed up by good algorithm. The good news is that with this
> approach we separate interface stuff from driver dependent stuff - and,
> hence, the most complex part can be easily tested.

I doubt this.  IMHO the complex part isn't the read/write interface and
the string parsing (I'd expect this can easily separated out into some
kind of library / kernel module / whatever).  The complex part is to
keep the backward compatibility while changing/improving the interfaces
(which is one of your goals with the new approach, right?), and I don't
see a way to handle that in generic, driver-independant code ...

  Gerd

-- 
Netscape is unable to locate the server localhost:8000.
Please check the server name and try again.
