Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUJAWsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUJAWsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUJAWrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:47:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:19606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266839AbUJAWo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:44:27 -0400
Date: Fri, 1 Oct 2004 15:44:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <joq@io.com>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041001154410.M1924@build.pdx.osdl.net>
References: <20040930211408.GE4273@conscoop.ottawa.on.ca> <1096581213.24868.19.camel@krustophenia.net> <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net> <87k6ubcccl.fsf@sulphur.joq.us> <1096663225.27818.12.camel@krustophenia.net> <20041001142259.I1924@build.pdx.osdl.net> <1096669179.27818.29.camel@krustophenia.net> <20041001152746.L1924@build.pdx.osdl.net> <1096669977.27818.35.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1096669977.27818.35.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 01, 2004 at 06:32:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2004-10-01 at 18:27, Chris Wright wrote:
> > I agree with that.  That's not my objection.  It's about pushing code
> > (albeit it's small and non-invasive) into the kernel that can be done in
> > userspace, that's all.
> 
> How do you envision this working?  I am sure it's possible, I think I am
> just not seeing how it would be different in practice.

As of now, the only practical part to move out is just that tiny
mlock bit.  Using pam_limits seems the best choice there.  This burdens
the audio folks with a documentation task (describing not only how
to turn this rlimits feature on properly, although that'd be welcome
since the docs in that area are lacking, but also doc for the module
re: SCHED_FIFO).  A general solution is pam_cap, and making capabilities
inherit in a sane way (Andy L. and I have code to move in that direction).
One step shy of that, is extend what you've done across the capability
set, so that it could solve problems similar to yours but with different
cap requirements.  Pushing more bits into rlimits is possible as well,
but could get unruly.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
