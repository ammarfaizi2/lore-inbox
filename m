Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVAZXys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVAZXys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVAZXxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:53:31 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:35998 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262257AbVAZUCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:02:19 -0500
Message-ID: <41F7F75C.5090500@comcast.net>
Date: Wed, 26 Jan 2005 15:02:36 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Sytse Wielinga <s.b.wielinga@student.utwente.nl>,
       Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <Pine.LNX.4.58.0501251054400.2342@ppc970.osdl.org> <41F6A5F8.5030100@comcast.net> <20050126160620.GE23182@speedy.student.utwente.nl>            <41F7EFF4.40303@comcast.net> <200501261951.j0QJovSn019728@turing-police.cc.vt.edu>
In-Reply-To: <200501261951.j0QJovSn019728@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Wed, 26 Jan 2005 14:31:00 EST, John Richard Moser said:
> 
> 
>>[*] Grsecurity
>>  Security Level (Custom)  --->
>>  Address Space Protection  --->
>>  Role Based Access Control Options  --->
>>  Filesystem Protections  --->
>>  Kernel Auditing  --->
>>  Executable Protections  --->
>>  Network Protections  --->
>>  Sysctl support  --->
>>  Logging Options  --->
>>
>>?? Address Space Protection ??
>> [ ] Deny writing to /dev/kmem, /dev/mem, and /dev/port
>> [ ] Disable privileged I/O
>> [*] Remove addresses from /proc/<pid>/[maps|stat]
>> [*] Deter exploit bruteforcing
>> [*] Hide kernel symbols
>>
>>Need I continue?  There's some 30 or 40 more options I could show.  If
>>you can't use your enter, left, right, up, y, n, and ? keys, you're
>>crippled and won't be able to patch and unpatch crap either.
> 
> 
> Just because I can use my arrow keys doesn't mean I can find which part of
> a 250,000 line patch broke something.
> 

I can.

Read Kconfig.  Find the CONFIG_* for the option.  Find what that
disables in the code.  Get to work.

> If it's done as 30 or 40 patches, each of which implements ONE OPTION, then
> it's pretty easy to play binary search to find what broke something.
> 

Yes and those patches would implement what's inside #ifdef CONFIG_*'s,
so if turning an option off fixes something, it's fairly equivalent.
I'll let it slide that those patches would likley make "some" changes
that aren't in #ifdef blocks, making it a bit harder to track down,
since those changes can also cause breakage themselves and be even
tougher to track down (though maybe not, just read the patch for
non-blocked-off stuff in some cases).

> And don't give me "it doesn't break anything" - in the past, I've fed at least
> 2 bug fixes on things I found broken back to the grsecurity crew (one was a
> borkage in the process-ID-randomization code, another was a bad parenthesis
> matching breaking the intent of an 'if' in one of the filesystem protection
> checks (symlink or fifo or something like that).

Hmm?  I found the PID rand breakage in 2.6.7's gr to be quite annoying
and disabled it.  It took me all of 2 minutes to determine that PID
randomization was causing the breakage-- as I enabled it during boot
with an init script, the machine oopsed several times and then panic'd.  :)

Heh, divide that 2 minutes by the thousands of people who look at the
code, and you find bugs before they're created :D  (j/k)

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9/dbhDd4aOud5P8RAokYAJ9oukytYsqBhz71RtzpC4o7K9od1QCfTRou
ln0qF42yrB6+gi1Kt4YXudY=
=75yE
-----END PGP SIGNATURE-----
