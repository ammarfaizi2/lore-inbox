Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280424AbRKEJlp>; Mon, 5 Nov 2001 04:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280426AbRKEJlg>; Mon, 5 Nov 2001 04:41:36 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:19463 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S280424AbRKEJl3>;
	Mon, 5 Nov 2001 04:41:29 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Nov 2001 09:52:45 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: volodya@mindspring.com
Cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
Message-ID: <20011105095245.B11001@bytesex.org>
In-Reply-To: <20011030105151.A4545@bytesex.org> <Pine.LNX.4.20.0111020951270.29256-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0111020951270.29256-100000@node2.localnet.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Internal kernel interfaces are another story, they are not fixed and are
> > allways subject to change and not limited to v4l.  See the major pci
> > subsystem changes from 2.2 => 2.4 for example.  The API visible to the
> > application matters, this must stay backward compatible.
> 
> You are starting to see my point. I want API flexible enough not to
> require #ifdef's each time a new feature is added. Driver is an
> application in it's own right. While 2.2=>2.4 change is ok, I really
> dislike such changes in the _stable_ kernel. 

Bad luck for you.  See Linus comments about binary-only modules +
compatibility.  There is simply no way around a ifdef here and there for
different kernel versions because a driver IMHO should be maintained for
both current stable and current hacker kernels.

> > I can't see why ioctls don't allow you to experiment.
> > 
> 
> Well, could you add then an ioctl to the current kernel so I can
> experiment with it ? I want it in the kernel headers so that the
> applications will compile whether or not the driver sourcecode has been
> installed. Nothing fancy, just an ioctl number something along
> 
> #define V4L_VLADIMIR_DERGACHEV_PRIVATE_IOCTL     _IOWR(....)
> 
> I'll take care of the structs ;)

Why this needs to be in the kernel?  Simply ship a copy of the header
file with both application and driver or require the driver being
installed to build the application.  Once you've worked out good,
working interfaces they can go into the kernel headers.  You don't need
that for experimental stuff.

> > No, it doesn't.  I never had trouble with xawtv.  I simply shipped a
> > private copy of videodev.h with the xawtv tarball (which allowed to
> > build it without hassle on 2.0.x systems which had no linux/videodev.h
> > yet).
> > 
> 
> Well, if it worked for you - good. I am not going that way,

If you want to put yourself in trouble ...

> the versioning
> issues alone are reason enough.

With argument passing using strings instead of structs you have the
versioning issues to, they only show up in other ways.  I'd expect it
becomes harder to debug because the failures are more subtile.  With a
obsolete ioctl struct you likely get back -EINVAL, which is quite
obvious if the application does sane error checking.  Or the application
doesn't even compile.  Both are IMHO much better than some stange
behaviour at runtime, which is the failure pattern I'd expect with API
changes when passing parameters using strings.

> > I doubt this is just a implementation issue.  I don't believe in AI.
> > 
> 
> :)))) There is a thin line between real intellegence and clever
> algorithm. My bet is that a clever algorithm will suffice.

I don't believe this until I've seen that working in real live.

> > > I would prefer minimum effort on the part of driver writer ;) At the
> > > moment all I see in bttv and my own code for select is looking on some
> > > already existing fields. Heck, the code is very similar to what needs to
> > > be checked for a blocking/non-blocking read. Why duplicate it ?
> > 
> > bttv's poll function is very short for exactly this reason.  Basically I
> > only have to call poll_wait with the (existing) wait queue which the IRQ
> > handler will wake up once the frame capture is finished.
> > 
> 
> Ohh, bttv _is_ good. I only argue against v4l :)

But bttv supports the v4l(2) API.  If bttv can handle the poll without
much extra code, what exactly was the point in arguing against the
select support defined in the v4l2 API?

  Gerd

