Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVKPIdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVKPIdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVKPIdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:33:47 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:21905 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030225AbVKPIdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:33:46 -0500
Date: Wed, 16 Nov 2005 09:33:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, pavel@suse.cz,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] race condition in fs/compat.c with compat_sys_ioctl
Message-ID: <20051116083359.GB14829@elte.hu>
References: <1131821278.5047.8.camel@localhost.localdomain> <5bdc1c8b0511121725u6df7ad9csb9cb56777fa6fe64@mail.gmail.com> <Pine.LNX.4.58.0511122149020.25152@localhost.localdomain> <5bdc1c8b0511121914v12dc4402u424fbaf416bf3710@mail.gmail.com> <1131853456.5047.14.camel@localhost.localdomain> <5bdc1c8b0511130634h501fb565v58906bdfae788814@mail.gmail.com> <1131994030.5047.17.camel@localhost.localdomain> <5bdc1c8b0511141057l60a2e778x89155cd5484d532f@mail.gmail.com> <1132115386.5047.61.camel@localhost.localdomain> <p73y83pp25r.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y83pp25r.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> > 
> > That's the problem. I found out that one ioctl might sleep holding the
> > sem and won't be woken up until another process calls another ioctl to
> > wake it up. But unfortunately, the one waking up the sleeper will block
> > on the sem.  (the killer was tty_wait_until_sent)
> 
> You should have looked into mainline first. The semaphore is already 
> gone because it wasn't even needed anymore.

well 2.6.14 isnt _that_ old :-) But in any case, it's great that the 
semaphore is gone!

	Ingo
