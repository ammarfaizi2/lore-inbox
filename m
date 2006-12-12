Return-Path: <linux-kernel-owner+w=401wt.eu-S932572AbWLMAAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWLMAAg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWLMAAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:00:36 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:41113 "EHLO
	liaag1ab.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932572AbWLMAAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:00:35 -0500
Date: Tue, 12 Dec 2006 18:49:57 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2/5] Paravirt cpu batching.patch
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>
Message-ID: <200612121853_MC3-1-D4D2-191A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061212225430.GC10475@sequoia.sous-sol.org>

On Tue, 12 Dec 2006 14:54:30 -0800, Chros Wright wrote:

> > --- a/arch/i386/kernel/process.c    Tue Dec 12 13:50:50 2006 -0800
> > +++ b/arch/i386/kernel/process.c    Tue Dec 12 13:50:53 2006 -0800
> > @@ -665,6 +665,37 @@ struct task_struct fastcall * __switch_t
> >     load_TLS(next, cpu);
> >  
> >     /*
> > +    * Restore IOPL if needed.
> > +    */
> > +   if (unlikely(prev->iopl != next->iopl))
> > +           set_iopl_mask(next->iopl);
>
> Small sidenote that this bit undoes a recent change from Chuck Ebbert, which
> killed iopl_mask update via hypervisor.

This whole thing needs a proper fix IMO.  I posted something a while back
but Andi didn't like it, I guess.

-- 
MBTI: IXTP

