Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUJHXM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUJHXM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUJHXM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:12:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:2182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265970AbUJHXM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:12:26 -0400
Date: Fri, 8 Oct 2004 16:12:05 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041008161205.T2357@build.pdx.osdl.net>
References: <877jq5vhcw.fsf@sulphur.joq.us> <1097193102.9372.25.camel@krustophenia.net> <1097269108.1442.53.camel@krustophenia.net> <20041008144539.K2357@build.pdx.osdl.net> <1097272140.1442.75.camel@krustophenia.net> <20041008145252.M2357@build.pdx.osdl.net> <1097273105.1442.78.camel@krustophenia.net> <20041008151911.Q2357@build.pdx.osdl.net> <20041008152430.R2357@build.pdx.osdl.net> <1097276726.1442.82.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1097276726.1442.82.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 08, 2004 at 07:05:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2004-10-08 at 18:24, Chris Wright wrote:
> > (relative to last one)
> > 
> > use in_group_p
> > 
> 
> Thanks!  These make the patch even smaller and more comprehensible. 
> Does this cover all the issues with the patch as I posted it?

The last bit is removing sysctls.  It'll take a bit more effort, as we
need a touch of infrastructure for it.  I'm working on that now.  Here's
a couple really minor ones.

- make realtime_bprm_set_security static
- don't mark exit_security __exit, it's called from an __init function

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--- security/realtime.c	2004-10-08 16:10:52.080357656 -0700
+++ security/realtime.c~in_group	2004-10-08 16:02:05.932344312 -0700
@@ -71,7 +71,7 @@
 	return in_group_p(gid);
 }
 
-static int realtime_bprm_set_security(struct linux_binprm *bprm)
+int realtime_bprm_set_security(struct linux_binprm *bprm)
 {
 
 	cap_bprm_set_security(bprm);
@@ -170,7 +170,7 @@
 
 static int secondary;	/* flag to keep track of how we were registered */
 
-static void exit_security(void)
+static void __exit exit_security(void)
 {
 	/* remove ourselves from the security framework */
 	if (secondary) {
