Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286070AbRLJAMN>; Sun, 9 Dec 2001 19:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286100AbRLJAMD>; Sun, 9 Dec 2001 19:12:03 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:7317 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286070AbRLJALz>; Sun, 9 Dec 2001 19:11:55 -0500
Date: Sun, 9 Dec 2001 17:11:37 -0700
Message-Id: <200112100011.fBA0Bbu14224@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Roman Zippel <zippel@linux-m68k.org>, Rene Rebe <rene.rebe@gmx.net>,
        linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <Pine.LNX.4.21.0112091919060.24350-100000@freak.distro.conectiva>
In-Reply-To: <3C13E52A.48C0843D@linux-m68k.org>
	<Pine.LNX.4.21.0112091919060.24350-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
> 
> 
> On Sun, 9 Dec 2001, Roman Zippel wrote:
> 
> > Hi,
> > 
> > Richard Gooch wrote:
> > 
> > > There are some broken boot scripts (modelled after the long obsolete
> > > rc.devfs script)
> > 
> > Which is still included in the kernel tree and at least Mandrake is
> > currently using it.
> > There were no signs of deprecation, so people are legally using it.

I mentioned it somewhere, but it might not have been on the list. It
was a long time ago.

> > > This is not actually a problem for leaf nodes, since the user-space
> > > created device nodes will still work. It just results in a warning
> > > message.
> > 
> > Wrong, these are not just warning messages, the driver API has changed.
> > 
> > > So, in this case, the device nodes that the user wants to use will
> > > still be there (created by the boot script) and will work fine.
> > 
> > Except the dynamic update of device nodes won't happen anymore, so it
> > affects also all leaf nodes in the directories (e.g. partition entries
> > won't be created/removed anymore). Events won't be created for these
> > nodes as well, so configurations depending on this are broken as well.
>
> Richard, 
> 
> Are the above problems really introduced by the changes ? 

Yes, although I still think it's not a common problem. In general, if
you are tarring and untarring inodes, you take the whole directory and
put it all back again. Even the partitioning event is a corner case,
since you're most likely to install a new drive (and thus have no
inodes to "restore") and then partition. And even the obsolete
rc.devfs only saved away inodes which had been changed, not
everything.

However, if this concerns you, I can send a patch that effectively
restores the old behaviour for directories. It's just a matter of
grabbing the right lock, fiddling a flag and returning a different
entry. But I definately want to keep a warning message. I want there
to be some pain for broken or really obsolete configurations.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
