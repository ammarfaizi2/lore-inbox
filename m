Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVAZXnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVAZXnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVAZXla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:41:30 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:27759 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261368AbVAZSa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:30:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TlVO/gTSWlsGJo8urcHU5VlNX8frAmqhoNExoCtiE54y0dOVlNMS+MUyQ/1kLp5smWI1kgHcOTdPGybCzluv2fHEAotrzSC/S6GvpAlZNagzcEAWsXxvqdLYcCvsf+FXqA19bo0mgHQHLYbls0jIaJEMeeOm/09WB69XsQoh8Sw=
Message-ID: <d120d500050126103047aa6168@mail.gmail.com>
Date: Wed, 26 Jan 2005 13:30:28 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: linux-os@analogic.com
Subject: Re: i8042 access timings
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501261156330.18131@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501250241.14695.dtor_core@ameritech.net>
	 <20050126154307.GB4422@ucw.cz>
	 <d120d5000501260836686003d7@mail.gmail.com>
	 <Pine.LNX.4.61.0501261156330.18131@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 12:05:47 -0500 (EST), linux-os
<linux-os@analogic.com> wrote:
> On Wed, 26 Jan 2005, Dmitry Torokhov wrote:
> 
> > On Wed, 26 Jan 2005 16:43:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >> On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:
> >>> @@ -213,7 +217,10 @@
> >>>       if (!retval)
> >>>               for (i = 0; i < ((command >> 8) & 0xf); i++) {
> >>>                       if ((retval = i8042_wait_read())) break;
> >>> -                     if (i8042_read_status() & I8042_STR_AUXDATA)
> >>> +                     udelay(I8042_STR_DELAY);
> >>> +                     str = i8042_read_status();
> >> []
> >>> +                     udelay(I8042_DATA_DELAY);
> >>> +                     if (str & I8042_STR_AUXDATA)
> >>>                               param[i] = ~i8042_read_data();
> >>>                       else
> >>>                               param[i] = i8042_read_data();
> >>
> >> We may as well drop the negation. It's a bad way to signal the data came
> >> from the AUX port. Then we don't need the extra status read and can just
> >> proceed to read the data, since IMO we don't need to wait inbetween,
> >> even according to the IBM spec.
> >
> > Do you remember why it has been done to begin with?
> >
> > --
> > Dmitry
> 
> 
> The only time you need any delay at all is after you have send
...

Thank you Richard for this thorough explanation of IO access but I was
actually asking why we wanted to invert AUX data.

-- 
Dmitry
