Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWDETKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWDETKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 15:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDETKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 15:10:20 -0400
Received: from mx1.mail.ru ([194.67.23.121]:37429 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751255AbWDETKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 15:10:19 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: udev, PROGRAM and races...
Date: Wed, 5 Apr 2006 23:10:14 +0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, oblin@mandriva.com
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604052310.14967.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> This is done with rule like:
>
> SUBSYSTEM=="block", ACTION=="add", ENV{ID_CDROM}=="?*", \
> PROGRAM="/lib/udev/udev_cdrom_helper", SYMLINK+="%c"
>
> This helper tries to get the next free %d index to create cdrom%d, for
> example.
> The problem is that the launch of both helpers for hda and add seems to be
> done in parallel and the helper gets racy, so both cdroms get id 0, and the
> last that comes owns it:
>
> helper instance for hda        helper instance for hdd
> Does cdrom0 exist ? No
>                                Does cdrom0 exist ? No
> ln -sf hda cdrom0
>                                ln -sf hdd cdrom0
>
> ????
>

Do you have real example of race condition?

> Is there any way to serialize the calls to 'PROGRAM'. I tried something
> like:
>
> SUBSYSTEM=="block", ACTION=="add", ENV{ID_CDROM}=="?*",
> PROGRAM="/usr/bin/flock /sys/block /lib/udev/udev_cdrom_helper",
> SYMLINK+="%c"
>
> But looks a lot ugly.
>

Why? It is probably the simplest fix actually (assuming sysfs does support 
locking, I am not sure).

> Any standard way to do this ?

I never liked this automatic creation of symlinks, I believe this has to be 
done as part of device configuration (harddrake on distro you likely mean :)

> Can I still use %e, or is it really really deprecated ? this was easy:
>
> ENV{ID_CDROM_CD_RW}=="?*",  SYMLINK+="burner%e", MODE="0666",
> GROUP="cdwriter" ENV{ID_CDROM_DVD_R}=="?*",  SYMLINK+="burner%e",
> MODE="0666", GROUP="cdwriter"

Yes it is deprecated exactly for the same reason. What ensures uniqueness of 
%e?

regards

- -andrey

PS I believe it is more appropriate for distro-specific list actually.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFENBYWR6LMutpd94wRAk4qAJoDaSaLY4nDCgif0ybFdumc2Q7NzACgvo1n
U6fB7VUhQ70FG4nql8a6Nwk=
=fnir
-----END PGP SIGNATURE-----
