Return-Path: <linux-kernel-owner+w=401wt.eu-S932992AbWL0Qaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992AbWL0Qaa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 11:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932991AbWL0Qaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 11:30:30 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:62206 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992AbWL0Qaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 11:30:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oIfgKYQZ5SA/1qx2K+n55KzkhKCOSSf94a+HksTE2NYBJ+HexqHFO+3NKBl4m0LsglMlxwDE599nLE1kZEBNmZnYpQy5rutVTUCgXtTipsjE3CzfnowZVrKd1ly9fu3nPV9xwzfrAx/qvzSFTF+4c06kko2Yk0l0Nzu8NNbKuwY=
Message-ID: <b0943d9e0612270830o37519a4au666fcc50408883f6@mail.gmail.com>
Date: Wed, 27 Dec 2006 16:30:29 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1167236618.3281.3986.camel@laptopd505.fenrus.org>
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
	 <1167236618.3281.3986.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2006-12-27 at 16:14 +0000, Catalin Marinas wrote:
> > On 17/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> > > it would be nice to record 1) the jiffies value at the time of
> > > allocation, 2) the PID and the comm of the task that did the allocation.
> > > The jiffies timestamp would be useful to see the age of the allocation,
> > > and the PID/comm is useful for context.
> >
> > Trying to copy the comm with get_task_comm, I get the lockdep report
> > below, caused by acquiring the task's alloc_lock. Any idea how to go
> > around this?
>
> well you take the lock from irq context, which means it needs to use
> _irqsave/restore everywhere. (and all locks taken inside it must be irq
> safe as well)
>
> maybe.. not use  comm in irq context? it doesn't actually mean anything
> there anyway...

Thanks. Done this and it is ok now.

-- 
Catalin
