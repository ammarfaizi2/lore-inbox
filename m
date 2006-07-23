Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWGWIRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWGWIRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 04:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWGWIRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 04:17:03 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:26861 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1750748AbWGWIRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 04:17:01 -0400
Date: Sun, 23 Jul 2006 10:16:04 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, torvalds@osdl.org,
       bunk@stusta.de, lethal@linux-sh.org, hirofumi@mail.parknet.co.jp
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060723081604.GD27566@kiste.smurf.noris.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de> <20060722173649.952f909f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060722173649.952f909f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Azndrew Morton:
> What is 2.6.17-test-1.29?

My test build; standard kernel during bisection.

> How do you know that 5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa caused this?
> 
git bisect.

> Are you able to test the below?  It should fix up the reporting.
> 
Applied.

> Are you able to compare the present bootlog with the 2.6.17 bootlog?
> 
Sure. The diff says:

 checking TSC synchronization across 4 CPUs:
+CPU#0 had 748437 usecs TSC skew, fixed it up.
+CPU#1 had 748437 usecs TSC skew, fixed it up.
+CPU#2 had -748437 usecs TSC skew, fixed it up.
+CPU#3 had -748437 usecs TSC skew, fixed it up.
 Brought up 4 CPUs
-migration_cost=4000,8000
+migration_cost=85,1724

... but apparently, that skew is not corrected.

These numbers do match the difference in observed "date" outputs.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The first place you look for something
is the last place you'd expect to find it.
