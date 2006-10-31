Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423838AbWJaUPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423838AbWJaUPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423839AbWJaUPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:15:25 -0500
Received: from alnrmhc11.comcast.net ([204.127.225.91]:47522 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1423838AbWJaUPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:15:23 -0500
Message-ID: <4547AED6.1020909@comcast.net>
Date: Tue, 31 Oct 2006 15:15:18 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Luca Tettamanti <kronos.it@gmail.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk:  do we HAVE to use swap?
References: <20061031174006.GA31555@dreamland.darkstar.lan> <200610311905.33667.s0348365@sms.ed.ac.uk> <200610312019.38368.rjw@sisk.pl> <4547A6D7.5090309@comcast.net> <20061031200407.GA5194@dreamland.darkstar.lan>
In-Reply-To: <20061031200407.GA5194@dreamland.darkstar.lan>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Luca Tettamanti wrote:
> Il Tue, Oct 31, 2006 at 02:41:11PM -0500, John Richard Moser ha scritto: 
>> Rafael J. Wysocki wrote:
>>> On Tuesday, 31 October 2006 20:05, Alistair John Strachan wrote:
>>>> On Tuesday 31 October 2006 17:40, Luca Tettamanti wrote:
>>>>> Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
>>>>>> On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
>>>>>> [snip]
>>>>>>
>>>>>>> However, we already have code that allows us to use swap files for the
>>>>>>> suspend and turning a regular file into a swap file is as easy as
>>>>>>> running 'mkswap' and 'swapon' on it.
>>>>>> How is this feature enabled? I don't see it in 2.6.19-rc4.
>>>>> Swap files have been supported for ages. suspend-to-swapfile is very
>>>>> new, you need a -mm kernel and userspace suspend from CVS:
>>>>> http://suspend.sf.net
>>>> I know, I use swap files, and not a partition. This has prevented me from 
>>>> using suspend to disk "for ages". ;-)
>>>>
>>>> Is userspace suspend REQUIRED for this feature?
>>> No, but unfortunately one piece is still missing: You'll need to figure out
>>> where your swap file's header is located.
>>>
>>> However, if you apply the attached patch the kernel will tell you where it is
>>> (after you do 'swapon' grep dmesg for 'swap' and use the value in the
>>> 'offset' field).
>> Nobody has answered this one yet:  Once you 'swapon' doesn't the kernel
>> have (require?) the swap file opened writable?  Simple mode:
>>
>>   IS THIS NOT EXTREMELY DANGEROUS?
> 
> The trick is that the FS hosting the swapfile is *not* mounted at all;
> you don't even activate the swap. resume process uses the block number
> (better: the couple <devid, block>) to locate the swapfile.
> The "ugly" part of this method is that the user has to figure out the
> first block of the swapfile, since at resume time it's not possibile to
> mount the fs (not even read only - journaled filesystems will blow up
> due to journal replay) to search the swap area...
> 

Yes, I was referring to Wysoki's comment about using swapon to find it.
 Although I guess you could look beforehand; but then if you move the
partition around on disk the block changes (and the kernel, on resume,
goes "BOY WHAT IS WRONG WITH YOU?!" because the partition table is
incorrect XD)

> Luca

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRUeu1As1xW0HCTEFAQI9qBAAg8FWlQmueMKdr07bi2Q9YVgUO3+KZQwA
4fxpih3dgZvtWWjjvSTXNNVGySQQsonoLctn6pHBydKdpLHbpJs3qaLQ2e1/jcKi
YRDvZ3Gc0bi89W2odoMwBU4hLqY1ijKa+pujzU4pi29RoTaqWDvdw5KyTHMkZ4ib
x5kttdJ9MQ+o45JaYPzgAQ4pJnXORhqABY2IzG0jQdQb2+9YOY8dBwIMo8uzOQ4k
TU1x46xnPOEr54B1P/9gE9GCiDamjwg3x2o9HmhezQHvl5L88Yy7XOB7L8S9Tt0I
OUQYTBoiPjGXdgS1z6Q+qlgf8fN7OWIe3wpnQGf77GDIfVG4PxyptoEkptUf1UcK
7jNktJYTNJAP897uCNb9ZUySTQNKrj46/15UkQveNvh7lmqVu6J3MLlIZNED8liP
xuQliB/KzOylQ+VIbhBhiZI3kb2cGCmE09LWZUMSiI7Et+yN+TuvPE+Us5DkUfrf
J5QxXEg1tJnCprofBfL8sBpcfba4ccS373LIABZLZdGZZAy6bhch2ukDi1jM5dl+
9apv0YNxblXodT4z7fmfnXagdM/TzonH1G60YaP9vRJzmo5tv4/TNSK862MH+F+F
VJod+HTT/G5rT7gxsJpWSPG3L9gQV5OyKjFzElk8T+CBZl9mcf6ZxEuWo4LXnFgd
7RmzXNbGQBA=
=Drt3
-----END PGP SIGNATURE-----
