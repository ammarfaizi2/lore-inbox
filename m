Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313911AbSDJWUX>; Wed, 10 Apr 2002 18:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313914AbSDJWUW>; Wed, 10 Apr 2002 18:20:22 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:41670 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313911AbSDJWUV>; Wed, 10 Apr 2002 18:20:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.8-pre3: kernel BUG at usb.c:849! (preempt_count 1)
Date: Thu, 11 Apr 2002 00:20:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net,
        linux-usb-devel@lists.sourceforge.net,
        Johannes Erdfelt <johannes@erdfelt.com>
In-Reply-To: <E16vHsQ-0000Jy-00@baldrick> <E16vLJx-00028n-00@baldrick> <071e01c1e0b4$64f382e0$6800000a@brownell.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16vQRn-0000DD-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 7:23 pm, David Brownell wrote:
> > > And what usb device driver(s) were supposed to have stopped
> > > using "device 3"?  I've only noticed such device refcounting bugs
> > > being caused by the USB device drivers with bad disconnect()
> > > routines, not usbcore or any of the host controller drivers, but of
> > > course that can change.
> >
> > Ha!
> >
> > $ cat /proc/bus/usb/drivers
> >          usbfs
> >          hub
> >
> > There are no other drivers!  I have a USB webcam and a modem
> > ... has a user space driver that works via usbfs.
>
> ... OK, this is sounding familiar.  "usbfs" has some recently noted
> bugs in its disconnect() routine.  That SpeedTouch driver seems to
> be triggering them with regularity, though more often with usb-ohci.
>
> The ksymoops info you sent is compatible with the bug being in
> the usbfs code:  exactly what I'd expect such a BUG() to show.
>
> I hate to send around untested patches, but I think the one I've
> attached is at least in the right direction.  (Attachment, to avoid
> mangling by mailers...)  It's an update of what I sent around late
> last month to address someone's SpeedTouch oopsing with
> usb-ohci (!) on 2.4.19-pre2, redone against 2.5.8-pre3, which
> compiles.  I hope it doesn't create new oopses.
>
> If it works for you, let us know ...
>
> - Dave

It seems to work - thanks!  I will test more, but so far so good.
System shutdown still completes with "preempt_count = 1"
though.

All the best,

Duncan.

