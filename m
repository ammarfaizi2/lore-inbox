Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269650AbUIRWhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269650AbUIRWhR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 18:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269653AbUIRWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 18:37:17 -0400
Received: from web11905.mail.yahoo.com ([216.136.172.189]:44298 "HELO
	web11905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269650AbUIRWhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 18:37:12 -0400
Message-ID: <20040918223711.1693.qmail@web11905.mail.yahoo.com>
Date: Sat, 18 Sep 2004 15:37:11 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091815125ef78738@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jon Smirl <jonsmirl@gmail.com> wrote:

> On Sat, 18 Sep 2004 12:58:07 -0700 (PDT), Mike Mestnik
> <cheako911@yahoo.com> wrote:
> > This is intersting...
> > I'd like to know how you plan to use VCs?  That is more then one tty
> > sharing the same monitor.  I'd also like to see VCs able to change
> modes
> > while not being active, thought I can't imagin how one would plan todo
> > this  /wo blocking.  I don't see any good reason why it can't be an
> ioctl,
> > you can have the same exe/bin/app handle BOTH the user and root parts
> of
> > the mode change.  This way it can keep a cache of things, like modes
> that
> > will currently not be valid.
> 
> VCs should be dealt with at a higher layer. This higher layer would
> track what mode is on each virtual console and set it back after
> console swap. The VC code would provide it's own sysfs mode attribute
> in the VC's sysfs entry. A VC layer may suppress direct access to the
> head specific mode attribute. This brings up a question, how do I know
> which sysfs VC entry corresponds to the one I'm logged into?
> 
In this(the above) model this may work.  How will Xorg handle VT swaps in
the above model?

> I'm trying to allow for a user space VC implementation at some point
> in the future so I don't want to build assumptions about a kernel
> space VC implementation into the code.
> 
That seams like a good plan, thought current user space multi-'screen'
implementations leave much too desier.  'detachtty' seams like the best
one, but it dosen't directly support switching tasks.

Befour this idea will get off the ground a good system too handel this in
userspace is needed, I think.  I don't think that this app/daemon would
have anything todo with mode setting or video drivers, exept the console
drivers allready provided by most OSs.

> The sysfs scheme has the advantage that there is no special user
> command required. You just use echo or cp to set the mode.
> 
We allready have programs that change the video mode.  It's true thay lack
support for some things, but I can't see the harm in adding on to existing
mode-setting programs.

If that's not good enuff there's no reason that the userland hotplug
script/program can't also provide these features if called by a non-root
user.  If called by root, it just dose what it's told /wo the hp or mode
setting ioctl.

> I'm still undecided if there needs to be a root priv daemon caching
> the EDID and polling for a monitor change. EDID can be regenerated on
> each request to change mode but it takes a few seconds. The root priv
> daemon will dynamically link to card specific libraries. Initially I'm
> going to add the functions to the mesa libraries but they may get
> broken out later.
> 
/etc/mtab is a good concept, you might want to put this some where in /var
thought.  Then there's no need to TSR.

> > There is another thing I can't see.  Why can't the module for the drm
> > create fb[0-9]* devices, one for each monitor?  This would seam to
> solve
> > the problem with having another app and ioctl(API).
> 
> The DRM driver I'm working on already creates one DRM device for each
> head. Doing this also creates a sysfs entry for each head too. Each
> head has it's own mode/modes attributes.
> 
So can we link fb to drm, for compatibility reasons?

> Another item is merged fb. Initially heads will be unowned. Logging
> into a head makes you the owner. If you ask for the modes available on
> your head the list will also contain merged fb mode. If you set a
> merged fb mode, the login process on the secondary screen needs to be
> killed. If some one is logged into the secondary head merged fb modes
> won't be in the list. This scheme has the nice side effect of making
> all heads equal, there is no separate controlling device for the card.
> 
I don't see this as more then a fue more ioctls or rather just appending
some data on the end of existing structures to say what
location/framebuffer to attach too or create.

The other code has tobe done no matter what.

> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
