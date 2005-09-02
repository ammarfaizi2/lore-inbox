Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030638AbVIBBae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030638AbVIBBae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030639AbVIBBae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:30:34 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:27114 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1030638AbVIBBad convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:30:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ah9eldlFIF3fNHRrDyPk01hkMd70BApdhJ4zpmNnoNhNJVU4uH9Xmx2rPCHma2m6MJrZVJ218UI/Oin/a8bg/pxK3/GQezYScJdwu0U8vz69lcTVIcXu+4D2XKNi9cxFJOXR29tMzmEhpFMpFKDpewaN3mDgQkN90AhDRCHelWU=
Message-ID: <67029b17050901182964c80289@mail.gmail.com>
Date: Fri, 2 Sep 2005 09:29:25 +0800
From: Zhou Yingchao <yingchao.zhou@gmail.com>
Reply-To: yingchao.zhou@gmail.com
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

 In badness, the tasklist_lock has been hold. And when an exit signal
delived to it because other thread call do_group_exit, it need to hold
the tasklist_lock first, so we are protected.
  
-- 
Yingchao Zhou
