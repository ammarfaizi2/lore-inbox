Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSKIWVH>; Sat, 9 Nov 2002 17:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbSKIWVH>; Sat, 9 Nov 2002 17:21:07 -0500
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:3712 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262783AbSKIWVG>; Sat, 9 Nov 2002 17:21:06 -0500
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: Vojtech Pavlik <vojtech@suse.cz>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: PROBLEM: PS/2 mouse wart does not work, while scratch pad does.
Date: Sat, 9 Nov 2002 22:50:22 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200210221046.46700.Take.Vos@binary-magic.com> <5001.1035330391@passion.cambridge.redhat.com> <20021023104222.B28139@ucw.cz>
In-Reply-To: <20021023104222.B28139@ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211092250.27337.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hallo,

On Wednesday 23 October 2002 10:42, Vojtech Pavlik wrote:
> On Wed, Oct 23, 2002 at 12:46:31AM +0100, David Woodhouse wrote:
> > Take.Vos@binary-magic.com said:
> > > hardware:DELL Inspiron 8100
> > >
> > >  The internal scratch pad works, but the internal wart mouse doesn't,
> > Probing for various other PS/2 extensions appears to confuse the thing
> > such that the clitmouse no longer works. If we probe for it first and
> > then abort the other probes, it seems happier...
This patch does display the "Synaptics TouchPad", but does not solve the 
problem of not finding the clitmouse.

> Thanks, applied.
2.5.46 does not show the "Synaptics TouchPad" during boot, which this patch 
did.

Greetings,
	Take Vos

> > --- 1.16/drivers/input/mouse/psmouse.c  Tue Oct  8 11:51:30 2002
> > +++ edited/drivers/input/mouse/psmouse.c        Wed Oct 23 00:39:06 2002
> > @@ -311,6 +311,26 @@
> >         if (psmouse_noext)
> >                 return PSMOUSE_PS2;
> >
> > +/*
> > + * Try Synaptics TouchPad magic ID
> > + */
> > +
> > +       param[0] = 0;
> > +       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> > +       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> > +       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> > +       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> > +       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
> > +
> > +       if (param[1] == 0x47) {
> > +               /* We could do more here. But it's sufficient just
> > +                  to stop the subsequent probes from screwing the
> > +                  thing up. */
> > +               psmouse->vendor = "Synaptics";
> > +               psmouse->name = "TouchPad";
> > +               return PSMOUSE_PS2;
> > +       }
> > +
> >  /*
> >   * Try Genius NetMouse magic init.
> >   */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9zYMiMMlizP1UqoURAow3AJwLthJCIB8cZuHRIXps+R5cP2exTACeOe0y
qoFoX9a9JwQYpQhyhcBrrmY=
=9paf
-----END PGP SIGNATURE-----

