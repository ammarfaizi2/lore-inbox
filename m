Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281328AbRKEUxC>; Mon, 5 Nov 2001 15:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281332AbRKEUwy>; Mon, 5 Nov 2001 15:52:54 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:24001 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S281328AbRKEUws>; Mon, 5 Nov 2001 15:52:48 -0500
Date: Mon, 5 Nov 2001 15:56:33 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Gerd Knorr <kraxel@bytesex.org>
cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
In-Reply-To: <20011105095245.B11001@bytesex.org>
Message-ID: <Pine.LNX.4.20.0111051544120.3346-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Gerd Knorr wrote:

> > > Internal kernel interfaces are another story, they are not fixed and are
> > > allways subject to change and not limited to v4l.  See the major pci
> > > subsystem changes from 2.2 => 2.4 for example.  The API visible to the
> > > application matters, this must stay backward compatible.
> > 
> > You are starting to see my point. I want API flexible enough not to
> > require #ifdef's each time a new feature is added. Driver is an
> > application in it's own right. While 2.2=>2.4 change is ok, I really
> > dislike such changes in the _stable_ kernel. 
> 
> Bad luck for you.  See Linus comments about binary-only modules +
> compatibility.  There is simply no way around a ifdef here and there for
> different kernel versions because a driver IMHO should be maintained for
> both current stable and current hacker kernels.

The change I was talking about has occured someplace between 2.4.2 and
2.4.9. On the other hand some interface did not change at all - for
example serial devices /dev/ttySx. I do not see anything too special to
video capture to warrant constanly changing interfaces.

> 
> > > I can't see why ioctls don't allow you to experiment.
> > > 
> > 
> > Well, could you add then an ioctl to the current kernel so I can
> > experiment with it ? I want it in the kernel headers so that the
> > applications will compile whether or not the driver sourcecode has been
> > installed. Nothing fancy, just an ioctl number something along
> > 
> > #define V4L_VLADIMIR_DERGACHEV_PRIVATE_IOCTL     _IOWR(....)
> > 
> > I'll take care of the structs ;)
> 
> Why this needs to be in the kernel?  Simply ship a copy of the header
> file with both application and driver or require the driver being
> installed to build the application.  Once you've worked out good,
> working interfaces they can go into the kernel headers.  You don't need
> that for experimental stuff.

And what am I to do if someone introduces the exact same ioctl number into
the kernel ? I will get instant breakage. People will start saying: this
does not work with kernele 2.4.(N+x). So, I'll change the number and will
get bugreports of the kind "it does not work with 2.4.(N-1-y)". I do not
want that.

> 
> > > No, it doesn't.  I never had trouble with xawtv.  I simply shipped a
> > > private copy of videodev.h with the xawtv tarball (which allowed to
> > > build it without hassle on 2.0.x systems which had no linux/videodev.h
> > > yet).
> > > 
> > 
> > Well, if it worked for you - good. I am not going that way,
> 
> If you want to put yourself in trouble ...
> 
> > the versioning
> > issues alone are reason enough.
> 
> With argument passing using strings instead of structs you have the
> versioning issues to, they only show up in other ways.  I'd expect it
> becomes harder to debug because the failures are more subtile.  With a
> obsolete ioctl struct you likely get back -EINVAL, which is quite
> obvious if the application does sane error checking.  Or the application
> doesn't even compile.  Both are IMHO much better than some stange

This is a separate issue.. Just keep in mind that there are plenty of
applications that ignore return values from ioctl's.

> behaviour at runtime, which is the failure pattern I'd expect with API
> changes when passing parameters using strings.
> 
> > > I doubt this is just a implementation issue.  I don't believe in AI.
> > > 
> > 
> > :)))) There is a thin line between real intellegence and clever
> > algorithm. My bet is that a clever algorithm will suffice.
> 
> I don't believe this until I've seen that working in real live.

This is something I agree with ;) I posted the RFC to get some feedback
and check whether I missed something important. It does not look this way 
and the question boiled down to one API versus another. I"ll try
implementing the ideas from RFC.. Once this is ready I'll post it for
further discussion.

                 thanks for prompt replies

                                  Vladimir Dergachev

> 
> > > > I would prefer minimum effort on the part of driver writer ;) At the
> > > > moment all I see in bttv and my own code for select is looking on some
> > > > already existing fields. Heck, the code is very similar to what needs to
> > > > be checked for a blocking/non-blocking read. Why duplicate it ?
> > > 
> > > bttv's poll function is very short for exactly this reason.  Basically I
> > > only have to call poll_wait with the (existing) wait queue which the IRQ
> > > handler will wake up once the frame capture is finished.
> > > 
> > 
> > Ohh, bttv _is_ good. I only argue against v4l :)
> 
> But bttv supports the v4l(2) API.  If bttv can handle the poll without
> much extra code, what exactly was the point in arguing against the
> select support defined in the v4l2 API?
> 
>   Gerd
> 

