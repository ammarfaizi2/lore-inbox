Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSDKRNd>; Thu, 11 Apr 2002 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312563AbSDKRNc>; Thu, 11 Apr 2002 13:13:32 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:27071 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312526AbSDKRNb>;
	Thu, 11 Apr 2002 13:13:31 -0400
Date: Thu, 11 Apr 2002 19:12:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020411191249.A15435@ucw.cz>
In-Reply-To: <20020411154601.GY17962@antefacto.com> <20020411164331.GR612@gallifrey> <20020411184923.A15238@ucw.cz> <1018544869.962.22.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 01:07:44PM -0400, Ed Sweetman wrote:
> On Thu, 2002-04-11 at 12:49, Vojtech Pavlik wrote:
> > On Thu, Apr 11, 2002 at 05:43:31PM +0100, Dr. David Alan Gilbert wrote:
> > > * John P. Looney (john@antefacto.com) wrote:
> > > >  Sorry if this isn't the place for this question, but it's something that
> > > > came up in general office talk today.
> > > > 
> > > >  Many many moons ago, the GGI project promised us the ability to buy a
> > > > four-processor box, four PCI video cards, four USB mice & keyboards, and
> > > > let four people use that machine at once, with benefits all around.
> > > 
> > > <snip>
> > > 
> > > >  Are there any plans to bring this sort of functionality to Linux 2.6 ? As
> > > > I remember, some of the problems were that the GGI code was never going to
> > > > get into Linux proper, and enumeration of multiple keyboards and mice, but
> > > > I would have thought that was there a need, these problems would have been
> > > > fixed by now.
> > > 
> > > I'm not sure, but I don't think any code is needed if you run X.  Bung
> > > four USB mice, four USB keyboards in and four video cards.  Write a
> > > separate X config for each one specifying which PCI card should be used
> > > and which mouse/keyboard device should be used.  Now start an X server
> > > for each one.
> > 
> > Doesn't work unfortunately. The separate Xservers stomp on each others
> > toes in the process. It works if you use fbcon (thus no acceleration, no
> > 3d), USB, and hack the X servers not to switch consoles, and take
> > keyboard input from /dev/input/event devices. But that's still far from
> > the desired state of things.
> why would they step on eachother's toes?  You tell each one to goto a
> separate vc and give each a separate identifier :2 vt8 :3 vt9 etc. If
> each one is using a separate video card, then they should all be able to
> run accelerated (no dri) and be fine.  

1) Only one VT can be active at a time. Even with multiple cards. Thus
only one X server will be active at a time, others will show a blank
screen.

2) If you hack out the VT switching out of X, then still each X server
will disable all PCI resources for other video cards, because it
believes it owns the system. This will freeze all other active X
servers.

-- 
Vojtech Pavlik
SuSE Labs
