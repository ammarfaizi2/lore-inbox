Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279711AbRKFPiA>; Tue, 6 Nov 2001 10:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279649AbRKFPhu>; Tue, 6 Nov 2001 10:37:50 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:18896 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S279711AbRKFPhh>; Tue, 6 Nov 2001 10:37:37 -0500
Date: Tue, 6 Nov 2001 10:41:22 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Gerd Knorr <kraxel@bytesex.org>
cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
In-Reply-To: <20011105225201.A17854@bytesex.org>
Message-ID: <Pine.LNX.4.20.0111061033150.4730-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Gerd Knorr wrote:

> > > different kernel versions because a driver IMHO should be maintained for
> > > both current stable and current hacker kernels.
> > 
> > The change I was talking about has occured someplace between 2.4.2 and
> > 2.4.9. On the other hand some interface did not change at all - for
> > example serial devices /dev/ttySx. I do not see anything too special to
> > video capture to warrant constanly changing interfaces.
> 
> That was me in kernel 2.4.3 IIRC.  Added one more argument to allow
> drivers to ask for specific minor numbers (so you can give your devices
> fixed minor numbers using insmod options).  And this has _NOTHING_ to do
> with the API visible to the applications.
> 

It has to do with the API visible to the driver.

> 
> > > Why this needs to be in the kernel?  Simply ship a copy of the header
> > > file with both application and driver or require the driver being
> > > installed to build the application.  Once you've worked out good,
> > > working interfaces they can go into the kernel headers.  You don't need
> > > that for experimental stuff.
> > 
> > And what am I to do if someone introduces the exact same ioctl number into
> > the kernel ? I will get instant breakage. People will start saying: this
> > does not work with kernele 2.4.(N+x). So, I'll change the number and will
> > get bugreports of the kind "it does not work with 2.4.(N-1-y)". I do not
> > want that.
> 
> Such clashes shouldn't happen as v4l has ioctl number ranges for driver
> private stuff which can be used for such tests and shouldn't cause
> clashes with new, official ioctls.

I did not know that - thanks. Where do I find notes on this ?

> 
> Beside that I don't see why breaking applications is a problem for
> _experimental_ interfaces.  On the one hand you want to have the

It is a problem because I want as many people as possible to try them.
This is the only way to work out installation dependent bugs. There is a
lot of variety out there: Redhat, Mandrake, Slackware, Suse, ix86,
PowerPC, Alpha, Sparc.. Each is a little different.

> flexibility to change interfaces easily to test them, on the other hand
> you care alot about compatibility and stuff.  You can't get both, I
> don't see a way to do that without making either the drivers or the
> applications (or both) very complex.

Now here you are wrong. C have not changed in a while and you can still
write any programs in it ;) As for complexity.. I don't mind 10000 line
file if it is backed up by good algorithm. The good news is that with this
approach we separate interface stuff from driver dependent stuff - and,
hence, the most complex part can be easily tested.

> 
> That is the price users will have to pay for playing with bleeding edge
> stuff.
> 
> > > becomes harder to debug because the failures are more subtile.  With a
> > > obsolete ioctl struct you likely get back -EINVAL, which is quite
> > > obvious if the application does sane error checking.  Or the application
> > > doesn't even compile.  Both are IMHO much better than some stange
> > 
> > This is a separate issue.. Just keep in mind that there are plenty of
> > applications that ignore return values from ioctl's.
> 
> s/applications/broken applications/

The line here is even finer than between AI and clever algorithm ;)

                                  Vladimir Dergachev

> 
>   Gerd
> 
> -- 
> Netscape is unable to locate the server localhost:8000.
> Please check the server name and try again.
> 

