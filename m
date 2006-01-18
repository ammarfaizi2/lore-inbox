Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWARBJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWARBJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWARBJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:09:59 -0500
Received: from nlpproxy08.prodigy.net.mx ([148.235.52.28]:8692 "EHLO
	smtp.prodigy.net.mx") by vger.kernel.org with ESMTP id S932445AbWARBJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:09:58 -0500
Date: Tue, 17 Jan 2006 19:11:13 -0600
From: Gain Paolo Mureddu <gmureddu@prodigy.net.mx>
Subject: Re: [ck] Re: Problems building
In-reply-to: <200601181201.53427.kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Message-id: <43CD95B1.7010403@prodigy.net.mx>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Enigmail-Version: 0.93.0.0
X-imss-version: 2.035
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:3 C:4 M:4 S:4 R:4 (0.5000 0.5000)
References: <43CD8FB7.90508@prodigy.net.mx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Con Kolivas wrote:

> On Wed, 18 Jan 2006 11:45 am, Gain Paolo Mureddu wrote:
>
>> For some reason I am getting a strange message when I try to
>> build either -ck1 or 2, another message I tried to send to the
>> list seems to not have gotten where I intended to, I'm quoting
>> that message here also:
>
>
> The list is filtered due to my minimal resources and inability to
> have any formal spam filtering so only members or approved emails
> get through and everything else silently dropped. Sorry about any
> inconvenience. I've added your email to accept and cc'ed the
> mailing list now.
>
>> Gain Paolo Mureddu wrote:
>>
>>> So I have been struggling to get this kernel built, and
>>> apparently I've narrowed this down to the sched_iso3.2 and/or
>>> isobatch_ionice patches, however I can't be fully certain. Here
>>> is what is dumped to the console, I've gotten two dumps, this
>>> and one concerning sched.o, which I am still investigating. So
>>> here goes the dump:
>>>
>>> <build_dump> .... [snip] CC init/do_mounts_md.o In file
>>> included from include/linux/bio.h:25, from
>>> include/linux/blkdev.h:14, from include/linux/raid/md.h:21,
>>> from init/do_mounts_md.c:2: include/linux/ioprio.h: En la
>>> función ?task_nice_ioprio?: include/linux/ioprio.h:58: error:
>>> ?SCHED_BATCH? not declared here (first use in this function)
>>> include/linux/ioprio.h:58: error: (Each undeclared identifier
>>> is only reported once include/linux/ioprio.h:58: error: for
>>> each function it appears in.) include/linux/ioprio.h:60: error:
>>> ?SCHED_ISO? not declared here (first use in this function)
>>> make[1]: *** [init/do_mounts_md.o] Error 1 make: *** [init]
>>> Error 2 </build_dump> Anyone else with troubles in x86_64
>>> systems?
>>>
>>> TIA!
>>
>> I get the same error, thus far I know that the file in question
>> (iprio.h) inclues sched.h and that in sched.h SCHED_BATCH and
>> SCHED_ISO are defined, so why am I getting this error in the said
>> function, is beyond me.
>>
>> Any pointers?
>
>
> These errors do not occur with the full patch. Are you using any
> split patches or just the full patch? Separating out patches is not
> a trivial thing to do.
>
> Cheers, Con

I'm using the broken-out tree as I am trying to integrate the patches
into a custom Fedora Kernel (basically Fedora's kernel patches, with
CK added), and given the nature of RPM build (well not that, but the
way the .speck is put together for Fedora) I chose to go with the
broken out tree and apply most patches (those which are not repeted)
one by one. I apparently found out what the problem was: for some
reason schedbatch and schediso were failing at placing the #define's
in place for SCHED_BATCH and SCHED_ISO in sched.h, an easy fix when
done by hand, directly to the file in question. I am trying to see how
to merge these two into one, but you're right, I may be off better
going with the "full" version rather than the broken-out (it's given
me more head-aches than it is apparently worth having! hehe)

Thanks for your reply and for adding my e-mail, Con. I thought this
e-mail address was already allowed to send e-mail to the list...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDzZWwXM+XOp70dwoRAtvQAJ4lJu6AORDSxdqtJnL0ZCYIZLZJwgCeL/FK
bCzB0TqywrBPSReH175ZtMQ=
=xklM
-----END PGP SIGNATURE-----

