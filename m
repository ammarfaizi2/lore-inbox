Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268963AbUIQUB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268963AbUIQUB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268972AbUIQUBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:01:55 -0400
Received: from mail.joq.us ([67.65.12.105]:63135 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S268963AbUIQUBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:01:54 -0400
To: torbenh@gmx.de
Cc: Jody McIntyre <realtime-lsm@modernduck.com>,
       James Morris <jmorris@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Realtime LSM
References: <20040916023118.GE2945@conscoop.ottawa.on.ca>
	<87d60mrf8i.fsf@sulphur.joq.us>
	<20040916155127.GG2945@conscoop.ottawa.on.ca>
	<87zn3qoyrt.fsf@sulphur.joq.us>
	<20040917070857.GB4476@mobilat.informatik.uni-bremen.de>
From: "Jack O'Quin" <joq@io.com>
Date: 17 Sep 2004 15:01:06 -0500
In-Reply-To: <20040917070857.GB4476@mobilat.informatik.uni-bremen.de>
Message-ID: <87hdpwpsvx.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torbenh@gmx.de writes:

> On Thu, Sep 16, 2004 at 01:27:02PM -0500, Jack O'Quin wrote:
> > It recently occurred to me that jackstart might be able to detect this
> > situation and exec jackd, anyway.  (AFAICT, the only reasonably
> > POSIX-compliant method for detecting that a process has the
> > "appropriate permission" to do something is trying it to see whether
> > it returns EPERM.)
> 
> how should jackstart detect the situation ?
> its running SUID root and is allowed to do everything.

I was thinking that it could drop root privileges and try creating a
realtime thread.  But, then I realied it would be better (and simpler)
for `jackstart' to exec `jackd' unconditionally, even when the
required capabilities are not available.  Let `jackd' figure out for
itself what it can actually do.

That is what I meant about trying the operation being the only
reliable test.  Jackstart should not give up just because one
privilege mechanism is unavailable.  It cannot know all the possible
reasons why jackd might or might not have access to realtime
resources.  Its job is simply to pass the capabilities if they are
available.
-- 
  joq
