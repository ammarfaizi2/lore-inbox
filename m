Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVCWXDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVCWXDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVCWXDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:03:44 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:38590 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261911AbVCWXDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:03:39 -0500
Subject: Re: [Pcihpd-discuss] RE: [RFC/Patch 0/12] ACPI based root bridge
	hot-add
From: Tom Duffy <tduffy@sun.com>
To: Dely Sy <dlsy@snoqualmie.dp.intel.com>
Cc: gregkh@suse.de, rajesh.shah@intel.com, akpm@osdl.org, dely.l.sy@intel.com,
       len.brown@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, tony.luck@intel.com,
       Prasad Singamsetty <Prasad.Singamsetty@sun.com>
In-Reply-To: <200503230313.j2N3DYpE010786@snoqualmie.dp.intel.com>
References: <200503230313.j2N3DYpE010786@snoqualmie.dp.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bCj8l4382JBvtxDsG8eI"
Date: Wed, 23 Mar 2005 15:03:16 -0800
Message-Id: <1111618996.12700.44.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bCj8l4382JBvtxDsG8eI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-22 at 19:13 -0800, Dely Sy wrote:
> I just did a test of Rajesh's latest patch on 2.6.11.5 with
> Wilcox's acpiphp rewrite and the following patch.  Hot-plug of=20
> PCI Express card worked fine on my i386 system

I have updated to Wilcox's rewrite, Rajesh's stuff, and Dely's latest
patch.  Still seeing these:

[root@intlhotp-1 4]# uname -a
Linux intlhotp-1 2.6.11andro #5 SMP Wed Mar 23 12:00:56 PST 2005 x86_64
x86_64 x86_64 GNU/Linux

[root@intlhotp-1 ~]# modprobe acpiphp
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp: Slot [4] registered
acpiphp: Slot [3] registered

[root@intlhotp-1 ~]# cd /sys/bus/pci/slots/4

[root@intlhotp-1 4]# echo 0 > power

This *does* take this slot off line.  Before, I see in lscpi
08:00.0 Ethernet controller: Intel Corp.: Unknown device 105f (rev 03)
08:00.1 Ethernet controller: Intel Corp.: Unknown device 105f (rev 03)
After, these are gone.

[root@intlhotp-1 4]# cat power
1

Hrm, this should be 0.

[root@intlhotp-1 4]# echo 1 > power
acpiphp_glue: No new device found

There is a card plugged into that slot.

Here is some info from the BIOS:

[root@intlhotp-1 4]# dmidecode
# dmidecode 2.2
SMBIOS 2.3 present.
91 structures occupying 3496 bytes.
Table at 0x000FCA80.
Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information
                Vendor: American Megatrends Inc.
                Version: SE7520AF20.86B.P.03.00.0085.092420041113
                Release Date: 09/24/2004

<snip>

Handle 0x0002
        DMI type 2, 15 bytes.
        Base Board Information
                Manufacturer: Intel
                Product Name: SE7520AF2HP
                Version: FRU Ver 0.3

<snip>

Handle 0x0034
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: Slot 4 (PCI_Express x8)
                Type: 64-bit PCI
                Current Usage: Available
                Length: Short
                ID: 3
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported

Any ideas?

Thanks,

-tduffy

--=-bCj8l4382JBvtxDsG8eI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQfW0dY502zjzwbwRArpRAKCaR1zB4yjOfWP1T5hSaxLfF5QgpwCgnjWi
hwOxbyxHfX1GFpb5u4EAlFE=
=XEj4
-----END PGP SIGNATURE-----

--=-bCj8l4382JBvtxDsG8eI--
