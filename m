Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUJIFQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUJIFQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 01:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUJIFQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 01:16:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:59325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266362AbUJIFQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:16:41 -0400
Date: Fri, 8 Oct 2004 22:16:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041008221635.V2357@build.pdx.osdl.net>
References: <877jq5vhcw.fsf@sulphur.joq.us> <1097193102.9372.25.camel@krustophenia.net> <1097269108.1442.53.camel@krustophenia.net> <20041008144539.K2357@build.pdx.osdl.net> <1097272140.1442.75.camel@krustophenia.net> <20041008145252.M2357@build.pdx.osdl.net> <1097273105.1442.78.camel@krustophenia.net> <20041008151911.Q2357@build.pdx.osdl.net> <20041008152430.R2357@build.pdx.osdl.net> <87zn2wbt7c.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87zn2wbt7c.fsf@sulphur.joq.us>; from joq@io.com on Fri, Oct 08, 2004 at 08:01:27PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jack O'Quin (joq@io.com) wrote:
> Chris Wright <chrisw@osdl.org> writes:
> > use in_group_p
> 
> I looked at that, it wasn't clear to me whether to use in_group_p() or
> in_egroup_p().  How do you choose?

For most cases they'll be identical.  The difference is whether you're
comparing the fsgid or the egid.  The former is what's used for file
access, the latter might make more sense in your case.  However, in
99.9% of the cases you care about fsgid == egid, so it's a wash.  So,
in_egroup_p matches a bit better.  Relative to the other patches...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


--- security/realtime.c~rm_CONFIG_SECURITY	2004-10-08 16:16:35.000000000 -0700
+++ security/realtime.c	2004-10-08 21:06:28.020084984 -0700
@@ -66,7 +66,7 @@
 	if ((gid == e_gid) || (gid == current->gid))
 		return 1;
 
-	return in_group_p(gid);
+	return in_egroup_p(gid);
 }
 
 static int realtime_bprm_set_security(struct linux_binprm *bprm)
