Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTKQTHZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTKQTHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:07:25 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:5764 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S263646AbTKQTHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:07:23 -0500
Message-ID: <3FB91C54.5020905@redhat.com>
Date: Mon, 17 Nov 2003 11:07:00 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
CC: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz> <20031117064832.GA16597@mail.shareable.org> <Pine.GSO.4.58.0311171236420.29330@Juliusz>
In-Reply-To: <Pine.GSO.4.58.0311171236420.29330@Juliusz>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Krzysztof Benedyczak wrote:
> In userspace we can assign one futex to
> every such a queue and pass it to kernel in mq_notify syscall. Then we can
> use FUTEX_FD to get file descriptors of all futexes and wait on them with
> poll(). On the kernel side it notification have to be triggered we change
> futex value and do FUTEX_WAKE.

Yes, this would be possible if FUTEX_FD wouldn't be useless as it is
implemented today (see the futex paper I announced here recently).  The
thing which makes FUTEX_WAIT work is the current value of the futex
which is passed to the kernel and based on which the userlevel code made
it decisions.  This part doesn't exist in case of using FUTEX_FD.


The main recent I suggested using futexes for the notification is that
it is flexible.  For now, we can use simple waiting by creating the
thread ahead of time.  This could change later when there is a reliable
multi-futex wait operation.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/uRxU2ijCOnn/RHQRArcGAJ921MfetyPy1ciyYE2C7SG6nm0RLQCfbbwh
AUFbyDBmQJGAd1Vk+20TaTc=
=o+cD
-----END PGP SIGNATURE-----

