Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319171AbSIDOSx>; Wed, 4 Sep 2002 10:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319172AbSIDOSx>; Wed, 4 Sep 2002 10:18:53 -0400
Received: from mta.sara.nl ([145.100.16.144]:60116 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S319171AbSIDOSv>;
	Wed, 4 Sep 2002 10:18:51 -0400
Date: Wed, 4 Sep 2002 16:23:04 +0200
Subject: Re: writing OOPS/panic info to nvram?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: morten.helgesen@nextframe.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
To: "J.A. Magallon" <jamagallon@able.es>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <20020904140856.GA1949@werewolf.able.es>
Message-Id: <D365BFFC-C011-11D6-A20D-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On woensdag, september 4, 2002, at 04:08 , J.A. Magallon wrote:

>
> On 2002.09.04 Remco Post wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> On woensdag, september 4, 2002, at 02:54 , Morten Helgesen wrote:
>>
>>> On Wed, Sep 04, 2002 at 01:49:12PM +0100, Alan Cox wrote:
>>>> On Wed, 2002-09-04 at 13:31, Morten Helgesen wrote:
>>>>> True - the 'normal' size on a PC is apparently something like 114
>>>>> bytes ...
>>>>> I  guess we could use it for something useful ... but maybe not for
>>>>> OOPSen/panics.
>>>>>
>>>>> I didn`t realize we only had 114 bytes to work with.
>>>>
>>>> We don't. They are all used by the BIOS
>>>
>>> That makes it even less useful. Oh well.
>>>
>>
>> For PC style hardware it does. For other platforms, it's stil nice to 
>> be
>> able to see the oops info on an unattended crash (all crashes? ;) Dump
>> to nvram, dump to file after boot.... Other option is to crash-dump to
>> swap... Question is, do you really want to do that?
>>
>
> Instead of swap, let user specify a partition to raw dump there. If a 
> user
> wants crash dumps, he has to leave some small disk space free and give 
> an
> option like "dump=/dev/hda7".
>
>

Mjah,

swap can be destroyed during a crash dump, so why not use that? 
Everybody else does it (AIX, Solaris, IRIX) so if none of the commercial 
UNIX vendors see a problem in using swap for dump, why should we?

I like the nvram option best for hardware that allows a oops output to 
be stored in nvram, since that is also usable on diskless systems when 
the network is down (or the network driver oopses) or when the disk 
driver oopses... Maybe do something like:

if there is enough space on disk && ..., use that else
if there is a swap over nfs && ..., use that else
if there is a tape drive attaced and a tape is present and it is 
writeable... else
if there is nvram available use that

and print on the console....

maybe this is all a bit overkill for what we need to do, maybe not... I 
guess it would make it possible to debug systems that are just sitting 
there by themselves, and have some curious problem...

- ---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9dhdQBIoCv9yTlOwRAsm0AJ40VJx5QmhrI7ME4w02WyM3Vn9X6wCcDMyq
M8Dp4XhDjSkKtEO3rbLlwxo=
=YtBZ
-----END PGP SIGNATURE-----

