Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVA0WeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVA0WeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVA0WeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:34:23 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29435 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261252AbVA0WeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:34:10 -0500
Message-ID: <41F96C7D.9000506@comcast.net>
Date: Thu, 27 Jan 2005 17:34:37 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>	 <1106848051.5624.110.camel@laptopd505.fenrus.org>	 <41F92D2B.4090302@comcast.net>	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>	 <41F95F79.6080904@comcast.net> <1106862801.5624.145.camel@laptopd505.fenrus.org>
In-Reply-To: <1106862801.5624.145.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>>I feel the need to point something out here.
>>
>>[TEXT][BRK][MMAP---------------][STACK]
>>
>>Here's a normal layout.
>>
>>[TEXT][BRK][MMAP-------][STACK][MMAP--]
>>
>>Is this one any worse?
> 
> 
> yes.
> 
> oracle, db2 and similar like to mmap 2Gb or more *in one chunk*.
> moving the stack in the middle means the biggest chunk they can mmap
> shrinks. 
> 

Special case?

I never said these weren't out there.  But the point is, who runs
oracle?  Your internal production server, maybe even a cluster, run it
now.  Your desktops don't.  Your web server exposed to the net
shouldn't.  Both these are exactly where you *really* want this stuff:
desktops get exposed to the WWW (and IRC and AIM and God knows what
else), and web servers get exposed to the HTTP protocol (or ftp or
whatever).

Interesting, it's theoretically far less likely that an exploit occurs
on your server than on your desktop; and the special cases such as your
Oracle example aren't likely to be sharing a machine with your
promiscuous touching of everyone else on the Internet with a web browser
and IRC client, correct?

Can I get this put into perspective?  How much more important is "Good"
randomization versus "not breaking Oracle," which becomes "No
randomization" (for Oracle anyway, not for everything else on a
well-designed system)?  How much of an effect does "good" randomization
have on your web server and desktop machines versus on your internal,
isolated RDBMS server/cluster?

More pertainantly (believe it or not), do you even care to ponder these
questions, or is your next response going to be a stock response?

> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+Wx8hDd4aOud5P8RAuriAJ0WYcesi/o5lOZIJ++UG8WbDu3PMACeKaB5
/YjzHR2n0aRiUrxUrca1gkU=
=0/hv
-----END PGP SIGNATURE-----
