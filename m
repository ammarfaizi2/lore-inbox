Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbULFCAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbULFCAB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 21:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbULFCAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 21:00:01 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:27065 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261450AbULFB76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 20:59:58 -0500
Message-ID: <41B3BD0F.6010008@kolivas.org>
Date: Mon, 06 Dec 2004 12:59:43 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced CFQ #2
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de> <20041206002954.GA28205@optonline.net>
In-Reply-To: <20041206002954.GA28205@optonline.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig014EE5EB87A1EB7797FD219B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig014EE5EB87A1EB7797FD219B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Sipek wrote:
> On Sun, Dec 05, 2004 at 07:58:45PM +0100, Jens Axboe wrote:
> 
>>It should be really easy to try some rudimentary prio io support - just
>>scale the time slice based on process priority. A few lines of code
>>change, and io priority now follows process cpu scheduler priority. To
>>work really well, the code probably needs a few more limits besides just
>>slice time.
> 
> 
> I started working on the rudimentary io prio code, and it got me thinking...
> Why use the cpu scheduler priorities? Wouldn't it make more sense to add
> io_prio to task_struct? This way you can have a process which you know needs
> a lot of CPU but not as much io, or the other way around.

That is the design the Jens' original ioprio code used which we used in 
-ck for quite a while. What myself and -ck users found, though, was that 
being tied to cpu 'nice' meant that most tasks behaved pretty much as 
we'd expect based on one sys call.

I think what is ideal is to have both. First the ioprio should be set to 
what the cpu 'nice' level is as a sort of global "this is the priority 
of this task" setting. Then it should also support changing of this 
priority with a different call separate from the cpu nice. That way we 
can take into account access privileges of the caller making it 
impossible to set a high ioprio if the task itself is heavily niced by a 
superuser and so on.

Cheers,
Con

--------------enig014EE5EB87A1EB7797FD219B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBs70RZUg7+tp6mRURAiTkAJ0fxLl46BRXs9D2E7h/AWnPP3z/bgCdH22m
9aQ3/sIFNViw6mgDezuB3Yg=
=B8gO
-----END PGP SIGNATURE-----

--------------enig014EE5EB87A1EB7797FD219B--
