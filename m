Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132312AbRADBYO>; Wed, 3 Jan 2001 20:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132349AbRADBYC>; Wed, 3 Jan 2001 20:24:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:15631 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132353AbRADBXp>;
	Wed, 3 Jan 2001 20:23:45 -0500
Date: Wed, 03 Jan 2001 16:12:46 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: usb dc2xx quirk
To: Randy Dunlap <randy.dunlap@intel.com>, josh <skulcap@mammoth.org>
Cc: linux-kernel@vger.kernel.org,
        l-u-d <linux-usb-devel@lists.sourceforge.net>
Message-id: <043101c075e3$118db720$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <Pine.LNX.4.20.0101031155240.2682-100000@www>
 <3A537C2A.A17DCB94@intel.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this makes it go away, then by all means apply this patch;
though I don't quite see what the failure mode would be.

The proximate cause of that Oops looked to be in one of the
UHCI drivers, but of course it's also possible that it was
triggered by driver misbehavior.

Have we identified anything that actually does anything with
code labeled __dev{in,ex}it (or data), beyond putting it into
a different section?  If so, what's it doing?

I just tried plug/unplug of a dc-240, albeit on a kernel
with HOTPLUG defined (and using OHCI) and it worked without
any Oops.

- Dave


----- Original Message -----
From: Randy Dunlap <randy.dunlap@intel.com>
To: josh <skulcap@mammoth.org>
Cc: <linux-kernel@vger.kernel.org>; <david-b@pacbell.net>; l-u-d
<linux-usb-devel@lists.sourceforge.net>
Sent: Wednesday, January 03, 2001 11:23 AM
Subject: Re: usb dc2xx quirk


> Hi,
>
> Looks like dc2xx.c shouldn't use __devinit/__devexit
> [patch attached]
> or you should enable CONFIG_HOTPLUG under General Setup.
>
> David?
>
> The ov511 (usb) driver is the only other USB device driver
> that uses __devinit/__devexit.
>
> ~Randy
>
> josh wrote:
> >
> > Kernel Version: 2.4.0-test11 - 2.4.0-prerelease
> > Platform: ix86 (PIII)
> > Problem Hardware: Kodac DC280, firmware 1.01
> >
> > Ever since test10 or after, removing my dc280 from the usb
> > bus causes khubd to crash.  I have tried both UHCI drivers
> > and they produce the same effect.
> >
> > dmesg, syslog, messages, and .config can be found at:
> > http://mammoth.org/~skulcap/usb-problem
> >
> > I have looked throug the archives and havent found anything
> > like this, so I'm sorry if it has been covered already.
> >
> > Thanks in advance!
> --
> _______________________________________________
> |randy.dunlap_at_intel.com        503-677-5408|
> |NOTE: Any views presented here are mine alone|
> |& may not represent the views of my employer.|
> -----------------------------------------------


--------------------------------------------------------------------------------


> --- linux/drivers/usb/dc2xx.c.org Sun Nov 12 20:40:42 2000
> +++ linux/drivers/usb/dc2xx.c Wed Jan  3 11:15:11 2001
> @@ -353,7 +353,7 @@
>
>
>
> -static void * __devinit
> +static void *
>  camera_probe (struct usb_device *dev, unsigned int ifnum, const struct usb_device_id
*camera_info)
>  {
>   int i;
> @@ -451,7 +451,7 @@
>   return camera;
>  }
>
> -static void __devexit camera_disconnect(struct usb_device *dev, void *ptr)
> +static void camera_disconnect(struct usb_device *dev, void *ptr)
>  {
>   struct camera_state *camera = (struct camera_state *) ptr;
>   int subminor = camera->subminor;
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
