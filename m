Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268222AbUHXA5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbUHXA5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUHXAzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:55:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16789 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267165AbUHXAxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 20:53:22 -0400
Message-Id: <200408240052.i7O0qscO007552@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Greg KH <greg@kroah.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][7/7] add xattr support to ramfs 
In-Reply-To: Your message of "Mon, 23 Aug 2004 13:59:43 PDT."
             <20040823205942.GA3370@kroah.com> 
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com> <20040823212623.A20995@infradead.org> <1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>
            <20040823205942.GA3370@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1096192960P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Aug 2004 20:52:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1096192960P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <8638.1093308734.1@turing-police.cc.vt.edu>

On Mon, 23 Aug 2004 13:59:43 PDT, Greg KH said:

> What's wrong with using a tmpfs for udev in such situations that xattrs
> are needed?  udev does not require ramfs at all.  In fact, why not just
> use a ext2 or ext3 partition for /dev instead today, if you really need
> it?

Somehow, 'mount /dev/some-ext3-partition /dev' strikes me as having an innate
bootstrapping issue :) (Yes, I know there's initial setup magic needed in an
initrd to get a *working* udev up and running on a /dev on tmpfs).

The underlying end goal is to allow a configuration such as "/dev on a
tmpfs and not break with SELinux or other xattr-using system".  This
has several wins:

1) You can mount / with 'nodev' (currently, / is the only partition on this
machine *not* mounted with 'nodev')..

2) /dev loses all the "legacy" entries your particular box doesn't need:
# find /dev -type b -o -type c | wc -l
19200
# find /udev -type b -o -type c | wc -l
211
(On a laptop running Fedora Core)

3) As mentioned, less bootstrapping issues for initrd systems that may need
a /dev in order to get to a partition (LVM/raid/etc)

4) Having udev-on-tmpfs work even under SELinux would be just one more
thing to use against any remaining devfs infidels. ;)

(And yes, the lack of xattr support is the only reason I'm not already using
udev-on-tmpfs for a /dev)....

--==_Exmh_1096192960P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBKpFmcC3lWbTT17ARAv/dAJsHhYyBo/hZ4eIvdzmaHIdQQyeFcgCfUfyN
6zHhJJ3uI7lOEiCoYullrUE=
=SZsc
-----END PGP SIGNATURE-----

--==_Exmh_1096192960P--
