Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUJEFzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUJEFzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268816AbUJEFzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:55:55 -0400
Received: from mail.joq.us ([67.65.12.105]:61060 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S268799AbUJEFzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:55:51 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1094967978.1306.401.camel@krustophenia.net>
	<20040920202349.GI4273@conscoop.ottawa.on.ca>
	<20040930211408.GE4273@conscoop.ottawa.on.ca>
	<1096581213.24868.19.camel@krustophenia.net>
	<87pt43clzh.fsf@sulphur.joq.us>
	<20040930182053.B1973@build.pdx.osdl.net>
	<87k6ubcccl.fsf@sulphur.joq.us>
	<1096663225.27818.12.camel@krustophenia.net>
	<20041001142259.I1924@build.pdx.osdl.net>
	<1096669179.27818.29.camel@krustophenia.net>
	<20041001152746.L1924@build.pdx.osdl.net>
From: "Jack O'Quin" <joq@io.com>
Date: 05 Oct 2004 00:55:43 -0500
In-Reply-To: <20041001152746.L1924@build.pdx.osdl.net>
Message-ID: <877jq5vhcw.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> * Lee Revell (rlrevell@joe-job.com) wrote:
> > OK, poor choice of words.  Correctness of course comes before ease of
> > use.  I believe the realtime-lsm module satisfies both requirements.
> 
> I agree with that.  That's not my objection.  It's about pushing code
> (albeit it's small and non-invasive) into the kernel that can be done in
> userspace, that's all.

> > > Hrm, I guess we'll have to agree to disagree.  The whole point of the
> > > mlock rlimits code is to enable this policy to be pushed to userspace.
> > > A generic method of enabling capabilities is the best way to go, long
> > > term.  Any interest in pursuing that?

None here.  I prefer to spend my time on audio development than kernel
code.  There are plenty of good kernel developers already.

I agree that a generic capabilities module would be nice to have,
mainly because of current difficulties with stacking multiple LSM's.
However, if there were a good stacking facility, then multiple,
simple, application-oriented modules like the realtime-lsm might be
even better in some respects.

> > I did not mean to imply that I disagree with the realtime-lsm approach. 
> > Obviously some kernel support is required, and realtime-lsm seems to
> > solve the problem with the minimum possible change to the kernel.  And
> > above all it is a proven working solution that has been field tested for
> > months by many, many users.
> 
> Clearly it's useful for the audio folks.  Whether it's the right thing
> to go into the kernel is all that's in question here.  Do we agree it's
> a stopgap measure making up for lack of a better general solution?

Sure, I agree.  But, I suspect that gap looks much larger from my
perspective than yours.  :-)

We would never have developed this LSM had there not been a serious
need.  Audio developers have been struggling for years with the need
to apply specialized kernel patches to get acceptable realtime
operation.  Audio is very intolerant of realtime glitches.  They cause
nasty pops in the output.  And, large audio applications should not
run as `root'.  The 2.4 "capabilities patch" was never a satisfactory
solution.

Thanks to the good work being done on 2.6, we are now close to being
able to do serious realtime work with standard kernels available
everwhere.  The LSM framework is an important element of that
solution, with the realtime LSM a small but essential component,
because it makes these features available without excessive
administrative burden.  Many musicians have a Mac or Windows
background.  They are not willing to perform complex system
administration tasks to get good audio performance.  PAM is great for
sophisticated sysadmins on shared systems.  But, I seriously doubt
many musicians will be able to configure it correctly.  For a
single-user Digital Audio Workstation it is overkill.

So, even if you do provide a more general solution, I will probably
have to continue supporting the realtime-lsm interface throughout the
2.6 kernel life-cycle, as there will be enough users for it to be a
defacto standard.  If it is no longer needed in the 2.8 timeframe, I
can drop support then.

It's hard to say how many people use realtime-lsm right now.
SourceForge lists about 1500 source downloads over the last six
months.  Binary copies are included in the most popular audio-oriented
distributions, including Planet CCRMA and DeMuDi.  I guess there are
probably no more than a few thousand active users.

These are already enough that I feel committed to providing whatever
module updates are required for all official 2.6 kernel versions.
Including the LSM in the kernel would distribute it to more users.  It
would also simplify maintenance slightly.  I currently maintain a
single source that works for all 2.6 versions.  As a practical matter,
I may ignore some of the pre-2.6.6 issues in the next release.

Is that what you meant by stop-gap?  :-)
-- 
  joq
