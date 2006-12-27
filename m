Return-Path: <linux-kernel-owner+w=401wt.eu-S932914AbWL0RCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbWL0RCy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbWL0RCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:02:54 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:8516 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbWL0RCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:02:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RMfJ8KtHGHO/1uRYdNgDumDuB3kTsk4PIDSib1NbHiBmuCCywgo2TFLYfv6o7sHdCM0TbimsiHxU2ahnk7tb8sxd5B2IiLIgPhS0WBIBa26F3pWXOiI4ZvcM9G+0lh2eScjEqai4U163bDLfEdzIk9hSVGHEDSsSfIihyx9TzM4=
Message-ID: <b0943d9e0612270902u4baf5d65v948433aac55afaac@mail.gmail.com>
Date: Wed, 27 Dec 2006 17:02:52 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227164745.GA10077@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu>
	 <20061217092828.GA14181@elte.hu> <20061217094143.GA15372@elte.hu>
	 <b0943d9e0612270814m30fe8813mad20f22f9d188896@mail.gmail.com>
	 <20061227164745.GA10077@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
>
> > On 17/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> > >it would be nice to record 1) the jiffies value at the time of
> > >allocation, 2) the PID and the comm of the task that did the allocation.
> > >The jiffies timestamp would be useful to see the age of the allocation,
> > >and the PID/comm is useful for context.
> >
> > Trying to copy the comm with get_task_comm, I get the lockdep report
> > below, caused by acquiring the task's alloc_lock. Any idea how to go
> > around this?
>
> just memcpy p->comm without any locking. It's for the current task,
> right? That does not need any locking.

Yes, it is for the current task. I also added an in_interrupt() test
since the current->comm is not relevant in this case as Arjan pointed
out.

-- 
Catalin
