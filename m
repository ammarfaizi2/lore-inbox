Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUETCpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUETCpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 22:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbUETCpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 22:45:18 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:57696 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264815AbUETCpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 22:45:13 -0400
Date: Wed, 19 May 2004 22:44:55 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
In-reply-to: <40AB8CDF.8060408@free.fr>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org
Message-id: <200405192245.07235.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.6.1
References: <40AB8CDF.8060408@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 19 May 2004 12:35, matthieu castet wrote:
> hi,
>
> on monocpu machine (and maybe even on smp machine), when you try to
> acces to a cpu that don't exist (/dev/cpu/1/cpuid), cpuid (msr) call
> cpu_online, but on nosmp machine if the cpu!=0 this procude a BUG();
> So I add a check that verify if the cpu can exist before calling
> cpu_online.

Added a check? I think your patch is reversed.

Jeff.
 
- -  if (cpu >= num_possible_cpus() || !cpu_online(cpu))
+  if (!cpu_online(cpu))
     return -ENXIO;             /* No such CPU */

- -- 
Hegh QaQ law'
quvHa'ghach QaQ puS
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArBuwwFP0+seVj/4RArcUAJwNIuZ6RhDYaHfnLIjKkiyXrXjfgwCgytvY
hpqUVuBbNwragYDMkjNOm4w=
=8DZk
-----END PGP SIGNATURE-----
