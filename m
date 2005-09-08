Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbVIHCJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVIHCJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 22:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVIHCJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 22:09:12 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:56205 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932560AbVIHCJL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 22:09:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=alMpkYADWks4UY+gXu+PVS3svBkBEW+4MrOKgwiGDjfsHRYMKP57rxTh4zPED6btrswtPiIlhh2GO8OaoODvrGFnEYuPdi4c/l8675iUse4sTUSq51Ws4G+TDcJX1JiLUPby+WvtRi6WTmbfnmjfZjYQ+HEUKQMYu7lrNfPDBjA=
Message-ID: <2cd57c900509071909787f43f2@mail.gmail.com>
Date: Thu, 8 Sep 2005 10:09:05 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Richard Hayden <rahaydenuk@yahoo.co.uk>
Subject: Re: A couple of OOM killer races
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43176820.5060609@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43176820.5060609@yahoo.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, Richard Hayden <rahaydenuk@yahoo.co.uk> wrote:
> Hi all,
> 
> It appears there is no protection in badness() (called by
> out_of_memory() for each process) when it reads p->mm->total_vm. Another
> processor (or a kernel preemption) could presumably run do_exit and then
> exit_mm, freeing the process in question's reference to its mm just
> after the (!p->mm) check but before it reads p->mm->total_vm, making the
> latter reference a null pointer reference.

We have read_lock(&tasklist_lock); .

> 
> Also there appears to be no protection when we set p->time_slice in
> __oom_kill_task(). Am I right in thinking that this field should be
> protected by the appropriate runqueue lock, at least this is what
> scheduler_tick() seems to use?

ditto

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
