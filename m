Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268722AbUILNko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbUILNko (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 09:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbUILNko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 09:40:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28338 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268722AbUILNk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 09:40:28 -0400
Date: Sun, 12 Sep 2004 15:41:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, wli@holomorphy.com
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912134137.GA20136@elte.hu>
References: <20040912085609.GK32755@krispykreme> <1094991480.2626.0.camel@laptop.fenrus.com> <20040912122959.GN25741@krispykreme> <20040912124420.GA29587@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912124420.GA29587@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjanv@redhat.com> wrote:

> On Sun, Sep 12, 2004 at 10:30:00PM +1000, Anton Blanchard wrote:
> > 
> > Hmm can you point the 16bit counter out? I can create 1 million NPTL
> > threads on ppc64 easily, so why not?
> 
> /*
>  * the semaphore definition
>  */
> struct rw_semaphore {
>         /* XXX this should be able to be an atomic_t  -- paulus */
>         signed int              count;
> #define RWSEM_UNLOCKED_VALUE            0x00000000
> #define RWSEM_ACTIVE_BIAS               0x00000001
> #define RWSEM_ACTIVE_MASK               0x0000ffff
> 
> that counter is split in 2 16 bit entities....

the generic semaphore code can handle up to ~2^31 waiters. I once tried
it on x86, it seems to work fine.

	Ingo
