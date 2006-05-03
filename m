Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWECUn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWECUn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWECUn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:43:28 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:26573 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751032AbWECUn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:43:27 -0400
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060503204504.GA15965@elte.hu>
References: <200604221503.k3MF3Ws8021873@dwalker1.mvista.com>
	 <20060503204504.GA15965@elte.hu>
Content-Type: text/plain
Date: Wed, 03 May 2006 13:43:25 -0700
Message-Id: <1146689006.3363.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 22:45 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > -		fddef = &get_cpu_var(fdtable_defer_list);
> > +		fddef = &__get_cpu_var(fdtable_defer_list);
> 
> ok, the bug you found is real - but i dont like the fix: now we will be 
> using smp_processor_id() in preemptible code, which will trip up under 
> DEBUG_PREEMPT. Since in this particular case any CPU is fine, 
> per_cpu(...,raw_smp_processor_id()) ought to do the trick. Mind to 
> update the patch?

Sure I can do it, not exactly high priority considering it's never been
observed ..

Daniel 

