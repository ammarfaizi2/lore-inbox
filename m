Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUJITLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUJITLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUJITLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:11:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:14233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267304AbUJITLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:11:46 -0400
Date: Sat, 9 Oct 2004 12:11:41 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041009121141.X2357@build.pdx.osdl.net>
References: <1097269108.1442.53.camel@krustophenia.net> <20041008144539.K2357@build.pdx.osdl.net> <1097272140.1442.75.camel@krustophenia.net> <20041008145252.M2357@build.pdx.osdl.net> <1097273105.1442.78.camel@krustophenia.net> <20041008151911.Q2357@build.pdx.osdl.net> <20041008152430.R2357@build.pdx.osdl.net> <87zn2wbt7c.fsf@sulphur.joq.us> <20041008221635.V2357@build.pdx.osdl.net> <87is9jc1eb.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87is9jc1eb.fsf@sulphur.joq.us>; from joq@io.com on Sat, Oct 09, 2004 at 11:16:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jack O'Quin (joq@io.com) wrote:
> Thanks.  I was familiar with gid, and egid from other Unix kernels,
> but fsgid is new to me.  
> 
> In what cases does it *differ* from the effective group ID?

If the program calls setfsgid.  It would typically only do this if it
wanted to assume a new gid for filesystem access on behalf of someone
else (e.g. file server).

> > --- security/realtime.c~rm_CONFIG_SECURITY	2004-10-08 16:16:35.000000000 -0700
> > +++ security/realtime.c	2004-10-08 21:06:28.020084984 -0700
> > @@ -66,7 +66,7 @@
> >  	if ((gid == e_gid) || (gid == current->gid))
> >  		return 1;
> >  
> > -	return in_group_p(gid);
> > +	return in_egroup_p(gid);
> >  }
> >  
> >  static int realtime_bprm_set_security(struct linux_binprm *bprm)
> 
> This adds a test against current->egid in addition to the explicit
> check of current->gid.  I don't see any problem with that.  AFAICT,
> the current->gid check is still useful.

The egid makes a setgid-audio program be meaningful as well.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
