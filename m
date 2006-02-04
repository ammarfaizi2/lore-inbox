Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWBDScb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWBDScb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 13:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWBDScb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 13:32:31 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:2872 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932544AbWBDSca convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 13:32:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VnniuqxkS/ITnaL5gptMOqvTekndL6mEacCgtQbQIYUXijfMGPIAyrh0oDDhcNc5pJ1pZ26QGbhyzlqa1bhXUwgrL+RMIXmnpuTuLANf/MoWGmuiBkHMyKJBXayusNUuQCfNPUkLIaVBrZP8UKxU2O65dECe/JFHl8HPEDxUaac=
Message-ID: <7f45d9390602041032r227360b7me475056fc9a5ab63@mail.gmail.com>
Date: Sat, 4 Feb 2006 11:32:28 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] liyitec: Liyitec PS/2 touchscreen driver
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060204070519.GA5866@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390602021502q325752d7oe635569cde7ce2c7@mail.gmail.com>
	 <d120d5000602021512x42be2006h31e63cb6d78ac1b3@mail.gmail.com>
	 <7f45d9390602031639k3c5ae010gbd52a8fdd8bb863b@mail.gmail.com>
	 <20060204070519.GA5866@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Feb 03, 2006 at 05:39:30PM -0700, Shaun Jackman wrote:
> > So, finally, assuming there is no way to detect the touch panel's
> > presence, should the driver still be rolled into psmouse? If so, how
> > should the user specify she wishes to use the liyitec driver, and
> > which serio (PS/2) port the liyitec touch screen is on?
> >
> > My current patch implements the Liyitec driver as a serio driver that
> > grabs every available PS/2 port. Quite unfriendly, but works in the
> > typical case where the keyboard driver grabs the first port, and the
> > Liyitec driver grabs the psaux port.
>
> I hope the driver at least checks that the port is untranslated
> (SERIO_I8042, not SERIO_I8042_XL), and that the device behaves as a
> mouse.

I'm unable to find any reference to SERIO_I8042_XL.
$ cat .git/HEAD
d39569232e883a1475b39576b96cfb400c33e816
$ grep -r I8042_XL .
$

The driver does not check that the device behaves as a normal mouse.
It would be relatively straight forward to implement this feature, but
since psmouse already does this, this behaviour would be a major
benefit to moving the Liyitec driver into psmouse.

> Btw, I assume the packet format is also indistinguishable from a
> standard PS/2 mouse?

The Liyitec packet is always a legal PS/2 packet. However, the
overflow bits are used as the tenth bits of precision of the absolute
X and Y coordinates, and so are set far more often than on a normal
PS/2 mouse, assuming the user touches the bottom right corner of the
screen.

> If it were integrated into psmouse, it probably need to be enabled by a
> module parameter.

Okay. I'll do that then. How is the module parameter specified for a
driver that's compiled into the kernel?

Cheers,
Shaun
