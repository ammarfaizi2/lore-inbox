Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752170AbWJNPE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbWJNPE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbWJNPE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:04:56 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:35503 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1752170AbWJNPEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:04:55 -0400
Message-ID: <4530FC8E.7020504@comcast.net>
Date: Sat, 14 Oct 2006 11:04:46 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Driver model.. expel legacy drivers?
References: <4530570B.7030500@comcast.net> <20061014075625.GA30596@stusta.de>
In-Reply-To: <20061014075625.GA30596@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Adrian Bunk wrote:
> On Fri, Oct 13, 2006 at 11:18:35PM -0400, John Richard Moser wrote:
>> Here's a silly thought I had a while ago.  Linux has no static ABI for
>> device drivers, I think the general argument was between "it's slower"
>> and "different hardware will have different requirements."  Putting
>> aside design difficulties, I've come up with an example case of a useful
>> hardware driver ABI.
>>
>> As kernel development goes on, some infrastructure changes require
>> drivers to be updated.  Eventually some drivers become buggy and
>> ill-maintained, even when they used to be legitimately working ones; and
>> then developers have to take some of their time to fix them, or eject
>> them from the tree.
> 
> The rule is simple:
> If you break an in-kernel API, you have to fix all in-kernel users.
> 
> No matter how ill-maintained a driver is, that works quite good.
> 

Nods.  I hope that keeps working then.

>> ...
>> This brings up a few potential questions:
>>
>>   - Will this eventually be necessary to an absolute?  Will 100M
>>     tarballs and hundreds of thousands of drivers be unmanageable in a
>>     tight, ABI-unstable monolith 10 years from now?
> 
> "hundreds of thousands of drivers" won't happen during my lifetime.
> 
> If the kernel size only doubles to 100 MB that's no problem.
> 

The below is purely informative.  I would like to wait until around
2.6.30 and redo the math, because I am not certain of the growth.  I
believe it would be statistically more sound to have a wider sample base
to calculate the regression from, especially with the wide variance in
growth between kernel versions.


I've mapped the growth of the .tar.bz2 archives in kilobytes since
2.6.0, they show an erratic pattern but a strong overall linear growth
pattern.  This means the actual size of the kernel is polynomial and
integrates crudely to:

   18.59x^2+133.1x+32600

For x == minor (i.e. 2.6.0 == 0; 2.6.18 == 18).  This produces a level
of error; however, I've graphed the error and it seems to be off by no
more than 400k ever and show a horizontal trend (i.e. overall accurate);
however I'll have to apply the same prediction to future kernel versions
to get a good picture.

The point is that compressed kernel source tree size is growing on the
order of a second degree polynomial.  I have not done measurements on
the uncompressed tree size because I'd have to download and decompress
every version; but I imagine it correlates, due to the nature of
compression.

My math predicts that 2.6.57 (+39) will be 100M (in approximately 7
years if you assume 1 kernel release every 2 months); 2.6.92 (+35) will
breech 200M; 2.6.117 (+25) will breech 300M; and 2.6.138 (+21)) will
breech 400M.  That should suffice for predictions over the next 20 years
based on this crude model.

I would like to wait for more data and perform a better analysis in 2
years; although I would be interested now in finding a way to get the
full kernel source tree size in bytes without actually downloading and
unpacking all the tarballs.  Is there a list somewhere I can use?

>>   - Would it ACTUALLY be worthwhile, given such a scenario, to expel
>>     drivers out of the tree to glue on by a static, somewhat slower but
>>     workable ABI so nobody has to touch the code ever?
> 
> Documentation/stable_api_nonsense.txt describes why this is nonsense.
> 
> And if you anyway don't want to change the kernel API, it doesn't make 
> any difference for you whether the drives are shipped with the kernel.
> 
> And external drivers with various interdependencies and dependencies 
> would be an insane maintenance nightmare.
> 

This is probably true.
>>   - Is there actually a benefit -now- to ejecting drivers from the tree,
>>     or are the developers pretty much comfortable polishing the stuff
>>     nobody normally touches here and there?
> 
> The goal is to get drivers into the kernel and shipping a complete 
> kernel with all drivers.
> 
>> Just curious.
> 
> This point comes up every few months on this list, so instead of 
> starting the same old disussion on this topic please read the old 
> discussions in the list archives.
> 
> cu
> Adrian
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTD8jQs1xW0HCTEFAQLwyBAAkT1TO+paC0H2LJpVfViej0WnL6s4BRr6
uRkha7zqLqEmtfGtUONvlbYIUkci+ItjDPdl4gNLXiiBwFoV4fylKHDeKqykub8v
qZg+4tiRC/5DSsSi1v0RTOTmmzcLJg8npYmCWSLsCh8ZN83WlJmJ8moTdKvLJWsF
qQ2YWqKqdr7kW6//vTGsgHCAh2l0TQtX7UZop5XU7JB1nwbEfuaLmuDrKD9KRw3j
s0zo8fEed71Usl6FRyqUcsl50lauc/DfCGazMgzcyaTXvTwXbF+GLb1a+BUwnk7L
ensx15GfsZwYQT/pupw2jlp7XPHqZ8/1Z55UO+faxkWugOC361dV93dSGUVzQ4dR
huLZGB7Abwd3R7Gbyk51VwZPys+PWfQUkG4oujW+6UQNTMjwvBadj+OuONcvq819
QYYJrCSFq40aeBWgsE4OF4px+ngOR4FMPdM7R6NdwD5jQ+deAbtTN4+ebWWnUUrx
NPUvt4fJGv3eWTGEGz+cAnZqUtoPSna3n2LZKqN03pIO1agTWKqb5Z6q4Lx+DeWl
9kIEnaDC2wepPSKh1p7ZQbnungiSsNcB6U7ngQCTPtnNMAfwSp6rA5PUtb2DJt03
0Du4sY9cOYWtB+2nyTN8eDeKfsAjb6mUueZTdHNt0Lx03HengpMU1m8/J4CeNVMb
0fifJoDorhw=
=6PWi
-----END PGP SIGNATURE-----
