Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVGPId5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVGPId5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVGPId5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:33:57 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:56845 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262097AbVGPIdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:33:14 -0400
Message-ID: <42D8C60E.8040807@tuxrocks.com>
Date: Sat, 16 Jul 2005 02:32:14 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [RFC][PATCH 1/6] new timeofday core subsystem
References: <1121484326.28999.3.camel@cog.beaverton.ibm.com>
In-Reply-To: <1121484326.28999.3.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> +extern nsec_t do_monotonic_clock(void);
This looks okay ...

> +/**
> + * do_monotonic_clock - Returns monotonically increasing nanoseconds
> + *
> + * Returns the monotonically increasing number of nanoseconds
> + * since the system booted via __monotonic_clock()
> + */
> +nsec_t do_monotonic_clock(void)
> +{
> +	nsec_t ret;
> +	unsigned long seq;
> +
> +	/* atomically read __monotonic_clock() */
> +	do {
> +		seq = read_seqbegin(&system_time_lock);
> +
> +		ret = __monotonic_clock();
> +
> +	} while (read_seqretry(&system_time_lock, seq));
> +
> +	return ret;
> +}

... but this conflicts with Nish's softtimer patches, which is
implemented slightly differently.  For those of us who are real gluttons
for punishment, and want both sets of patches, are there problems just
removing one of the do_monotonic_clock definitions?

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC2MYNaI0dwg4A47wRAiQoAJ9vUvpjE7KmhCNW7NJ6kfd0SuyvXwCg+NtN
pXqoz0v5Tbf5OMFjhYSzPp0=
=LT9E
-----END PGP SIGNATURE-----
