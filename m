Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQKFQr5>; Mon, 6 Nov 2000 11:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbQKFQrs>; Mon, 6 Nov 2000 11:47:48 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:49547 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129077AbQKFQrf>; Mon, 6 Nov 2000 11:47:35 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Mon, 6 Nov 2000 16:42:12 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <00110615242102.01541@dax.joh.cam.ac.uk> <10109.973518003@redhat.com> <23007.973524894@redhat.com>
In-Reply-To: <23007.973524894@redhat.com>
MIME-Version: 1.0
Message-Id: <00110616471600.01646@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, David Woodhouse wrote:
> jas88@cam.ac.uk said:
> >  Irrelevant. The current mixer settings don't matter: what matters is
> > that the driver does not change them.
> 
> It does matter. The sound driver needs to be able to _read_ the current 
> levels.

So do so. That's a hardware/driver issue. If the hardware is broken, put
a workaround in the driver for that hardware (make the driver persistent,
as Horst suggested, perhaps). Don't kludge the kernel to mask hardware
bugs.

> Almost all mixer programs will start by doing this, to set the 
> slider to the correct place.

Yippee. As we all know, implementing GUI volume controls
and putting the slider in the right place is a kernel function,
and nothing to do with userspace...

If you want your volume control applet to be able to read the
current volume settings, even on buggy hardware which can't
really do that, put the kludge in userspace. Or if you really want,
put it in your driver for buggy hardware, in the way Horst suggested.

> > > The driver needs to reset the card to the desired levels. 
> 
> > What desired levels? The only desired levels are the current ones,
> > which the driver does not and (sometimes) cannot know. Leave well
> > alone.
> 
> It does not know them. Correct. But with persistent module storage, it 
> _could_ know them.

No it cannot. The desired levels have not been defined: there are no
desired levels to determine! Don't tamper with settings you don't need
to. 

> It cannot know them the _first_ time the module is 
> loaded after booting. That's fine. On subsequent loads, it can and 
> should DTRT.

The right thing in this context is not to screw with hardware settings
unless and until it is given settings to set. Do not set values arbitrarily:
set only the values you are explicitly given. Anything else is simply
a bug in your driver.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
