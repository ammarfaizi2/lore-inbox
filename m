Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292305AbSBPBUA>; Fri, 15 Feb 2002 20:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292307AbSBPBTv>; Fri, 15 Feb 2002 20:19:51 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32781
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292305AbSBPBTi>; Fri, 15 Feb 2002 20:19:38 -0500
Date: Fri, 15 Feb 2002 17:08:20 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Pavel Machek <pavel@suse.cz>
cc: Rob Landley <landley@trommello.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: small IDE cleanup: void * should not be used unless neccessary
In-Reply-To: <20020213225047.GI1454@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10202151707440.10501-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> > > > > This is really easy, please apply. (It will allow me to kill few casts
> > > > > in future).
> > > > > 								Pavel
> > > > >
> > > > > --- linux/include/linux/ide.h	Mon Feb 11 21:15:04 2002
> > > > > +++ linux-dm/include/linux/ide.h	Mon Feb 11 22:36:12 2002
> > > > > @@ -529,7 +531,7 @@
> > > > >
> > > > >  typedef struct hwif_s {
> > > > >  	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
> > > > > -	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
> > > > > +	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
> > > > >  	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
> > > > >  	hw_regs_t	hw;		/* Hardware info */
> > > > >  	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
> > > >
> > > > Now I'm confused about the comment on the end of the line.
> > > >
> > > > Should the comment be changed, or should the type be ide_hwgroup_t
> > > > instead of struct hwgroup_s?
> > >
> > > struct hwgroup_s == ide_hwgroup_t. That's infection by hungarian
> > > notation, and yes it would be nice to clean it up. For now, I'm
> > > killing worst stuff.
> > > 							Pavel
> > 
> > I know they're functionally equivalent, but so was the original void
> > *. :)
> 
> Well, void * hides real errors.
> 
> > Just an "as long as you're touching this line anyway, why leave the old 
> > comment?" thing.  A minor, in-passing nit at best...
> 
> ide_hwgroup_t is used in 90% of rest of code, so I thought I better
> leave it there.

So what do we do with the other 10% break it?  Sheesh :-/


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

