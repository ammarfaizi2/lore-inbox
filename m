Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVC1TPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVC1TPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVC1TPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:15:47 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:3001 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262005AbVC1TO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:14:59 -0500
Message-ID: <424857B0.4030302@comcast.net>
Date: Mon, 28 Mar 2005 14:14:56 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, ubuntu-hardened@lists.ubuntu.com
Subject: Re: Collecting NX information
References: <42484B13.4060408@comcast.net>	 <1112035059.6003.44.camel@laptopd505.fenrus.org>	 <4248520E.1070602@comcast.net> <1112036121.6003.46.camel@laptopd505.fenrus.org>
In-Reply-To: <1112036121.6003.46.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Mon, 2005-03-28 at 13:50 -0500, John Richard Moser wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>
>>
>>Arjan van de Ven wrote:
>>
>>>>As I understand, PT_GNU_STACK uses a single marking to control whether a
>>>>task gets an executable stack and whether ASLR is applied to the
>>>>executable.
>>>
>>>
>>>you understand wrongly.
>>>
>>>PT_GNU_STACK just sets the exec permission for the stack (and the heap
>>>now mirrors the stack). Nothing more nothing less.
>>>
>>
>>So then this would be slightly more useful than I had previously
>>thought, bringing control over the randomization as well?
> 
> 
> actually Linus was really against adding non-related things to this
> flag. And I think he is right...
> 

I'm not interested in altering and hacking up PT_GNU_STACK; PT_PAX_FLAGS
already supplies enough to do what I want.  My goal is to have
PT_PAX_FLAGS code in mainline and Exec Shield, so that if it exists in
the binary it will be used; else PT_GNU_STACK will be fallen back to.

> Now.. do you have any examples of when you want a binary marked for no-
> randomisation ?? (eg something the setarch flag won't fix/won't be good
> enough for)

What's setarch do for one?  Anyway, ASLR has been known to break some
things.  Blackdown Java used to break IIRC; also there's the poorly
designed Oracle and the poorly designed solution of Oracle on a 32 bit
platform; and of course there's Emacs, which I heard was broken due to
Exec Shield's randomization.  Temporary work-arounds are sometimes needed.



Remember also that I'm not just trying to make a more robust setting for
ES and mainline; I'm trying to find a way to make it so that
distribution maintainers can set one set of flags and have it assure
that the program works in Mainline, Exec Shield, and PaX.  Just a little
less work for the distribution maintainers, which I think would be a
good thing considering that apparently Ubuntu Linux might support both
PaX and Exec Shield in the future, if I'm reading this[1] right.

[1] http://thread.gmane.org/gmane.linux.ubuntu.devel/6130


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSFeuhDd4aOud5P8RApQ+AKCPtp5b4/2rw+aRqEUg7r1FlphmQwCfX3Io
FUNq9xZlDsoo1poGBo5+zus=
=v0dv
-----END PGP SIGNATURE-----
