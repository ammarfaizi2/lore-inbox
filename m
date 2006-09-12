Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWILRm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWILRm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWILRm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:42:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43396 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030299AbWILRm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:42:57 -0400
Date: Tue, 12 Sep 2006 19:34:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] 2.6.18-rc6: hda is allready "IN USE" when booting / pi futex
Message-ID: <20060912173455.GB6236@elte.hu>
References: <20060907133357.GA30888@core> <20060912153932.GA14388@core>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20060912153932.GA14388@core>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Christian Leber <christian@leber.de> wrote:

> I wasted a day to track it down, unfortunally it's for me completly 
> unclear how this commit s related to IDE, it could be some timing 
> issue, but that is just guessing.

yeah, i too suspect that it's timing related.

> With 77ba89c5cf28d5d98a3cae17f67a3e42b102cc25 (linux-2.6 tree) i don't 
> have a problem (i booted it 21 times until now and it allways worked) 
> and b29739f902ee76a05493fb7d2303490fc75364f4 is the first bad commit.

but in case it's not timing related, could you do some more testing, 
ontop of the 77ba89c5cf28d5d98a3cae17f67a3e42b102cc25 tree?

The b29739f902ee76a05493fb7d2303490fc75364f4 patch is quite large, so i 
have created a finegrained, functional splitup of it:

  sched-cleanups.patch
  sched-add-task-rq-lock-ops.patch
  sched-add-rt-mutex-setprio.patch
  sched-pi-lock.patch
  sched-add-new-macros.patch
  sched-add-normal-prio.patch
  sched-use-has-rt-policy.patch
  sched-set-user-nice-fix.patch
  sched-use-normal-prio.patch

and have attached the resulting tarball. (Just extract the tarball into 
the known-good 77ba89c5cf28d5d98a3cae17f67a3e42b102cc25 tree, it will 
create a patches/ directory which includes a series file and the 
patches. If you install quilt then you can do 'quilt push' / 'quilt pop' 
to navigate in the patch-queue easily. Use 'quilt applied' to see the 
current patch-stack.)

i have ordered the patches within the splitup in a way so that the 
patches with more impact are at the end. The last patch 
(sched-use-normal-prio) is the one most likely to cause the problem (but 
sched-set-user-nice-fix and sched-use-has-rt-policy are possible 
candidates too). I have verified that every intermediate step builds and 
boots cleanly as well.

Could you try this patch-queue and figure which patch causes the failure 
you are seeing? That would reduce the search space quite significantly.

	Ingo

--bp/iNruPH9dso1Pn
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="patches.tar.gz"
Content-Transfer-Encoding: base64

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
lPBV4d9HeBZXAHgAAA==

--bp/iNruPH9dso1Pn--
