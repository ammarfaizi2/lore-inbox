Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269231AbUIYE10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269231AbUIYE10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 00:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269230AbUIYE10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 00:27:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32178 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269231AbUIYE01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 00:26:27 -0400
Message-ID: <4154F349.1090408@redhat.com>
Date: Fri, 24 Sep 2004 21:25:45 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [time] add support for CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Lameter wrote:

> +int do_posix_clock_thread_gettime(struct timespec *tp)
> +{
> +	jiffies_to_timespec(get_jiffies_64()-current->start_time, tp);
> +	return 0;
> +}
> +
> +int do_posix_clock_process_gettime(struct timespec *tp)
> +{
> +	jiffies_to_timespec(get_jiffies_64()-current->group_leader->start_time, tp);
> +	return 0;
> +}
> +

This is pretty useless.  Why would you need kernel support for this, it
just measures realtime.

We have an implementation of the CPU time in glibc which can easily be
changed to support clocks of this precision if there are no usable
timestamp counters (which is what is currently used).

And all this is not really what was really meant by "CPU time" in the
POSIX spec.  We hijacked this symbol, maybe incorrectly so.  What is
really meant is how much time a process/thread actually _uses_ the CPU
(hence the name).  I.e., the information contained in struct rusage.

For this I would love to get kernel support and we hopefully have soon a
patch for this.

- --
? Ulrich Drepper ? Red Hat, Inc. ? 444 Castro St ? Mountain View, CA ?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBVPNJ2ijCOnn/RHQRAjXeAJ0dUlvRmh6eDJLD6BtmjI3CNWC7pQCfZvAG
wSJclC6wagAwrYqL7/rdpVs=
=SLxp
-----END PGP SIGNATURE-----
