Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVFIC2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVFIC2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 22:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVFIC2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 22:28:36 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:53173 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261604AbVFIC1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 22:27:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=ezWFkhQs4M25FpjKaxyUTTnKl8eFNExjgWLoSPxqAN75hVoOakAjk8c+Mka0vXro3HJd21ykNuEuDSW1HPCVAH5JvKhpncl4+niDoD0jimrZx6y1ONOZqtjRYvBF7Wy0Qu/KtsjHOTfIvg8SgnXSX9sdLuIUAm0gblpmkcUkqYw=
Message-ID: <b70d738005060819274653fd8@mail.gmail.com>
Date: Wed, 8 Jun 2005 19:27:41 -0700
From: Adam Morley <adam.morley@gmail.com>
Reply-To: Adam Morley <adam.morley@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b70d7380050608093138eb42df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11044_33501529.1118284061522"
References: <b70d73800506051924546c8931@mail.gmail.com>
	 <200506072252.40120.dtor_core@ameritech.net>
	 <b70d738005060721584aa25e71@mail.gmail.com>
	 <200506080117.20803.dtor_core@ameritech.net>
	 <b70d73800506080009c20eeff@mail.gmail.com>
	 <d120d50005060808273707bb8@mail.gmail.com>
	 <b70d7380050608093138eb42df@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_11044_33501529.1118284061522
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 6/8/05, Adam Morley <adam.morley@gmail.com> wrote:
> Hi Dimitry,
>=20
> On 6/8/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On 6/8/05, Adam Morley <adam.morley@gmail.com> wrote:
> > > Hi Dmitry,
> > >
> > > By Embedded Controller, do you mean CONFIG_ACPI_EC?  Because I can't
> > > disable it w/o disable a bunch of ACPI modules, I think.
> >
> > As far as I remember EC is only required for smart battery supports.
> > For testing purposes it is OK to not have it.
>=20
> It seems that even when I set it to "# CONFIG_ACPI_EC is not set", it
> gets re-enabled by make at some point.  I twiddled a couple of ACPI
> modules off (save button), and it was still re-enabled.  I think I'd
> have to disable ACPI.  I will play around with it some more though.

I'm still poking around trying to figure out how to disable
CONFIG_ACPI_EC.  Once I get that done, I will post results.  Yeah, I
can't get that to stay unset.  Every time I run make, I end up with it
set to Y, even if I've disabled it before.

>=20
> >
> > > I did enable all the PnP options:
> > >
> > > CONFIG_PNP=3Dy
> > > CONFIG_PNP_DEBUG=3Dy
> > > CONFIG_ISAPNP=3Dy
> > > CONFIG_PNPBIOS=3Dy
> > > CONFIG_PNPBIOS_PROC_FS=3Dy
> > > CONFIG_PNPACPI=3Dy
> > >
> >
> > If you boot this kernel please check attributes in
> > /sys/bus/pnp/devices/* after resuming and see if any marked
> > "disabled".
>=20
> Ok.  I will try this tonight, as I have to go to work.

In /sys/bus/pnp/drivers/i8042 aux/00:05, resources says "state =3D active"

in /sys/bus/pnp/devices/*, I have a bunch of directories.  See the
attached "output.txt" for the output of:

(pwd ; for file in * ; do echo $file ; cat $file/resources; echo "" ;
done) > /var/tmp/output.txt

(the same timeouts for AUX, irq 12 are still happening.  and the mouse
doesn't work)

--=20
adam

------=_Part_11044_33501529.1118284061522
Content-Type: text/plain; name=output.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="output.txt"

/sys/bus/pnp/devices
00:00
state = active
io 0x72-0x73
io 0x80-0x80
io 0x92-0x92
io 0xb0-0xb3
io 0xea-0xeb
io 0x40b-0x40b
io 0x480-0x48f
io 0x4d0-0x4d1

00:01
state = active
io 0x0-0xf
io 0x81-0x8f
io 0xc0-0xdf
dma 4

00:02
state = active
io 0xf0-0xfe
irq 13

00:03
state = active
io 0x70-0x71
irq 8

00:04
state = active
io 0x61-0x61

00:05
state = active
irq 12

00:06
state = active
io 0x60-0x60
io 0x64-0x64
irq 1

00:07
state = active


------=_Part_11044_33501529.1118284061522--
