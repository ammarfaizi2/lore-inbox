Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129149AbRBHSyU>; Thu, 8 Feb 2001 13:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbRBHSyK>; Thu, 8 Feb 2001 13:54:10 -0500
Received: from clueserver.org ([206.163.47.224]:41733 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S129129AbRBHSyA>;
	Thu, 8 Feb 2001 13:54:00 -0500
Date: Thu, 8 Feb 2001 11:05:32 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Alex Deucher <adeucher@UU.NET>, linux-kernel@vger.kernel.org,
        jhartmann@valinux.com
Subject: Re: [OT] Re: 2.4.x, drm, g400 and pci_set_master
In-Reply-To: <14EAB47C173C@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10102081055350.9940-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Petr Vandrovec wrote:

> On  8 Feb 01 at 13:14, Alex Deucher wrote:
> > Jeff Hartmann wrote:
> > > Petr Vandrovec wrote:
> 
> > > It does not use dynamic DMA mapping, because it doesn't do PCI DMA at
> > > all.  It uses AGP DMA.  Actually, it shouldn't be too hard to get it to
> > > work on the Alpha (just a few 32/64 bit issues probably.)  Someone just
> > > needs to get agpgart working on the Alpha, thats the big step.
> > 
> > That shouldn't be too hard since many (all?) AGP alpha boards (UP1000's
> > anyway) are based on the AMD 751 Northbridge? And there is already
> > support for that in the kernel for x86. 
> 
> My AlphaPC 164LX does not have AGP at all - and I want to get G200/G400 PCI 
> working on it with dri, using 21174 features.

After looking into this a little more I have found it is uglier than that.
The answers I have are not very good.

I assume you are wanting to use this with X.  There is a rather odd driver
issue involved.

There are two X drivers available for the G400. One from Matrox and one in
the version of X that you are using.

The Matrox driver will not work under the 2.4.x kernel for DRM due to a
version conflict.  (It wants version 1.0 and 2.4.x uses version 2.0.)  It
will also not compile with 4.0.2 and above at the present time.

The XFree86 version has some odd problems in Xinerama, but at least it
works.  (Ugly artifact borders on the second screen.)

BUT...

Both drivers want Matrox's HALlib. (Which is x86 binary only.) Matrox will
not release the info on that interface to the chipset.  (Using the
standard corporate excuse whenever they don't want to do something
"Intelectual Property concerns".)

Good luck on getting them to make an Alpha version of the library or get
them to release the underlying library interface specs. 

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
