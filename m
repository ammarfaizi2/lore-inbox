Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUKJJ6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUKJJ6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 04:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUKJJ6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 04:58:47 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:54419 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261663AbUKJJ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 04:58:03 -0500
Message-ID: <4191E605.1050401@kolivas.org>
Date: Wed, 10 Nov 2004 20:57:25 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Patrick Mau <mau@oscar.ping.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Workaround for wrapping loadaverage
References: <20041108001932.GA16641@oscar.prima.de> <20041108012707.1e141772.akpm@osdl.org> <20041108102553.GA31980@oscar.prima.de> <20041108155051.53c11fff.akpm@osdl.org> <20041109004335.GA1822@oscar.prima.de> <20041109185103.GE29661@mail.13thfloor.at> <41913B75.1050500@kolivas.org> <20041110062059.GA20467@mail.13thfloor.at>
In-Reply-To: <20041110062059.GA20467@mail.13thfloor.at>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC0A5A615FC1862030AD499CC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0A5A615FC1862030AD499CC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Herbert Poetzl wrote:
> On Wed, Nov 10, 2004 at 08:49:41AM +1100, Con Kolivas wrote:
> 
>>Herbert Poetzl wrote:
>>
>>>but I agree that a higher resolution would be a good
>>>idea ... also doing the calculation when the number
>>>of running/uninterruptible processes has changed would
>>>be a good idea ...
>>
>>This could get very expensive. A modern cpu can do about 700,000 context 
>>switches per second of a real task with the current linux kernel so I'd 
>>suggest not doing this.
> 
> 
> hmm, right it can, do you have any stats about the
> 'typical' workload behaviour? 

How long is a piece of string? It depends entirely on your workload. On 
a desktop machine just switching applications pushes it to 10,000. 
Basically you end up making it an O(n) calculation by increasing the 
overhead of it (albeit small) proportionately to the context switch load 
which is usually significantly higher than the system load.

> do you know the average time between changes of 
> nr_running and nr_uninterruptible?

Same answer. Depends entirely on the workload and to whether your 
running tasks sleep at all or not (hint - most do). While it will be a 
lower number than the number of context switches, it potentially can be 
as high with just the right sort of threads (think server, network type 
stuff).

> TIA,
> Herbert

Cheers,
Con

--------------enigC0A5A615FC1862030AD499CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkeYHZUg7+tp6mRURAvDyAJ9/Gmgmi6czPqSJIjLQS8kbnLsmcgCeN+lg
ehflh+5EG27ejMOaXNMnz7U=
=Nu/I
-----END PGP SIGNATURE-----

--------------enigC0A5A615FC1862030AD499CC--
