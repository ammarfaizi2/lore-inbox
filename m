Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422986AbWBOF7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422986AbWBOF7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422987AbWBOF7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:59:04 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:54892 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422986AbWBOF7D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:59:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMr3IPCoF4aIUK+1knsNw6NVf0qIbo1c/aqEIWCynRZiQmNDsjtvWLXRsB/4o1z4/iqZ8aYJ8q5BqR0jFBmKODLBKpswObkiSs6OqOgdi2oqq3/wgtgreu98Ifj035qMFOaXNnsKaEN6F8jxotiW1LGqGcL5tiHoR4UxhfSgCgg=
Message-ID: <67029b170602142159i7a2bf1b2w@mail.gmail.com>
Date: Wed, 15 Feb 2006 13:59:01 +0800
From: Zhou Yingchao <yingchao.zhou@gmail.com>
To: bibo mao <bibo_mao@linux.intel.com>
Subject: Re: Fwd: [PATCH] kretprobe instance recycled by parent process
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43F324CD.1020807@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43F3059A.9070601@linux.intel.com>
	 <67029b170602141936v69b85832q@mail.gmail.com>
	 <67029b170602141939v4791ac72l@mail.gmail.com>
	 <43F324CD.1020807@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> When kretprobe probe schedule() function, if probed process exit then
> >> schedule() function will never return, so some kretprobe instance will
> >> never be recycled. By this patch the parent process will recycle
> >> retprobe instance of probed function, there will be no memory leak of
> >> kretprobe instance. This patch is based on 2.6.16-rc3.
> >
> > Is there any process which can exit without go through the do_exit() path?
> > --
> When process exits through do_exit() function, it will call schedule()
> function. But if schedule() function is probed by kretprobe, this time
> schedule() function will not return never because process has exited.
>
> bibo,mao
>

In the original path, doesn't the call path of
do_exit()->exit_thread()->kprobe_flush_task(current) recycle the
kretprobe instance? Is there anything misundstood?
--
Yingchao Zhou
***********************************************
 Institute Of Computing Technology
 Chinese Academy of Sciences
 Tel(O) : 010-62613792-28
***********************************************
