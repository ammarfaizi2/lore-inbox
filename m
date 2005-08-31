Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbVHaR0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbVHaR0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVHaR0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:26:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:61340 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964896AbVHaR0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:26:13 -0400
Date: Wed, 31 Aug 2005 22:28:43 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, s0348365@sms.ed.ac.uk, kernel@kolivas.org,
       tytso@mit.edu, cfriesen@nortel.com, rlrevell@joe-job.com, trenn@suse.de,
       george@mvista.com, johnstul@us.ibm.com, akpm@osdl.org
Subject: Updated dynamic tick patches
Message-ID: <20050831165843.GA4974@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have cleaned up dynamic tick patch that Con last posted. One issue
that is still to be addressed precisely is recovering lost ticks.

This is supposedly much easier with something like ACPI PM timer, but
I found that the code which calculates lost ticks in timer_pm.c is
not accurate. I have attempted to fix it (in the patch that follows).
With the fix, time has remained stable for ~36 hrs on one machine,
but the same fix does not help in another machine (time speeds up
by couple of seconds after 4-6 hrs). Hence I consider that it needs 
some more rework. Suggestion on accurate lost-tick recovery are wellcome.

Using TSC to recover ticks also is more tricky and hence I have not
enabled TSC support in these patches.

This patch does not address those machines where all CPUs have to
be put to sleep simulaneously (otherwise they dont work well
or something like that), as pointed out by Tony. We could
add support for such machines in another release if they
are common enough to come by.


Following patches related to dynamic tick are posted in separate mails,
for convenience of review. The first patch probably applies w/o dynamic
tick consideration also.

Patch 1/3  -> Fixup lost tick calculation in timer_pm.c
Patch 2/3  -> Dyn-tick cleanups
Patch 3/3  -> Use lost tick information in dyn-tick time recovery 

These patches are against 2.6.13-rc6-mm2.

Con, would be great if you can upload a consolidated new version of
dyn-tick patch on your website!


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
