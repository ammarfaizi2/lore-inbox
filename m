Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVHSDaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVHSDaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVHSDaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:30:18 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:57492 "HELO
	develer.com") by vger.kernel.org with SMTP id S1751073AbVHSDaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:30:17 -0400
Message-ID: <43055246.6020207@develer.com>
Date: Fri, 19 Aug 2005 05:30:14 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-4 (X11/20050815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Giovanni Bajo <rasky@develer.com>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4303DB48.8010902@develer.com.suse.lists.linux.kernel>	<20050818010703.GA13127@nineveh.rivenstone.net.suse.lists.linux.kernel>	<4303F967.6000404@yahoo.com.au.suse.lists.linux.kernel>	<43054D9A.7090509@develer.com.suse.lists.linux.kernel> <p73oe7usjee.fsf@verdi.suse.de>
In-Reply-To: <p73oe7usjee.fsf@verdi.suse.de>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Bernardo Innocenti <bernie@develer.com> writes:
> 
> It's really more a feature than a bug that it breaks so easily
> because they should be really using futexes instead, which
> have much better behaviour than any sched_yield ever could
> (they will directly wake up another process waiting for the
> lock and avoid the thundering herd for contended locks) 

Actually, I believe they should be using pthread synchronization
primitives instead of relying on Linux-specific functionality.
Glibc already uses futexes internally, so it's almost as efficient.

I've already suggested this to the OpenLDAP people, but with
my limited knowledge of slapd threading requirements, there
may well be a very good reason for busy-waiting with
sched_yield().  Waiting for their answer.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

