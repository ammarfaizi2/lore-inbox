Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278098AbRKFGub>; Tue, 6 Nov 2001 01:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278218AbRKFGuV>; Tue, 6 Nov 2001 01:50:21 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:29196 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S278125AbRKFGuJ>;
	Tue, 6 Nov 2001 01:50:09 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Nov 2001 22:52:01 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: volodya@mindspring.com
Cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
Message-ID: <20011105225201.A17854@bytesex.org>
In-Reply-To: <20011105095245.B11001@bytesex.org> <Pine.LNX.4.20.0111051544120.3346-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0111051544120.3346-100000@node2.localnet.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > different kernel versions because a driver IMHO should be maintained for
> > both current stable and current hacker kernels.
> 
> The change I was talking about has occured someplace between 2.4.2 and
> 2.4.9. On the other hand some interface did not change at all - for
> example serial devices /dev/ttySx. I do not see anything too special to
> video capture to warrant constanly changing interfaces.

That was me in kernel 2.4.3 IIRC.  Added one more argument to allow
drivers to ask for specific minor numbers (so you can give your devices
fixed minor numbers using insmod options).  And this has _NOTHING_ to do
with the API visible to the applications.


> > Why this needs to be in the kernel?  Simply ship a copy of the header
> > file with both application and driver or require the driver being
> > installed to build the application.  Once you've worked out good,
> > working interfaces they can go into the kernel headers.  You don't need
> > that for experimental stuff.
> 
> And what am I to do if someone introduces the exact same ioctl number into
> the kernel ? I will get instant breakage. People will start saying: this
> does not work with kernele 2.4.(N+x). So, I'll change the number and will
> get bugreports of the kind "it does not work with 2.4.(N-1-y)". I do not
> want that.

Such clashes shouldn't happen as v4l has ioctl number ranges for driver
private stuff which can be used for such tests and shouldn't cause
clashes with new, official ioctls.

Beside that I don't see why breaking applications is a problem for
_experimental_ interfaces.  On the one hand you want to have the
flexibility to change interfaces easily to test them, on the other hand
you care alot about compatibility and stuff.  You can't get both, I
don't see a way to do that without making either the drivers or the
applications (or both) very complex.

That is the price users will have to pay for playing with bleeding edge
stuff.

> > becomes harder to debug because the failures are more subtile.  With a
> > obsolete ioctl struct you likely get back -EINVAL, which is quite
> > obvious if the application does sane error checking.  Or the application
> > doesn't even compile.  Both are IMHO much better than some stange
> 
> This is a separate issue.. Just keep in mind that there are plenty of
> applications that ignore return values from ioctl's.

s/applications/broken applications/

  Gerd

-- 
Netscape is unable to locate the server localhost:8000.
Please check the server name and try again.
