Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSG1ITy>; Sun, 28 Jul 2002 04:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSG1ITy>; Sun, 28 Jul 2002 04:19:54 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:57519 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314602AbSG1ITx>;
	Sun, 28 Jul 2002 04:19:53 -0400
Date: Sun, 28 Jul 2002 10:22:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linuxconsole-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Event API changes - EVIOCGID
Message-ID: <20020728102256.B12268@ucw.cz>
References: <200207212050.56616.bhards@bigpond.net.au> <20020722180431.A18282@ucw.cz> <200207281745.37751.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207281745.37751.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Sun, Jul 28, 2002 at 05:45:37PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:45:37PM +1000, Brad Hards wrote:
> On Tue, 23 Jul 2002 02:04, Vojtech Pavlik wrote:
> > On Sun, Jul 21, 2002 at 08:50:56PM +1000, Brad Hards wrote:
> > > G'day,
> > >
> > > The attached patch basically implements:
> > > +struct input_devinfo {
> > > +       uint16_t bustype;
> > > +       uint16_t vendor;
> > > +       uint16_t product;
> > > +       uint16_t version;
> > > +};
> > > +
> > >
> > > -#define EVIOCGID               _IOR('E', 0x02, short[4])              
> > > /* get device ID */ +#define EVIOCGID               _IOR('E', 0x02,
> > > struct input_devinfo)   /* get device ID */
> > >
> > > It affects just about every input driver, as a result of some associated
> > > cleanups that I applied, and its about 40K uncompressed - hence the gzip.
> > >
> > > Is there anything that would stop this being applied?
> >
> > No, the patch is OK.
> I am not happy about the change from uint16_t to __u16, which you appear
> to have made before sending this to Linus.
> 
> That is a broken change - there is a standard type, and you've changed
> it to a non-standard type. This is confusing to userspace programmers, and
> I cannot provide a satisfactory explaination for this in documentation.
> 
> Please change it back.

Well, I know this has been discussed back and forth.

__u16 is a kernel type and is defined if you #include <linux/input.h>.
uint16_t isn't.

__u* is used extensively in the input API anyway, so you'd have to
explain it to userspace programmers nevertheless. So I prefer keeping
the input.h include use just one type of explicit sized types.

Sure, we can change them all to uint*_t, but then do it all at once and
provide a satisfactory explanation for it. ;)

-- 
Vojtech Pavlik
SuSE Labs
