Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLASav>; Fri, 1 Dec 2000 13:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbQLASal>; Fri, 1 Dec 2000 13:30:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129511AbQLASaa>; Fri, 1 Dec 2000 13:30:30 -0500
Date: Fri, 1 Dec 2000 12:59:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Olivier Galibert <galibert@pobox.com>
cc: Tigran Aivazian <tigran@veritas.com>, Alexander Viro <viro@math.psu.edu>,
        Hugh Dickins <hugh@veritas.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <20001201121248.A13401@zalem.puupuu.org>
Message-ID: <Pine.LNX.3.95.1001201124851.3833A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000, Olivier Galibert wrote:

> On Wed, Nov 29, 2000 at 04:40:29PM +0000, Tigran Aivazian wrote:
> > b) what should be the return of access(W_OK) (or, the same, open() for 
> > write with switched uid) for devices on a readonly-mounted filesystems?
> > 
> > Should the majority win? I.e. should we say OK, as we do now?
> 
> My gut feeling on this is that when you mount a filesystem readonly
> you mean "I don't want the filesystem to be modifiable".  Opening a
> device for write never modifies the filesystem directly.  Devices are
> gateways to resources external to the filesystem, the write permission
> means something different for them.
> 
> Same is for sockets/pipes btw.
> 
> And I really wonder how you plan to fsck / if it has been uncleanly
> unmounted and includes /dev.
> 
>   OG.
> -

There is a mount option to disallow access to special files, i.e.,
devices; MS_NODEV. A read-only file-system defaults to allowing
access to device special files because it has to. Your console,
your virtual terminal, /dev/tty, the root file-system raw device,
etc., all have to be 'writable' before the root file-system is remounted
read/write.

/dev/special files, are not really 'files'. They are a trick to
associate a major/minor number with a file descriptor. They
cannot be 'extended' or modified because you are not writing to
them, hense `fsck` isn't a problem. The access time and ownership
may have been modified, but that is synchronous.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
