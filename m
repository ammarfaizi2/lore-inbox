Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263967AbRFEMOV>; Tue, 5 Jun 2001 08:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbRFEMOK>; Tue, 5 Jun 2001 08:14:10 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:23822 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S263967AbRFEMOD>;
	Tue, 5 Jun 2001 08:14:03 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.52578.97084.238201@argo.ozlabs.ibm.com>
Date: Tue, 5 Jun 2001 22:15:30 +1000 (EST)
To: Adrian Bunk <bunk@fs.tum.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
In-Reply-To: <Pine.NEB.4.33.0106051124320.18917-100000@mars.fachschaften.tu-muenchen.de>
In-Reply-To: <15132.23395.553496.50934@argo.ozlabs.ibm.com>
	<Pine.NEB.4.33.0106051124320.18917-100000@mars.fachschaften.tu-muenchen.de>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:

> Whatever the right policy is, the main concern in my initial mail was the
> _consistency_ of the kernel headers between different architectures.
> So when you want to flush out these programs I see no reason to
> inconsistetly change it only on one architecture.

Different architectures are maintained by different people who have
different perspectives on things.  The only thing you have any right
to expect any consistency in is the kernel API, and even there things
like error numbers etc. differ between architectures.

If you want consistency, you would either have to persuade Linus to
issue an edict or else persuade every single architecture maintainer
to do things the same way.  But if the motivation is to make it easier
for user-level programs to use things which are not intended to be
exported to userspace, then all you will achieve is that we will make
sure that you can't use those things from userspace.  And this
definitely includes things like atomics, bitops, memory barriers etc.
Take a copy by all means but don't rely on the kernel definitions for
your userspace programs.

It is the policy for all architectures that kernel headers should not
be used in userspace programs.  The "inconsistency" that you are
complaining about is only a difference in the extent to which
this policy is enforced.

Paul.
