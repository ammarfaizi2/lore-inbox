Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310175AbSCABFm>; Thu, 28 Feb 2002 20:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310122AbSCABD4>; Thu, 28 Feb 2002 20:03:56 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:43226 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310276AbSCAA6b>; Thu, 28 Feb 2002 19:58:31 -0500
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: nfs-devel@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5: compile error in fs/filesystems.c
In-Reply-To: <87vgchi2v8.fsf@tigram.bogus.local>
	<15486.50159.606621.827886@notabene.cse.unsw.edu.au>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Fri, 01 Mar 2002 01:58:03 +0100
Message-ID: <87bse9hzok.fsf@tigram.bogus.local>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Neil Brown <neilb@cse.unsw.edu.au> writes:

> 2.5.6-pre2 already has a patch for this.

The compile error is gone, *but* ... :-)
With 2.5.6-pre2 you get nfsd support, wether you want it or
not. Consider this:

#undef CONFIG_NFSD
#undef CONFIG_NFSD_MODULE
#define CONFIG_MODULES

Now, this part is compiled into the kernel, although you haven't
requested it:

#if defined(CONFIG_MODULES)
	lock_kernel();

	if (nfsd_linkage ||
	    (request_module ("nfsd") == 0 && nfsd_linkage)) {
		__MOD_INC_USE_COUNT(nfsd_linkage->owner);
		unlock_kernel();
		ret = nfsd_linkage->do_nfsservctl(cmd, argp, resp);
		__MOD_DEC_USE_COUNT(nfsd_linkage->owner);
	} else
		unlock_kernel();
#endif

Did I miss something?

Regards, Olaf.
