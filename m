Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUJLUqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUJLUqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUJLUox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:44:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:41421 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267776AbUJLUoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:44:38 -0400
X-Authenticated: #4512188
Message-ID: <416C422F.6030101@gmx.de>
Date: Tue, 12 Oct 2004 22:44:31 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040929)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Jens Axboe <axboe@suse.de>, "Ronny V. Vindenes" <s864@ii.uib.no>,
       ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: CFQ v2 high cpu load fix(?)
References: <1097579760.4086.27.camel@tentacle125.gozu.lan> <416BBF48.4070102@yahoo.com.au> <20041012121227.GA1754@suse.de> <416BCE4A.7060403@yahoo.com.au>
In-Reply-To: <416BCE4A.7060403@yahoo.com.au>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig77F5054025E92F7A4470AC2A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77F5054025E92F7A4470AC2A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin schrieb:
> Jens Axboe wrote:
> 
>> On Tue, Oct 12 2004, Nick Piggin wrote:
>>
>>> Ronny V. Vindenes wrote:
>>>
>>>>
>>>> --- patches/linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c    
>>>> 2004-10-12 12:25:09.798003278 +0200
>>>> +++ linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c    2004-10-12 
>>>> 12:25:42.959479479 +0200
>>>> @@ -100,7 +100,7 @@
>>>>         nr = q->nr_requests;
>>>>     q->nr_congestion_on = nr;
>>>>
>>>> -    nr = q->nr_requests - (q->nr_requests / 8) - 1;
>>>> +    nr = q->nr_requests - (q->nr_requests / 8) - 
>>>> (q->nr_requests/16)- 1;
>>>>     if (nr < 1)
>>>>         nr = 1;
>>>>     q->nr_congestion_off = nr;
>>>
>>>
>>>
>>> I thought this first hunk looked like a good idea when Arjan sent the
>>> patch. Can you check if it alone helps your problem?
>>
>>
>>
>> Yeah agree, it's a good idea to leave a bit of air between congestion on
>> and off. Fully explains the cfq v2 excessive sys time for some
>> workloads, which is extra nice.
>>
> 
> Cool. Can you queue up a patch for when -mm opens again, or shall I?
> I can't imagine it should cause any problems but a bit of testing
> would be wise.

Just as a feedback: I applied the first hunk of that patch to 
2.6.9-rc4-ck1 and it really makes a difference. At first I thought the 
staircase scheduler was responsible for io starvation sometimes, but now 
this behaviour is gone. Very well!

Prakash

--------------enig77F5054025E92F7A4470AC2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBbEIzxU2n/+9+t5gRAqv5AJ9MfoJXafImlRQ1t6yMztsyjpWTEACdFDay
uttzJTvjENDXkY7ga6MIMdU=
=o45H
-----END PGP SIGNATURE-----

--------------enig77F5054025E92F7A4470AC2A--
