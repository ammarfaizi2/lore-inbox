Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130215AbRACO0y>; Wed, 3 Jan 2001 09:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130440AbRACO0o>; Wed, 3 Jan 2001 09:26:44 -0500
Received: from latt.if.usp.br ([143.107.129.103]:26125 "HELO latt.if.usp.br")
	by vger.kernel.org with SMTP id <S130215AbRACO0f>;
	Wed, 3 Jan 2001 09:26:35 -0500
Date: Wed, 3 Jan 2001 11:56:07 -0200 (BRST)
From: "Jorge L. deLyra" <delyra@latt.if.usp.br>
To: Andi Kleen <ak@suse.de>
cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
In-Reply-To: <20010103140116.A32638@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.3.96.1010103114120.21947A-100000@latt.if.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You probably had a inode namespace collision. unfsd encodes the dev_t in
> the upper in ext2 unused bits of the inode to be able to export multiple
> file systems in a single export (knfsd dropped that broken feature)

Well, not completely. There is now this option "nohide" on /etc/exports
which does this. Another useful thing we use a lot here. With knfsd you
still have to authorize (export) separately each local mount point (unfsd
used to automatically authorize all the underlying tree), but with this
option you can mount just once and go down into directories which are on
different filesystems on the server. A very useful feature, specially
while autofs is not able to do cascaded mounts. We use this for some
sysadmin tasks on clients, which export their root to their server.

I recognize the need for a robust NFS structure on Linux and understand
that some restrictions on features might be needed for that. But all these
features are quite nice and useful, so I hope ways are found to implement
them in robust ways.
							Regards,

----------------------------------------------------------------
        Jorge L. deLyra,  Associate Professor of Physics
            The University of Sao Paulo,  IFUSP-DFMA
       For more information: finger delyra@latt.if.usp.br
----------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
