Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVASJib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVASJib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVASJgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:36:12 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:132 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261686AbVASJe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:34:28 -0500
Message-ID: <41EE2987.1040005@kolivas.org>
Date: Wed, 19 Jan 2005 20:33:59 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org> <87is5tx61a.fsf@sulphur.joq.us>
In-Reply-To: <87is5tx61a.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF9EB79CC4C8F106DC4A47228"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9EB79CC4C8F106DC4A47228
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>This patch for 2.6.11-rc1 provides a method of providing real time
>>scheduling to unprivileged users which increasingly is desired for
>>multimedia workloads.
> 
> 
> I ran some jack_test3.2 runs with this, using all the default
> settings.  The results of three runs differ quite significantly for no
> obvious reason.  I can't figure out why the DSP load should vary so
> much.  

I installed a fresh jack installation and got the test suite. I tried 
running the test suite and found it only ran to completion if I changed 
the run time right down to 30 seconds from 300. Otherwise it bombed out 
almost instantly at the default of 300. I don't know if that helps you 
debug the problem or not but it might be worth mentioning.

As for my own results I gave it a run on the weak SCHED_ISO 
implementation in 2.6.10-ck5 (P4HT 3.06):

SCHED_NORMAL:
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :    74
Delay Count (>spare time) . . :     0
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :     0   usecs
Cycle Maximum . . . . . . . . :  1046   usecs
Average DSP Load. . . . . . . :    18.0 %
Average CPU System Load . . . :     2.5 %
Average CPU User Load . . . . :     7.8 %
Average CPU Nice Load . . . . :     0.1 %
Average CPU I/O Wait Load . . :     0.1 %
Average CPU IRQ Load  . . . . :     0.1 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1776.0 /sec
Average Context-Switch Rate . : 10290.4 /sec
*********************************************

SCHED_NORMAL nice -n -20:
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :   266
Delay Count (>spare time) . . :     0
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :     0   usecs
Cycle Maximum . . . . . . . . :  2239   usecs
Average DSP Load. . . . . . . :    28.6 %
Average CPU System Load . . . :     2.9 %
Average CPU User Load . . . . :    10.2 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     1.0 %
Average CPU IRQ Load  . . . . :     0.2 %
Average CPU Soft-IRQ Load . . :     0.1 %
Average Interrupt Rate  . . . :  2049.7 /sec
Average Context-Switch Rate . : 10145.1 /sec
*********************************************

SCHED_ISO:
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     1
Delay Count (>spare time) . . :     0
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :     0   usecs
Cycle Maximum . . . . . . . . :   687   usecs
Average DSP Load. . . . . . . :    19.9 %
Average CPU System Load . . . :     2.6 %
Average CPU User Load . . . . :    10.3 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     0.2 %
Average CPU Soft-IRQ Load . . :     0.3 %
Average Interrupt Rate  . . . :  2166.2 /sec
Average Context-Switch Rate . : 10117.3 /sec
*********************************************

SCHED_FIFO:
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     2
Delay Count (>spare time) . . :     0
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :     0   usecs
Cycle Maximum . . . . . . . . :   544   usecs
Average DSP Load. . . . . . . :    19.5 %
Average CPU System Load . . . :     3.1 %
Average CPU User Load . . . . :    12.6 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     1.0 %
Average CPU Soft-IRQ Load . . :     1.1 %
Average Interrupt Rate  . . . :  5018.4 /sec
Average Context-Switch Rate . : 10902.5 /sec
*********************************************


It occasionally would segfault on client exit as well (as you've already 
mentioned). I think we're still in the dark here to be honest.

Con

--------------enigF9EB79CC4C8F106DC4A47228
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7imKZUg7+tp6mRURAoE+AJ9scXmMkuaJ2y7sK5oqtQR0YAQQ5wCfV+sD
afwRAjgtdU0cx8fokv226+c=
=jnLe
-----END PGP SIGNATURE-----

--------------enigF9EB79CC4C8F106DC4A47228--
