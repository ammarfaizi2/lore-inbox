Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267394AbUHEJfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267394AbUHEJfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 05:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267610AbUHEJfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 05:35:00 -0400
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:16303 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267394AbUHEJe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 05:34:56 -0400
Message-ID: <4111FF35.3040002@kolivas.org>
Date: Thu, 05 Aug 2004 19:34:45 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <20040804103143.GA13072@elte.hu> <cone.1091616443.996442.9775.502@pc.kolivas.org> <20040804124538.GA15505@elte.hu> <cone.1091674380.801763.9775.502@pc.kolivas.org> <4111F0FF.7090301@hist.no>
In-Reply-To: <4111F0FF.7090301@hist.no>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAE07337E2849232F1B561AA7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE07337E2849232F1B561AA7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Helge Hafting wrote:
> Con Kolivas wrote:
> 
>> Ingo Molnar writes:
>>
>>>
>>> * Con Kolivas <kernel@kolivas.org> wrote:
>>>
>>>>
>>>> Can you define them please? I haven't had any reported to me.
>>>
>>>
>>>
>>> sure: take a process that uses 85% of CPU time (and sleeps 15% of the
>>> time) if running on an idle system. Start just two of these hogs at
>>> normal priority. 2.6.8-rc2-mm2 becomes almost instantly unusable even
>>> over a text console: a single 'top' refresh takes ages, 'ls' displays
>>> one line per second or so. Start more of these and the system
>>> effectively locks up.
>>
>>
>>
>> It's only if I physically try and create such a test application that 
>> I can reproduce it. I haven't found any real world load that does that 
>> - but of course that doesn't mean I should discount it. However, 
>> interactive mode off doesn't exhibit it and it should be easy enough 
>> to fix for interactive mode on. Thanks for pointing it out.
> 
> 
> I can easily imagine this sort of real-life application.  Anything that 
> generate real-time data, such as sound or video for immediate playback 
> will use some continous fraction of cpu, depending on how much data and 
> how fast the cpu happens to be.   A scheduler with such
> a problem will now and then cause trouble when some processor needs just 
> the
> "wrong" percentage of its capacity to run the task(s). Consider someone 
> playing several video files until he exceeds the capacity of the 
> machine. Video skipping frames is then ok, a frozen UI is not.  Or 
> consider a multiuser machine running several games.  Or even a parallell 
> kernel compile when the source isn't cached. The compiler(s) will work 
> for a while, wait for disk for a while, work for a while . . .

Your concerns are valid, and are relevant for _any_ scheduler design. 
However none of these occur with staircase. Ingo is describing a special 
case where it runs for more than 1ms and less than 10ms. Most things do 
not run exactly in this manner, which is why you haven't seen it, and 
neither have I till I created his test case.

As for the multiuser machine, this is actually an area where staircase 
_excels_ at when put into non-interactive mode. The fact that 
interactivity is not as good in interactive mode under load in a single 
desktop mode doesn't really describe that interactivity is still 
remarkably good considering how strict the cpu distribution is - and 
that's by design. I have now a couple of users using staircase in 
non-interactive mode sharing resources between up to 10 users happily, 
where previously the mainline 2.6 kernel was unable to do this in a fair 
manner.

> 2.6.8-rc2-mm2 seems to work fine for me right now, but I hope there will 
> be solutions for this sort of problem.

Great.

> Helge Hafting

Cheers,
Con

--------------enigAE07337E2849232F1B561AA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBEf83ZUg7+tp6mRURAtCJAJ9YYDvgzoo3O7Ign9ylQ1f49qbfvQCeIK9R
RkM+1MOFv2VIIelZaeJ/FpM=
=NSNx
-----END PGP SIGNATURE-----

--------------enigAE07337E2849232F1B561AA7--
