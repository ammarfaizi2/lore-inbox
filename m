Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVHGAWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVHGAWw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 20:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVHGAWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 20:22:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:22431 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261371AbVHGAWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 20:22:51 -0400
X-Authenticated: #3439220
From: Martin Maurer <martinmaurer@gmx.at>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Fw: Re: Elitegroup K7S5A + usb_storage problem
Date: Sun, 7 Aug 2005 02:22:53 +0200
User-Agent: KMail/1.7.2
Cc: Alan Stern <stern@rowland.harvard.edu>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050805151820.3f8f9e85.akpm@osdl.org> <Pine.LNX.4.44L0.0508061137180.1168-100000@netrider.rowland.org> <20050806130217.1748f7be.zaitcev@redhat.com>
In-Reply-To: <20050806130217.1748f7be.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1963661.ivNmttAE8j";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508070222.57340.martinmaurer@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1963661.ivNmttAE8j
Content-Type: multipart/mixed;
  boundary="Boundary-01=_eRV9ClpYYJLH4/x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_eRV9ClpYYJLH4/x
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Pete,

when using ub with your patch i get a lot further:
the device is detected and uba+uba1 entries appear.
I can mount the device correctly.
Copying the files down and comparing them with the originals gives correct=
=20
results.

but:
when i delete the files which are on the stick and do an umount/mount cycle=
,=20
the files are there again.=20
Copying files to the stick gives wrong results too.
Once the created file vanished after the remount,
and once it was there with a different name/size/date and garbage as conten=
t.

I didnt try ub without your patch (CONFIG_BLK_DEV_UB was disabled in my ker=
nel=20
configuration). Shall I try this too?

greetings
Martin


On Saturday, 6. August 2005 22:02, Pete Zaitcev wrote:
> On Sat, 6 Aug 2005 11:49:05 -0400 (EDT), Alan Stern=20
<stern@rowland.harvard.edu> wrote:
> > When asked what went wrong, the device says it didn't understand the
> > INQUIRY command.  This is a fatal error; if a device can't identify
> > itself there's no way for Linux to use it.
> >
> > In short, your mp3stick is worthless.  Trade it in for one that works.
>
> This is only true if usb-storage is used. The stick may work with ub.
>
> Martin, please apply the attached patch and enable CONFIG_BLK_DEV_UB.
> If you do not run a userland with udev, do this:
>
> mknod /dev/uba b 180 0
> mknod /dev/uba1 b 180 1
>
> Let me know how it went.
>
> -- Pete
>
> diff -urp -X dontdiff linux-2.6.12/drivers/usb/storage/usb.c
> linux-2.6.12-lem/drivers/usb/storage/usb.c ---
> linux-2.6.12/drivers/usb/storage/usb.c	2005-06-17 12:48:29.000000000 -0700
> +++ linux-2.6.12-lem/drivers/usb/storage/usb.c	2005-07-25
> 22:12:53.000000000 -0700 @@ -150,7 +150,9 @@ static struct usb_device_id
> storage_usb_
>  	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_BULK) },
>  	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_BULK) },
>  	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_BULK) },
> +#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
>  	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
> +#endif
>
>  	/* Terminating entry */
>  	{ }
> @@ -224,8 +226,10 @@ static struct us_unusual_dev us_unusual_
>  	  .useTransport =3D US_PR_BULK},
>  	{ .useProtocol =3D US_SC_8070,
>  	  .useTransport =3D US_PR_BULK},
> +#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
>  	{ .useProtocol =3D US_SC_SCSI,
>  	  .useTransport =3D US_PR_BULK},
> +#endif
>
>  	/* Terminating entry */
>  	{ NULL }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--Boundary-01=_eRV9ClpYYJLH4/x
Content-Type: text/plain;
  charset="iso-8859-1";
  name="mp3stick_working.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mp3stick_working.dmesg"

hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
hub 1-1:1.0: port 4, status 0101, change 0001, 12 Mb/s
hub 1-1:1.0: debounce: port 4: total 100ms stable 100ms status 0x101
usb 1-1.4: new full speed USB device using ohci_hcd and address 7
usb 1-1.4: ep0 maxpacket = 32
usb 1-1.4: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1.4: hotplug
usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
usb 1-1.4:1.0: hotplug
ub 1-1.4:1.0: usb_probe_interface
ub 1-1.4:1.0: usb_probe_interface - got id
ub(1.7): GetMaxLUN returned 0 bytes
ub(1.7): GetMaxLUN returned 0 bytes
ub(1.7): GetMaxLUN returned 0 bytes
 uba: uba1
hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010

--Boundary-01=_eRV9ClpYYJLH4/x--

--nextPart1963661.ivNmttAE8j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBC9VRhXHsqb5Up6wURAo3xAJjI4OVkeoLY7+ObD48cSzWIPqLcAJ9QWhn6
6gbNab9fpGK5sc7MgGq/Jg==
=rTLw
-----END PGP SIGNATURE-----

--nextPart1963661.ivNmttAE8j--
