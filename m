Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVAKVQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVAKVQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVAKVP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:15:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:29830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262819AbVAKVOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:14:01 -0500
Date: Tue, 11 Jan 2005 13:14:00 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111131400.L10567@build.pdx.osdl.net>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050111205809.GB21308@elte.hu>; from mingo@elte.hu on Tue, Jan 11, 2005 at 09:58:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> * Chris Wright <chrisw@osdl.org> wrote:
> > I don't think they lie quite so neatly on this boundary.  There's one
> > fundamental difference which is how the dynamic priority is adjusted
> > which alters the basic preemptibility rules.
> 
> but at nice level -20 this adjustment is at most +5 priority levels -
> i.e. down to an equivalent of nice -15. Consider that a nice 0 task can
> at most get a -5 priority boost gives a nice -5 task worst-case - so the
> nice -20 task still preempts the lower prio task.

Yeah, I realize it provides some safety, I just wanted to point out
the fundamental difference.  And one point being made is that it's
the occasional worst case latencies which are the problem.  Dynamic
adjustments could be one culprit for this.

Hmm, I wonder if this could have anything to do with it.  These are
within striking range:

  PID COMMAND          NI PRI
    9 events/1        -10  34
  931 kcryptd/1       -10  33
  930 kcryptd/0       -10  34
    8 events/0        -10  34
  892 ata/1           -10  34
  891 ata/0           -10  34
 3747 udevd           -10  33
   26 kacpid          -10  31
  238 aio/1           -10  34
  237 aio/0           -10  31
  117 kblockd/1       -10  34
  116 kblockd/0       -10  34
   10 khelper         -10  34

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
