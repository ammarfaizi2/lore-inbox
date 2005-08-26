Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVHZQlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVHZQlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbVHZQlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:41:31 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:26044 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965106AbVHZQla convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:41:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZXsjtltk6g8LhTab4aXlSLgx1+38jmiaSVuktDWCq0d6jM71VkE+4rPGxaup2Cbc62/1Y2oI42i0x1w6qgcmW8Xn5PatTFiN6Q/IdKLyyvjKJ4XZ8Ka79lxeTWev5DJgcWUMHYW6musVN6H96o+DJGJTZlZv6PVh9DD7+lrmHm8=
Message-ID: <29495f1d050826094144ef2998@mail.gmail.com>
Date: Fri, 26 Aug 2005 09:41:29 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Richard Stover <richard@ucolick.org>
Subject: Re: waiting process in procfs read
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <29495f1d05082609407c147df7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <430F3C6B.7070303@ucolick.org>
	 <29495f1d05082609407c147df7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/05, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> On 8/26/05, Richard Stover <richard@ucolick.org> wrote:
> > I submitted this as a bugzilla kernel bug report but was directed here.
> > Perhaps someone can help me.
> >
> > I have a device driver developed with 2.4 kernels. I've ported
> > it to the 2.6 kernel (FC3) and it all works fine except for one
> > aspect of procfs.
> 
> <snip>
> 
> > THE PROBLEM: In FC3 (2.6.11-13_FC3) the reading process blocks but it never
> > wakes up.
> 
> <snip>
> 
> >        if (offset == 0) {
> >
> >            printk("####%s waiting event %x\n",__FUNCTION__,
> >                (unsigned int)&dev->read_proc_wait);
> >
> >            wait_event_interruptible(dev->read_proc_wait,(offset != 0));
> >            printk("####%s WOKE UP\n",__FUNCTION__);
> 
> <snip>
> 
> > /*      Wake up anyone waiting on reading /proc/readXw                  */
> >        printk(KERN_INFO "#### waking up anyone waiting on read_proc_wait event %x\n",
> >                (unsigned int)&dev->read_proc_wait);
> >
> >        wake_up_interruptible(&dev->read_proc_wait);
> 
> Your symptoms indicate to me that the "event" in
> wait_event_interruptible() has not been satisifed, and thus the
> (potentially) infinite loop in wait_event_interruptible() is
> continuing, e.g. event still is 0. A signal (as you've specified

::sigh::, offset still is 0, not event :)

Thanks,
Nish
