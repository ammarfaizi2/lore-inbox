Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVAXOCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVAXOCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVAXOCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:02:51 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:20141 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261496AbVAXOC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:02:26 -0500
Message-ID: <41F4FFCC.6060504@kolivas.org>
Date: Tue, 25 Jan 2005 01:01:48 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       linux <linux-kernel@vger.kernel.org>, alexn@dsv.su.se,
       CK Kernel <ck@vds.kolivas.org>, "Jack O'Quin" <joq@io.com>,
       rlrevell@joe-job.com, Arjan van de Ven <arjanv@redhat.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, utz <utz@s2y4n2c.de>,
       Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [ck] Re: [patch,	2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit
 tunable
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>	<20050124125814.GA31471@elte.hu> <41F4FDE7.9080803@kolivas.org>
In-Reply-To: <41F4FDE7.9080803@kolivas.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBFA20CF74A9E960650682A3A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBFA20CF74A9E960650682A3A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> Ingo Molnar wrote:
> 
>> * Ingo Molnar <mingo@elte.hu> wrote:
>>
>>
>>> [...] "how do we give low latencies to audio applications (and other,
>>> soft-RT alike applications), while not allowing them to lock up the
>>> system."
>>
>>
>>
>> ok, here is another approach, against 2.6.10/11-ish kernels:
>>
>>   http://redhat.com/~mingo/rt-limit-patches/
>>
>> this patch adds the /proc/sys/kernel/rt_cpu_limit tunable: the maximum
>> amount of CPU time all RT tasks combined may use, in percent. Defaults
>> to 80%.
>>
>> just apply the patch to 2.6.11-rc2 and you should be able to run e.g. 
>> "jackd -R" as an unprivileged user.
>>
>> note that this allows the use of SCHED_FIFO/SCHED_RR policies, without
>> the need to add any new scheduling classes. The RT CPU-limit acts on the
>> existing RT-scheduling classes, by adding a pretty simple and
>> straightforward method of tracking their CPU usage, and limiting them if
>> they exceed the threshold. As long as the treshold is not violated the
>> scheduling/latency properties of those scheduling classes remains.
>>
>> It would be very interesting to see how jackd/jack_test performs with
>> this patch applied, and rt_cpu_limit is set to different percentages,
>> compared against unpatched SCHED_FIFO performance.
> 
> 
> Indeed it would be interesting because assuming there are no bugs in my 
> SCHED_ISO implementation (which is unlikely) it should perform the same.
> 
> There are a number of features that it would be nice to have addressed 
> if we take this route.
> 
> Superusers are unable to set anything higher priority than unprivileged 
> users. Any restrictions placed on SCHED_RR/FIFO for unprivileged users 
> affect superuser tasks as well. The default setting breaks the 
> definition of these policies, yet changing the setting to 100 gives 
> everyone full rt access.
> 
> ie it would be nice for there to be discrepancy between the default cpu 
> limits and priority levels available to unprivileged vs superusers, and 
> superusers' default settings to remain the same as current SCHED_RR/FIFO 
> behaviour.

I guess it would be a simple matter of throwing on another 100 rt 
priorities that can only be set by CAP_SYS_NICE, and limiting 
selectively based on the rt_priority.

Cheers,
Con

--------------enigBFA20CF74A9E960650682A3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9P/MZUg7+tp6mRURAlcjAJ0a8fhHYcCNchkWkz0avQv7R0C+RwCghDcy
kIkMzM+/ofXKkpRLxBSSvDc=
=fe98
-----END PGP SIGNATURE-----

--------------enigBFA20CF74A9E960650682A3A--
