Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSG1Iq4>; Sun, 28 Jul 2002 04:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSG1Iq4>; Sun, 28 Jul 2002 04:46:56 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:36016 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314396AbSG1Iqz>;
	Sun, 28 Jul 2002 04:46:55 -0400
Date: Sun, 28 Jul 2002 10:50:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linuxconsole-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Event API changes - EVIOCGID
Message-ID: <20020728105002.A12585@ucw.cz>
References: <200207212050.56616.bhards@bigpond.net.au> <200207281745.37751.bhards@bigpond.net.au> <20020728102256.B12268@ucw.cz> <200207281842.18988.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207281842.18988.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Sun, Jul 28, 2002 at 06:42:18PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 06:42:18PM +1000, Brad Hards wrote:

> > > I am not happy about the change from uint16_t to __u16, which you appear
> > > to have made before sending this to Linus.
> > >
> > > That is a broken change - there is a standard type, and you've changed
> > > it to a non-standard type. This is confusing to userspace programmers,
> > > and I cannot provide a satisfactory explaination for this in
> > > documentation.
> > >
> > > Please change it back.
> >
> > Well, I know this has been discussed back and forth.
> And I was right last time too :-)
> 
> > __u16 is a kernel type and is defined if you #include <linux/input.h>.
> > uint16_t isn't.
> __u16 is no more a kernel type than uint16_t.
> It is a one line fix: include <linux/types.h> instead of <asm/types.h>
> Which you probably should be doing anyway, since there is no
> reason to rely on any assembler types in <linux/input.h>
> 
> > __u* is used extensively in the input API anyway, so you'd have to
> > explain it to userspace programmers nevertheless. So I prefer keeping
> > the input.h include use just one type of explicit sized types.
> So do I, and it had better be a standard type.
> 
> Note that the input API does *NOT* use __u* extensively. In fact
> if you take out the force feedback stuff (which Johannes already
> agreed to change:), this is the *only* _u* usage in any part of the 
> input API.
> 
> > Sure, we can change them all to uint*_t, but then do it all at once and
> > provide a satisfactory explanation for it. ;)
> I am doing it all. Johannes agreed to the change, and I did the only
> other required entry. If Johannes agrees, I'll do the trivial changes
> for force-feedback.

Please do then. Together with the change of <asm/types.h> to
<linux/types.h>.  I hope it doesn't conflict if the user also #includes
"stdint.h" in the userspace program, though.

> The reason why I am not doing it all at once is to provide patches
> that do one API change at a time. Or, depending on how you look
> at it, I did the only change all-at-once, and you reverted it :)

-- 
Vojtech Pavlik
SuSE Labs
