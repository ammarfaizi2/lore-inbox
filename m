Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271329AbUJVPIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271329AbUJVPIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbUJVPIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:08:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271329AbUJVPH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:07:58 -0400
Date: Fri, 22 Oct 2004 11:07:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kasper Sandberg <lkml@metanurb.dk>
cc: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>, umbrella@cs.aau.dk
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
In-Reply-To: <1098455535.12574.1.camel@localhost>
Message-ID: <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com>
References: <200410221613.35913.ks@cs.aau.dk> <1098455535.12574.1.camel@localhost>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-903255274-1098457653=:12605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-903255274-1098457653=:12605
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Oct 2004, Kasper Sandberg wrote:

> On Fri, 2004-10-22 at 16:13 +0200, Kristian S=F8rensen wrote:
>> Hi all!
>>
>> After some more testing after the previous post of the OOPS in
>> generic_delete_inode, we have now found a gigantic memory leak in Linux =
2.6.
>> [789]. The scenario is the same:
>>
>> File system: EXT3
>> Unpack and delete linux-2.6.8.1.tar.bz2 with this Bash while loop:
>>
>> let "i =3D 0"
>> while [ "$i" -lt 10 ]; do
>>    tar jxf linux-2.6.8.1.tar.bz2;
>>    rm -fr linux-2.6.8.1;
>>    let "i =3D i + 1"
>> done
>>
>> When the loop has completed, the system use 124 MB memory more _each_ ti=
me....
>> so it is pretty easy to make a denial-of-service attack :-(


Do something like this with your favorite kernel version.....

while true ; do tar -xzf linux-2.6.9.tar.gz ; rm -rf linux-2.6.9 ; vmstat ;=
 done

You can watch this for as long as you want. If there is no other
activity, the values reported by vmstat remain, on the average, stable.
If you throw in a `sync` command, the values rapidly converge to
little memory usage as the disk-data gets flused to disk.


> well.. i could understand if it used the total size of a unpacked linux
> kernel, even after the loop stopped, since it would just keep it cached,
> however, it might not be that case when it adds 124mb each time...
>>
>> We have tried the same test on a RHEL WS 3 host (running a RedHat 2.4 ke=
rnel)
>> - and there is no problem.
>>
>>
>> Any deas?
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
--1678434306-903255274-1098457653=:12605--
