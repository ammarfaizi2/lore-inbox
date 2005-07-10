Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVGJHSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVGJHSj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 03:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVGJHSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 03:18:38 -0400
Received: from smtp3.oregonstate.edu ([128.193.0.12]:14976 "EHLO
	smtp3.oregonstate.edu") by vger.kernel.org with ESMTP
	id S261868AbVGJHRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 03:17:21 -0400
Message-ID: <42D0CB7C.2070005@engr.orst.edu>
Date: Sun, 10 Jul 2005 00:17:16 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: ALPS psmouse_reset on reconnect confusing Tecra M2
References: <42C9A69A.5050905@waychison.com> <200507041705.17626.dtor_core@ameritech.net> <42CB63AD.4070208@engr.orst.edu> <200507100136.49735.dtor_core@ameritech.net> <42D0C356.9070102@engr.orst.edu>
In-Reply-To: <42D0C356.9070102@engr.orst.edu>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig732B466549DABC68FFF65276"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig732B466549DABC68FFF65276
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Micheal Marineau wrote:
> Dmitry Torokhov wrote:
> 
>>On Tuesday 05 July 2005 23:53, Micheal Marineau wrote:
>>
>>
>>>Dmitry Torokhov wrote:
>>>
>>>
>>>>On Monday 04 July 2005 16:14, Mike Waychison wrote:
>>>>
>>>>
>>>>
>>>>>Hi,
>>>>>
>>>>>I just upgrade my Tecra M2 this weekend to the latest GIT tree and
>>>>>noticed that my mouse pointer/touchpad is now broken on resume.
>>>>>
>>>>>Investigating, it appears that mouse device gets confused due to the
>>>>>introduced psmouse_reset(psmouse) during reconnect:
>>>>>
>>>>>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f3a5c73d5ecb40909db662c4d2ace497b25c5940
>>>>
>>>>
>>>>Hi,
>>>>
>>>>Please try the following patch:
>>>>
>>>>	http://www.ucw.cz/~vojtech/input/alps-suspend-typo
>>>>
>>>
>>>This fixed the problem for mylaptop, but ONLY if I had #define DEBUG in
>>>alps.c, switch it back to the usual #undef and the exact same problem
>>>happens.  I've got no idea what's going on, I'll poke at it more when
>>>I'm awake....
>>>
>>
>>
>>Hi,
>>
>>Sorry, any update on this topic? Does it still only work with DEBUG?
>>
>>Thanks!
> 
> 
> I have no clue why DEBUG helped, but it seems to have been simply dumb
> luck as the issue came up again with DEBUG still on.  An easy workaround
> was to compile psmouse as a module and unload/load it during the suspend
> cycle (automatic with the hibernate script, it has psmouse in it's
> blacklist).  I haven't dug into it to see what exactly doesn't get
> initilized during resume that should.
> 
> 

Here's a little more info though:
dmesg on boot/re-load module
alps.c: E6 report: 00 00 64
alps.c: E7 report: 63 03 c8
alps.c: E6 report: 00 00 64
alps.c: E7 report: 63 03 c8
alps.c: Status: 10 00 64

dmesg after a resume (no reloading of the module)
alps.c: E6 report: 00 00 64
alps.c: E7 report: 63 03 c8
alps.c: Status: 10 00 64
alps.c: Status: 10 00 64


-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University


--------------enig732B466549DABC68FFF65276
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC0Mt8iP+LossGzjARAtWdAJ9XefauQGTZsKBlGgNy3uBqBg4+HQCeNjcs
BG9Y2AXfo7AHIEsrx9LwzKE=
=K8lq
-----END PGP SIGNATURE-----

--------------enig732B466549DABC68FFF65276--
