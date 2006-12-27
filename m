Return-Path: <linux-kernel-owner+w=401wt.eu-S932638AbWL0LYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWL0LYP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWL0LYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:24:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:15115 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbWL0LYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:24:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DL/dqOvOccDpu8i7Swg4IrwY5gUMc+SQ4yTaA79Jg4LjDdD+S8J+TGBsEgbwNMKhV4dUA4D2CmBaSw1CFGFPrl74mElL75FSuOnMFb2oWC3c1Ou8vVLwlLJodF+tAIHFnV6jTpews+xFW3BjJsZabBja63ltGHIXz38LXxAi5Dg=
Message-ID: <5a4c581d0612270324k20725779j86e9ee9b364e5b2b@mail.gmail.com>
Date: Wed, 27 Dec 2006 12:24:12 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
       "Arnd Bergmann" <arnd@arndb.de>, "Karel Zak" <kzak@redhat.com>,
       linux-kernel@vger.kernel.org, "Henne Vogelsang" <hvogel@suse.de>,
       "Olaf Hering" <olh@suse.de>
Subject: Re: util-linux: orphan
In-Reply-To: <20061227043501.GA7821@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061109224157.GH4324@petra.dvoda.cz>
	 <20061218071737.GA5217@petra.dvoda.cz>
	 <200612270346.10699.arnd@arndb.de> <4591E3BB.9070806@zytor.com>
	 <20061227043501.GA7821@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/06, Theodore Tso <tytso@mit.edu> wrote:
> On Tue, Dec 26, 2006 at 07:08:43PM -0800, H. Peter Anvin wrote:
> > >I saw that the current Fedora already dynamically links /bin/mount
> > >against /usr/lib/libblkid.so. This obviously does not work if
> > >/usr is a separate partition that needs to be mounted with /bin/mount.
> > >I also had problems with selinux claiming I had no right to access
> > >libblkid, which meant that the root fs could not be remounted r/w.
> > >
> > >I'd suggest that you make sure that mount always gets statically linked
> > >against libblkid to avoid these problems.
> >
> > That's a pretty silly statement.  The real issue is that any library
> > needed by binaries in /bin or /sbin should live in /lib, not /usr/lib.
>
> From a Debian unstable system:
>
> think:~# ldd /bin/mount
>         linux-gate.so.1 =>  (0xffffe000)
>         libblkid.so.1 => /lib/libblkid.so.1 (0xb7f23000)
>         libuuid.so.1 => /lib/libuuid.so.1 (0xb7f20000)
>         libc.so.6 => /lib/libc.so.6 (0xb7ddf000)
>         libdevmapper.so.1.02 => /lib/libdevmapper.so.1.02 (0xb7dcd000)
>         libselinux.so.1 => /lib/libselinux.so.1 (0xb7db8000)
>         libsepol.so.1 => /lib/libsepol.so.1 (0xb7d77000)
>         libpthread.so.0 => /lib/libpthread.so.0 (0xb7d61000)
>         /lib/ld-linux.so.2 (0xb7f3f000)
>         libdl.so.2 => /lib/libdl.so.2 (0xb7d5d000)
>
> ... and in fact the e2fsprogs's configure program normally installs
> the critical libraries used by mount, fsck, e2fsck, including the
> blkid and uuid libraries, in /lib, not /usr/lib.  If blkid is being
> installed in /usr/lib in Fedora, someone must have gone out of their
> way to override e2fsprogs' defaults, which are designed to do the
> right things by default.  (Basically, because I generally don't trust
> the choices made by distributions' packaging engineers, having been
> burned more than once.  :-)
>
>                                                         - Ted

FC6-current for i386 has it right:

[root@sandman ~]# rpm -qf /bin/mount
util-linux-2.13-0.45.3.fc6
[root@sandman ~]# ldd /bin/mount
        linux-gate.so.1 =>  (0xb7f63000)
        libblkid.so.1 => /lib/libblkid.so.1 (0x4b607000)
        libuuid.so.1 => /lib/libuuid.so.1 (0x4b601000)
        libselinux.so.1 => /lib/libselinux.so.1 (0x49ce5000)
        libc.so.6 => /lib/libc.so.6 (0x00aec000)
        libdevmapper.so.1.02 => /lib/libdevmapper.so.1.02 (0x49cfe000)
        libdl.so.2 => /lib/libdl.so.2 (0x00c54000)
        libsepol.so.1 => /lib/libsepol.so.1 (0x4a603000)
        /lib/ld-linux.so.2 (0x0011d000)

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
