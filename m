Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbUKJUlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbUKJUlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUKJUlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:41:44 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:2479 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262045AbUKJUkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:40:41 -0500
Message-ID: <41927CBA.9050600@kolivas.org>
Date: Thu, 11 Nov 2004 07:40:26 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: Stephen Warren <SWarren@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: SCHED_RR and kernel threads
References: <DBFABB80F7FD3143A911F9E6CFD477B002A7F144@hqemmail02.nvidia.com> <41926BED.7040400@tmr.com>
In-Reply-To: <41926BED.7040400@tmr.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF337E7D33491C9F8A1F3D302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF337E7D33491C9F8A1F3D302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bill Davidsen wrote:
> Stephen Warren wrote:
> 
>>> From: Con Kolivas [mailto:kernel@kolivas.org] Stephen Warren writes:
>>>
>>>> I guess we could have most threads stay at SCHED_NORMAL, and just
>>
>>
>> make
>>
>>>> the few critical threads SCHED_RR, but I'm getting a lot of push-back
>>
>>
>> on
>>
>>>> this, since it makes our thread API a lot more complex.
>>>
>>>
>>> Your workaround is not suitable for the kernel at large.
>>
>>
>>
>> You mean the official kernel.org kernel? I wasn't implying that the
>> patch should be part of that!
>>
>> In our system we have literally EVERY single thread (kernel, user-space
>> daemons, and user-space applications) all setup as SCHED_RR with
>> identical priority at present, except a couple higher priority threads.
>> We did this initially for user-space by replacing /sbin/init with a
>> wrapper that set the scheduler policy and default priority, and verified
>> that this was inherited by all daemons & application threads. Then, we
>> found that the kernel threads could get starved in some situations,
>> hence the kernel change.
>>
>> Our threading model dictates that every thread have a priority (so that
>> the thread model is portable between Linux, embedded RTOSs etc.), and in
>> Linux AFAIK, the only way to implement priorities is to use a real-time
>> scheduling policy. Some threads do a lot of calculation. We want to make
>> them equal (or probably, lower) priority to the kernel threads, so
>> therefore the kernel threads must then be SCHED_RR.
>>
>> Can you elaborate on specific conditions that would cause the kernel
>> threads to suck up unusual amounts of CPU time?
>>
>> In our application, keyboard processing is a real-time requirement, so
>> if that is performed in a kernel thread, that kernel thread should be
>> real-time. We basically want the control to insert e.g. the keyboard
>> processing kernel thread into the middle of our priority hierarchy,
>> rather than having it forced as the lowest possible priority.
> 
> 
> Perhaps someone could comment on why the keyboard thread is NOT higher 
> priority? The whole functionality of SysReq key combinations would seem 
> to depend on actually seeing the strokes. I would cautiously suggest 
> that a priority control in /proc/sys might be a useful interface, 
> certainly compared to patching the kernel and rebuilding.
> 
> Yes, I mean an option in the mainline kernel, so when debugging hangs 
> the keyboard could be used.
> 

There is nothing stopping you from setting the priority and the 
scheduling policy from userspace in mainline.

Cheers,
Con

--------------enigF337E7D33491C9F8A1F3D302
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkny8ZUg7+tp6mRURAg3kAJ93IMiFbviN8Ra6UPj6qnAVA6VGlQCgjgfi
Gey4skm1Vo5f0bQRuCdXE78=
=79m0
-----END PGP SIGNATURE-----

--------------enigF337E7D33491C9F8A1F3D302--
