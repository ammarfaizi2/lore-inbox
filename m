Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264398AbUD0XFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUD0XFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUD0XFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:05:36 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:3226 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S264398AbUD0XFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:05:21 -0400
Date: Tue, 27 Apr 2004 16:05:20 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] Implementation inconsistencies in 2.6.3
Message-ID: <20040427230520.GB2662@one-eyed-alien.net>
Mail-Followup-To: Ken Ashcraft <ken@coverity.com>,
	linux-kernel@vger.kernel.org
References: <4448.171.64.70.113.1083102442.spork@webmail.coverity.com> <20040427221446.GA2662@one-eyed-alien.net> <4609.171.64.70.113.1083106713.spork@webmail.coverity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <4609.171.64.70.113.1083106713.spork@webmail.coverity.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2004 at 03:58:33PM -0700, Ken Ashcraft wrote:
> > On Tue, Apr 27, 2004 at 02:47:22PM -0700, Ken Ashcraft wrote:
> >
> >> ---------------------------------------------------------
> >> [BUG] (mdharm-usb@one-eyed-alien.net) looks like it should return count
> >> instead of strlen(buf), but this is in scsiglue.c, so is it special
> >> code?
> >>
> >> example:
> >> /home/kash/linux/2.6.3/linux-2.6.3/drivers/scsi/scsi_sysfs.c:274:store=
_rescan_field:
> >> NOTE:READ: Checking arg count [EXAMPLE=3Ddevice_attribute.store-2]
> >>
> >> /home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/storage/scsiglue.c:321:=
store_max_sectors:
> >> ERROR:READ: Not checking arg [COUNTER=3Ddevice_attribute.store-2]  [fi=
t=3D1]
> >> [fit_fn=3D1] [fn_ex=3D0] [fn_counter=3D1] [ex=3D233] [counter=3D1] [z >
> >> 3.20943839741638] [fn-z =3D -4.35889894354067]
> >>
> >> 	return sprintf(buf, "%u\n", sdev->request_queue->max_sectors);
> >> }
> >>
> >> /* Input routine for the sysfs max_sectors file */
> >>
> >> Error --->
> >> static ssize_t store_max_sectors(struct device *dev, const char *buf,
> >> 		size_t count)
> >> {
> >> 	struct scsi_device *sdev =3D to_scsi_device(dev);
> >
> > My understanding was that I was supposed to return the number of bytes =
in
> > the buffer that I actually used.  I thought 'count' was the maximum siz=
e I
> > could use.
> >
>=20
> That sounds feasible.  I can't find any documentation on the interface, so
> I can't tell.  However, there are ~233 functions that at least reference
> count.  Many of them are almost identical: they call sscanf or strtol to
> get a length out of buf, pass that length to some subroutine, and then
> unconditionally return count.  This is a more representative example than
> the one listed above.
>=20
> static ssize_t set_pwm_enable1(struct device *dev, const char *buf,
>                                 size_t count)
> {
>         struct i2c_client *client =3D to_i2c_client(dev);
>         struct asb100_data *data =3D i2c_get_clientdata(client);
>         unsigned long val =3D simple_strtoul(buf, NULL, 10);
>         data->pwm &=3D 0x0f; /* keep the duty cycle bits */
>         data->pwm |=3D (val ? 0x80 : 0x00);
>         asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
>         return count;
> }

It seems pretty shady to me to have a function which is passed a value, the
entire purpose of which is to return it to the caller unchanged.

Perhaps someone on l-k can comment...

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Hey Chief.  We've figured out how to save the technical department.  We=20
need to be committed.
					-- The Techs
User Friendly, 1/22/1998

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAjucwIjReC7bSPZARAkg7AKCPbY2eQdH6soD79O1CYHn89HntagCfennf
0uT26Fo4wcAMnhK1YMw1+8g=
=xqJ4
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
