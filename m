Return-Path: <linux-kernel-owner+w=401wt.eu-S932909AbWL0Efg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbWL0Efg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 23:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbWL0Efg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 23:35:36 -0500
Received: from thunk.org ([69.25.196.29]:37201 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932909AbWL0Eff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 23:35:35 -0500
Date: Tue, 26 Dec 2006 23:35:01 -0500
From: Theodore Tso <tytso@mit.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Karel Zak <kzak@redhat.com>,
       linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>
Subject: Re: util-linux: orphan
Message-ID: <20061227043501.GA7821@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Karel Zak <kzak@redhat.com>, linux-kernel@vger.kernel.org,
	Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>
References: <20061109224157.GH4324@petra.dvoda.cz> <20061218071737.GA5217@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de> <4591E3BB.9070806@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4591E3BB.9070806@zytor.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2006 at 07:08:43PM -0800, H. Peter Anvin wrote:
> >I saw that the current Fedora already dynamically links /bin/mount
> >against /usr/lib/libblkid.so. This obviously does not work if
> >/usr is a separate partition that needs to be mounted with /bin/mount.
> >I also had problems with selinux claiming I had no right to access
> >libblkid, which meant that the root fs could not be remounted r/w.
> >
> >I'd suggest that you make sure that mount always gets statically linked
> >against libblkid to avoid these problems.
> 
> That's a pretty silly statement.  The real issue is that any library 
> needed by binaries in /bin or /sbin should live in /lib, not /usr/lib.

>From a Debian unstable system:

think:~# ldd /bin/mount
        linux-gate.so.1 =>  (0xffffe000)
        libblkid.so.1 => /lib/libblkid.so.1 (0xb7f23000)
        libuuid.so.1 => /lib/libuuid.so.1 (0xb7f20000)
        libc.so.6 => /lib/libc.so.6 (0xb7ddf000)
        libdevmapper.so.1.02 => /lib/libdevmapper.so.1.02 (0xb7dcd000)
        libselinux.so.1 => /lib/libselinux.so.1 (0xb7db8000)
        libsepol.so.1 => /lib/libsepol.so.1 (0xb7d77000)
        libpthread.so.0 => /lib/libpthread.so.0 (0xb7d61000)
        /lib/ld-linux.so.2 (0xb7f3f000)
        libdl.so.2 => /lib/libdl.so.2 (0xb7d5d000)

... and in fact the e2fsprogs's configure program normally installs
the critical libraries used by mount, fsck, e2fsck, including the
blkid and uuid libraries, in /lib, not /usr/lib.  If blkid is being
installed in /usr/lib in Fedora, someone must have gone out of their
way to override e2fsprogs' defaults, which are designed to do the
right things by default.  (Basically, because I generally don't trust
the choices made by distributions' packaging engineers, having been
burned more than once.  :-)

							- Ted
