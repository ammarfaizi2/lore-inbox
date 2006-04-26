Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWDZCKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWDZCKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWDZCKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:10:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:45020 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932339AbWDZCKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:10:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CRzefz50dQ1AlVEkIp50ilb0oT+N1mnlRUV3nApfBO0u2B3NzFcauXXdBxwllXkloT3GbpME8oiHJ+mkmAxJ06evoPCbHc7gqP6m5k4F1GRuJq3vlWdJuFJso4i53aawmmnNvPFg4SyYGD/nwh63QCjboabz9CW9Tu3ihQu+2sU=
Message-ID: <9e4733910604251910t37b3b78o774a1c2bc38e9c66@mail.gmail.com>
Date: Tue, 25 Apr 2006 22:10:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@linux.ie>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Matthew Reppert" <arashi@sacredchao.net>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0604260221560.31555@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145851361.3375.20.camel@minerva>
	 <20060423222122.498a3dd2.akpm@osdl.org>
	 <Pine.LNX.4.64.0604240652380.31142@skynet.skynet.ie>
	 <Pine.LNX.4.64.0604241002460.3701@g5.osdl.org>
	 <1145898993.3116.50.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0604241025120.3701@g5.osdl.org>
	 <Pine.LNX.4.64.0604260221560.31555@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Dave Airlie <airlied@linux.ie> wrote:
>
> >
> > Maybe just add a DRM command to do it, so that old X versions (who don't
> > know about it) will just do it by hand, and then new X versions can do
> >
> >       if (drm_ioctl(fd, DRM_SETUP_THE_DAMN_RESOURCES) < 0) {
> >               /*
> >                * I don't know what errno the drm-ioctl actually
> >                * returns for unrecognized commands, so this is
> >                * just an example
> >                */
> >               if (errno == ENOTTY) {
> >                       old kernel: do it by hand
> >               }
> >       }
> >
> > which allows us to go forward in a sane way, and finally leave the broken
> > X PCI-configuration-by-hand crap behind.
>
> It doesn't help of course, the fb drivers also pci_enable the devices,
> really X needs a kicking square, I'm trying to figure out some sort of fix
> here, but X does't some really stupid things with PCI resources...
>
> We really need a userspace way to pci_enable_device that X can call (via
> sysfs) so for cards that don't have a DRM or fb loaded we still get
> something..

You could make a null DRM driver that is loaded for every card that
doesn't have a real one. Give it aliases to make it match the X driver
names.

The right answer here is to start working towards a solution where the
OS is actually in control of hardware resources instead of a user app.
There can only be one entity in charge of PCI space or we will all go
insane. If we continue to say that old X binaries have to work we will
still have these same problems in 2060.


>
> Dave.
>
> --
> David Airlie, Software Engineer
> http://www.skynet.ie/~airlied / airlied at skynet.ie
> Linux kernel - DRI, VAX / pam_smb / ILUG
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Jon Smirl
jonsmirl@gmail.com
