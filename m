Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271412AbUJVQMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271412AbUJVQMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271413AbUJVQMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:12:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271412AbUJVQMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:12:35 -0400
Date: Fri, 22 Oct 2004 12:12:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?ISO-8859-15?Q?Kristian_S=F8rensen?= <ipqw@users.sourceforge.net>
cc: Kasper Sandberg <lkml@metanurb.dk>,
       =?ISO-8859-15?Q?Kristian_S=F8re?= =?ISO-8859-15?Q?nsen?= 
	<ks@cs.aau.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>, umbrella@cs.aau.dk
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
In-Reply-To: <41792C36.4070301@users.sourceforge.net>
Message-ID: <Pine.LNX.4.61.0410221208230.17016@chaos.analogic.com>
References: <200410221613.35913.ks@cs.aau.dk> <1098455535.12574.1.camel@localhost>
 <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com>
 <41792C36.4070301@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-355138335-1098461533=:17016"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-355138335-1098461533=:17016
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Oct 2004, [ISO-8859-15] Kristian S=F8rensen wrote:

> Richard B. Johnson wrote:
>> On Fri, 22 Oct 2004, Kasper Sandberg wrote:
>>=20
>>> On Fri, 2004-10-22 at 16:13 +0200, Kristian S=F8rensen wrote:
>>>=20
>>>> Hi all!
>>>>=20
>>>> After some more testing after the previous post of the OOPS in
>>>> generic_delete_inode, we have now found a gigantic memory leak in Linu=
x=20
>>>> 2.6.
>>>> [789]. The scenario is the same:
>>>>=20
>>>> File system: EXT3
>>>> Unpack and delete linux-2.6.8.1.tar.bz2 with this Bash while loop:
>>>>=20
>>>> let "i =3D 0"
>>>> while [ "$i" -lt 10 ]; do
>>>>    tar jxf linux-2.6.8.1.tar.bz2;
>>>>    rm -fr linux-2.6.8.1;
>>>>    let "i =3D i + 1"
>>>> done
>>>>=20
>>>> When the loop has completed, the system use 124 MB memory more _each_=
=20
>>>> time....
>>>> so it is pretty easy to make a denial-of-service attack :-(
>>=20
>>=20
>>=20
>> Do something like this with your favorite kernel version.....
>>=20
>> while true ; do tar -xzf linux-2.6.9.tar.gz ; rm -rf linux-2.6.9 ; vmsta=
t ;=20
>> done
>>=20
>> You can watch this for as long as you want. If there is no other
>> activity, the values reported by vmstat remain, on the average, stable.
>> If you throw in a `sync` command, the values rapidly converge to
>> little memory usage as the disk-data gets flused to disk.
> The problem is, that the free memory reported by vmstat is decresing by 1=
24mb=20
> for each 10-iterations....
>
> The allocated memory does not get freed even if the system has been left=
=20
> alone for three hours!
>

Yes. So?  Why would it be freed? It's left how it was until it
is needed. Freeing it would waste CPU cycles.

This cannot be a problem unless you are inventing some sort
of hot-swap memory thing. If so, you need to make a module that
tells the kernel memory manager to free everything so you
can remove and replace the RAM.


>
> Cheers, Kristian.


>
> --=20
> Kristian S=F8rensen
> - The Umbrella Project
>  http://umbrella.sourceforge.net
>
> E-mail: ipqw@users.sf.net, Phone: +45 29723816
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
--1678434306-355138335-1098461533=:17016--
