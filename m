Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286111AbRLJAcE>; Sun, 9 Dec 2001 19:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286120AbRLJAby>; Sun, 9 Dec 2001 19:31:54 -0500
Received: from zero.tech9.net ([209.61.188.187]:36102 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S286111AbRLJAbj>;
	Sun, 9 Dec 2001 19:31:39 -0500
Subject: Re: [PATCH] Make highly niced processes run only when idle
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Anthony DeRobertis <asd@suespammers.org>, root <r6144@263.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011209184656.E8846@redhat.com>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org>
	<1007939114.878.1.camel@phantasy> <20011209181643.A8846@redhat.com>
	<1007940066.878.7.camel@phantasy>  <20011209184656.E8846@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 09 Dec 2001 19:30:29 -0500
Message-Id: <1007944229.878.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-09 at 18:46, Benjamin LaHaise wrote:

> Actually, yes: in entry.S the ret_from_syscall path which calls schedule 
> can be changed to pass a parameter indicating it is returning to userspace 
> afterwards which would let schedule know the bump is not needed.

Hmm, what if we only boosted it based on something like this:

	if (p->policy == SCHED_IDLE) {
		weight = p->counter;
		if (p->lock_depth >= 0 || signal_pending(p))
			/* boost somehow ... */
	}

(I'm writing the patch now :>)

Would it still make sense to only boost it in kernel space ?

	Robert Love

