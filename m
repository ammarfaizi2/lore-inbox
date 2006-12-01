Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967672AbWLAR0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967672AbWLAR0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967674AbWLAR0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:26:15 -0500
Received: from smtp-out.google.com ([216.239.45.12]:18597 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S967672AbWLAR0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:26:14 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ZtNfL1rXDnpvh9frd2ZlRjGY1rc5MZ9HX0w10sUJqmmG238IISLIQQI00rLHcf+es
	msItEqH+Y+ExIfgldrZaw==
Message-ID: <6599ad830612010925w17f56643n8c92f179ea28b828@mail.gmail.com>
Date: Fri, 1 Dec 2006 09:25:54 -0800
From: "Paul Menage" <menage@google.com>
To: vatsa@in.ibm.com
Subject: Re: [Patch 1/3] Miscellaneous container fixes
Cc: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, winget@google.com, rohitseth@google.com,
       devel@openvz.org, "Ingo Molnar" <mingo@elte.hu>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, Dipankar <dipankar@in.ibm.com>,
       "Balbir Singh" <balbir@in.ibm.com>
In-Reply-To: <20061201164632.GA26550@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061123120848.051048000@menage.corp.google.com>
	 <20061123123414.641150000@menage.corp.google.com>
	 <20061201164632.GA26550@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> This patches fixes various bugs I hit in the recently posted container
> patches.
>
> 1. If a subsystem registers with fork/exit hook during bootup (much
>    before rcu is initialized), then the resulting synchronize_rcu() in
>    container_register_subsys() hangs. Avoid this by not calling
>    synchronize_rcu() if we arent fully booted yet.
>
> 2. If cpuset_create fails() for some reason, then the resulting
>    call to cpuset_destroy can trip. Avoid this by initializing
>    container->...->cpuset pointer to NULL in cpuset_create().
>
> 3. container_rmdir->cpuset_destroy->update_flag can deadlock on
>    container_lock(). Avoid this by introducing __update_flag, which
>    doesnt take container_lock().

Ah - this may be the lockup that PaulJ hit.

Thanks for these fixes.

Paul
