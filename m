Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVA0KhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVA0KhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVA0KhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:37:03 -0500
Received: from ns.suse.de ([195.135.220.2]:61912 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262559AbVA0KSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:18:54 -0500
Date: Thu, 27 Jan 2005 11:19:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050127101903.GB2702@ucw.cz>
References: <200501250241.14695.dtor_core@ameritech.net> <20050126154307.GB4422@ucw.cz> <d120d5000501260836686003d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000501260836686003d7@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 11:36:41AM -0500, Dmitry Torokhov wrote:
> On Wed, 26 Jan 2005 16:43:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:
> > > @@ -213,7 +217,10 @@
> > >       if (!retval)
> > >               for (i = 0; i < ((command >> 8) & 0xf); i++) {
> > >                       if ((retval = i8042_wait_read())) break;
> > > -                     if (i8042_read_status() & I8042_STR_AUXDATA)
> > > +                     udelay(I8042_STR_DELAY);
> > > +                     str = i8042_read_status();
> > []
> > > +                     udelay(I8042_DATA_DELAY);
> > > +                     if (str & I8042_STR_AUXDATA)
> > >                               param[i] = ~i8042_read_data();
> > >                       else
> > >                               param[i] = i8042_read_data();
> > 
> > We may as well drop the negation. It's a bad way to signal the data came
> > from the AUX port. Then we don't need the extra status read and can just
> > proceed to read the data, since IMO we don't need to wait inbetween,
> > even according to the IBM spec.
> 
> Do you remember why it has been done to begin with?
 
Yes. It's only for the detection of the AUX port. I wanted to know
whether the byte we receive in the AUX_LOOP command really comes back
through the AUX interface and not through the KBD interface. Since there
isn't any other information path for signalling which interface
i8042_command() received the byte through, I just negated the value
there.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
