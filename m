Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTKNK3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 05:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTKNK3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 05:29:15 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:4257 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S262386AbTKNK3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 05:29:12 -0500
Date: Fri, 14 Nov 2003 11:29:06 +0100
From: Martin F Krafft <krafft@ailab.ch>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: phidgets@lists.ailab.ch
Subject: proposed fix to usb-core
Message-ID: <20031114102906.GA25345@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	phidgets@lists.ailab.ch
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
Organization: AILab, IFI, University of Zurich
X-OS: Debian GNU/Linux testing/unstable kernel 2.4.22-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We are currently fighting with a problem with the USB HID API, which
seems to prevent a user space application to write more than 32 bit
into a HID field.

We think that this problem can be solved with one of two little
changes to /drivers/usb/hid-core.c (2.4.22 tree):

Function hid_register_field at usb-core.c:96:
  static struct hid_field *hid_register_field(struct hid_report *report, un=
signed usages, unsigned values)

The function either needs to duplicate the struct hid_usage or grow
the size of the last struct hid_usage. The first option is the
easiest since it does not require a change of hiddev API. The later
option is probably more effective but requires to change the
HIDIOCSUSAGE ioctl so that it accepts a struct {void* data, int
data_size} instead of just int data.=20

I would be happy to submit a patch, but would like to hear first
which option is favourable. The first costs performance and memory,
the second an API change.

Or is there a specific reason why only 32 bits are writeable?

Thanks,

--=20
Martin F. Krafft                Artificial Intelligence Laboratory
Ph.D. Student                   Department of Information Technology
Email: krafft@ailab.ch          University of Zurich
Tel: +41.(0)1.63-54323          Andreasstrasse 15, Office 2.20
http://ailab.ch/people/krafft   CH-8050 Zurich, Switzerland
=20
Invalid/expired PGP subkeys? Use subkeys.pgp.net as keyserver!
=20
"if a man treats life artistically, his brain is his heart."
                                                        -- oscar wilde

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tK5yIgvIgzMMSnURAoNlAKDBB1c7YBXHcSDm6ehQ7iVFuvqXrACg2mLq
HagQx3Nl7R4iBsJbLb3Qcs8=
=ncaD
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
