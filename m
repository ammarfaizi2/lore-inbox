Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVJECDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVJECDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 22:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVJECDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 22:03:52 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:34707 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751038AbVJECDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 22:03:52 -0400
Message-ID: <43433424.3060903@comcast.net>
Date: Tue, 04 Oct 2005 22:02:12 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU)
References: <434204F8.2030209@comcast.net> <200510041539.j94FdJmO028772@turing-police.cc.vt.edu> <4342C9F1.2000005@comcast.net> <200510041943.j94Jhj4C007314@turing-police.cc.vt.edu>            <4342E1A2.7080008@comcast.net> <200510042232.j94MWQR4006568@turing-police.cc.vt.edu>
In-Reply-To: <200510042232.j94MWQR4006568@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Tue, 04 Oct 2005 16:10:10 EDT, John Richard Moser said:
> 
> 
>>>And the other users are users as well - what if the other user's "idiotic
>>>action" is to nuke your 500Mbyte archive of alt.binaries.pictures.llama.sex
>>>that's taking up the disk space that is keeping him from running the payroll
>>>software?  In your world, rather than him being able to fix the problem, he has
>>>to go find a sysadmin with the root password to fix it, causing delays and
>>>being less friendly....
> 
> 
>>Oh sure, except that. . .
>>
>>1)  You shouldn't be screwing with the payroll system
>>2)  You're quota'd on any good setup
> 
> 
> Ahem.  You're adding in more "user unfriendly" constraints again. :)
>  
> 
>>In the end, massive, intrusive security is not exactly the best thing
>>for security's sake; but anything you can get away with significantly
>>cleanly (i.e. you don't break 99% of the applications on 99% of home
>>users' desktops) is worth immediate focus for those who are so inclined.
> 
> 
> Good.  Now hand me that crystal ball that lets us know for sure which of
> those two categories any given security measure falls into.  How often do
> we see "this shouldn't break anything" patches on this list that do, in fact,
> manage to break something anyhow?

I've seen PaX break Xine, Java, nVidia's retarded binary OpenGL, and
mplayer.  Aside from that everything else ran rather smooth on my
system, including X itself.  To fix this of course was a policy
adjustment that weakened the protections partially for each breaking
thing.  For a time I noticed native x86-64 Xine had a bug and would make
bad assumptions, and died on a vanilla linux kernel because an area
aside from stack/heap that defaulted to !PROT_EXEC was expected to be
executable; I actually needed PaX so I could equate PROT_READ to
PROT_EXEC for Xine.

When ASLR went into 2.6.13 there was talk about higher ASLR breaking
Oracle; and a little bit about Emacs breaking at times.  Wine also has
iffy issues with it that get addressed by an early hack, which is the
Wine devs being -quite- friendly.  Linus mentioned something about
mmap()ing a 2 gig email box into memory on IA-32.  Aside from that,
high-order ASLR shouldn't be a problem; and most of those issues vanish
on 64-bit systems anyway.

Exec Shield breaks a few things, about as much as PaX; but the compiler
was explicitly modified to turn Exec Shield off if the wind blows, so
they started with a relatively wide number of binaries with ES disabled
while RH tried to narrow it to essentials (a backwards approach if you
ask me).  You never see ES break stuff because of this.

Neither Spender nor me have seen the grsecurity/openwall "linking
restrictions" break anything, although I've heard one person report on
an obscure app not liking it for some strange reason.  Aside from that,
it's effective at keeping ahead of the game when it comes to /tmp file
races.

I don't think grsecurity's banning of any write access to /dev/*mem
except for the video memory area ever actually broke anything legitimate.

Position independent executables help ASLR such as from PaX or Exec
Shield be more effective; if the program isn't going to work with it,
it's flat out not going to compile.  If it compiles, it works.

ProPolice's protections only break programs with bugs.  To mis-fire
ProPolice, you have to actually write past the end of a stack based
buffer, ticking off the canary.  Of course, it immediately tells you
where the problem is so you can go fix your code.

I forsee PHKmalloc in OpenBSD, if it works as advertised, as doing the
same things ProPolice does, but to the heap.  This means slightly-buggy
apps will fall victim to sudden death.  Good riddance to bad rubbish;
may the developers correct all exposed bugs with expedience.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDQzQjhDd4aOud5P8RAtt7AJkBrPxss5dNMNrrSXQeQyZSDyr8OQCgjSVH
3aDc4HOcrLYRYLUGSxlPOFE=
=IZeX
-----END PGP SIGNATURE-----
