Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTFCULu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTFCULu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:11:50 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:41483 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S264083AbTFCULr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:11:47 -0400
Date: Tue, 3 Jun 2003 13:25:04 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jocelyn Mayer <jma@netgem.com>
Cc: Ben Collins <bcollins@debian.org>, Georg Nikodym <georgn@somanetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
Message-ID: <20030603132504.C21083@one-eyed-alien.net>
Mail-Followup-To: Jocelyn Mayer <jma@netgem.com>,
	Ben Collins <bcollins@debian.org>,
	Georg Nikodym <georgn@somanetworks.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com> <20030602163443.2bd531fb.georgn@somanetworks.com> <1054588832.4967.77.camel@jma1.dev.netgem.com> <20030603113636.GX10102@phunnypharm.org> <1054663917.4967.99.camel@jma1.dev.netgem.com> <20030603185421.GB10102@phunnypharm.org> <1054671619.4951.139.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1054671619.4951.139.camel@jma1.dev.netgem.com>; from jma@netgem.com on Tue, Jun 03, 2003 at 10:20:19PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I know jumping in the middle of a conversation is bad, but....

In conversations with the SBP2 folks, they indicated to me that the way
they do hotplugging is very different from the way usb-storage does it.
The end result (I'm told) is that invoking a scan from userspace is often
needed for SBP2 but never for usb-storage.

So, comparing the two is really pointless.

Matt

On Tue, Jun 03, 2003 at 10:20:19PM +0200, Jocelyn Mayer wrote:
> On Tue, 2003-06-03 at 20:54, Ben Collins wrote:
> > > First, I never trust hotplug or other tools like this:
> > > I do all insmod by hand, so I know all drivers have been loaded.
> > > What is hotplug supposed to do (but wasn't in previous driver
> > > version...) ?
> >=20
> > I didn't say CONFIG_HOTPLUG, I said hotplug. Basically SCSI in 2.4 will
> > not let recognize devices that were not present when the scsi-host was
> > initially registered with the SCSI stack. You have to run
> > rescan-scsi-bus.sh (or manually send the add/remove commands via
> > procfs).
> >=20
> > Please read the linux-kernel and/or linux1394-devel mailing list
> > archives. I really hate dredging this all up again.
>=20
> Well, I did understand well hotplug...
> I did read what's said about SBP2 on linux1394.org, BUT:
>=20
> please read my latest mail, I did some try with the 2.4.21-rc1 ieee1394
> stack, without /sbin/hotplug, and it worked.
> I have neither rescan-scsi-bus.sh, nor scsiadd anywhere on this machine.
> So, I'm sure that no user-space tool have been called by the kernel.
>=20
> - I NEVER need to do an "echo ... > /proc/scsi/scsi" to see the device
>   (I tell again that I never use automatic tools to do this kind of
>    low level stuffs).
> - I NEVER have to do this to see an USB mass-storage device:
>   I'm *REALLY* sure of this, as I wrote a very simple hotplug
>   and automounter for some embedded hardware which uses USB mass
>   storage devices. So, I don't see why SBP2 should need this...
>=20
> - Please take a look at this session:
> First, I reboot the Ibook:
>=20
> root:~$ reboot
> root:~$=20
> Broadcast message from root (pts/0) (Tue Jun  3 22:06:13 2003):
>=20
> The system is going down for reboot NOW!
> Connection to mac closed by remote host.
> Connection to mac closed.
> jma ~ > ssh jocelyn@mac
> jocelyn@mac's password:=20
> jocelyn:~$ su -
> Password:=20
> root:~$ ls -l /bin/hotplug
> ls: /bin/hotplug: No such file or directory
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ cat
> /proc/sys/kernel/hotplug=20
> /sbin/hotplug
> root:~$ cd /lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394/
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
> ./ieee1394.o
> =20
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
> ./cmp.o=20
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ cat
> /proc/scsi/scsi
> =20
> Attached devices:=20
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
> ./ohci1394.o
> =20
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
> ./amdtp.o=20
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
> ../scsi/sd_m
> od.o=20
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
> ./sbp2.o=20
> root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ cat
> /proc/scsi/scsi
> =20
> Attached devices:=20
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: Maxtor 6 Model: Y080L0           Rev: YAR4
>   Type:   Direct-Access                    ANSI SCSI revision: 06
>=20
>=20
> So I NEVER write anything to /proc/scsi/scsi,
> I got NO /sbin/hotplug, I use only insmod,
> so I can have no side-effect due to modprobe usage,
> and it works PERFECTLY on the Ibook,=20
> using the 2.4.21-rc1 ieee1394 stack.
>=20
> So, I'm sorry, but I keep thinking the new driver is buggy:
> what used to work and doesn't...
>=20
>=20
> Regards.
>=20
> --=20
> Jocelyn Mayer <jma@netgem.com>
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Would you mind not using our Web server? We're trying to have a game of=20
Quake here.
					-- Greg
User Friendly, 5/11/1998

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+3QQgIjReC7bSPZARAq4ZAJ9U08BseaUpuaEXAMJJHJW89/YYogCgwQeR
6sHMoBXs/3OEvT/iWAW73Ws=
=UmPE
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
