Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUIOPb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUIOPb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUIOPb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:31:26 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60363 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S266459AbUIOPbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:31:12 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Eric St-Laurent <ericstl34@sympatico.ca>,
       Free Ekanayaka <free@agnula.org>, free78@tin.it,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>, luke@audioslack.com,
       nando@ccrma.stanford.edu,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20040914183202.GA20316@elte.hu>
References: <OF85F4CCF4.D54BACFC-ON86256F0E.00510311-86256F0E.00510399@raytheon.com>
	 <20040914183202.GA20316@elte.hu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1095262011.28981.192.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 11:26:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 14:32, Ingo Molnar wrote:
> it seems a bit odd. avc_has_perm_noaudit() calls avc_insert(), and from
> the entry to avc_insert(), to the memcpy() call done by
> avc_has_perm_noaudit() there were 204 usecs spent. That's alot of time -
> 175 thousand cycles! Now if you check out the code between line 1009 and
> 1019 in security/selinux/avc.c, there's little that could cause this
> amount of overhead. avc_insert() itself is rather simple - it does an
> avc_claim_node() call which is an inlined function so it doesnt show up
> in the trace. That function _might_ have called acv_reclaim_node() which
> seems to do a linear scan over a list - i dont know how long that list
> is typically but it could be long. Could you add "#define inline" near
> the top of avc.c (but below the #include lines) so that we can see how
> the overhead is distributed in the future?

May be rendered moot by the RCU patches for SELinux, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=109386501021596&w=2

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

