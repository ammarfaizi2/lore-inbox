Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbTDNVzb (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTDNVzb (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:55:31 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:54161 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263984AbTDNVz3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:55:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] /sbin/hotplug multiplexor
Date: Tue, 15 Apr 2003 00:04:04 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304150004.19213.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Oliver Neukum wrote:

> Well, for a little elegance you might introduce subdirectories for each type
> of hotplug event and use only them.

I was just about to propose the same. Please use subdirs or namespaced files
like in:

for I in "${DIR}/$1".* "${DIR}/"default.* ; do
	test -x $I && $I $1
done

Note that a single event can not only cause one hotplug event for many devices
but also _multiple_ events for every device. E.g. enabling a dasd devices
will cause hotplug to be called for the local subchannel devices as well as
the actual (remote) disk. Maybe someone adds hotplug calls for partitions
and logical volumes.
Since dasds are usually not larger than 2GB, you are quite likely
to enable many at the same time. Imagine you get 500 disks * 4 events * 10
agents in response to a single user command...

	Arnd <><
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mzBY5t5GS2LDRf4RAiGEAKCDfJCOqc+IwyzN1cFOOiFKuwqfFwCbBiEe
zaWlQP9P0s09DUNoF/xfdLs=
=c6xb
-----END PGP SIGNATURE-----

