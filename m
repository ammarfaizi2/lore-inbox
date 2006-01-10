Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWAJCNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWAJCNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWAJCNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:13:00 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:41970 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750940AbWAJCM7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:12:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NlhFWasdhrlhUJM0I1HlGDCUZcXACTvTo9RZh8NwFTg3FXx3m8I4VILSTPg5oBa9LjaJhy03TuBCc25gG70S9l874X8r8E5wyAUd8X7z9HiE21hxbQ23nzPMjUNYYzZbar68UI/fHbzeAKD+itoNuO/VSJlvmtfE2im1jpNSSik=
Message-ID: <9a8748490601091812x24aefae3oc0c6750c5321c3ab@mail.gmail.com>
Date: Tue, 10 Jan 2006 03:12:58 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: Athlon 64 X2 cpuinfo oddities
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73r77gx36u.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
	 <p73r77gx36u.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2006 02:49:13 +0100, Andi Kleen <ak@suse.de> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> writes:
> >
> > Well, first of all you'll notice that the second core shows a
> > "physical id" of 127 while the first core shows an id of 0.  Shouldn't
> > the second core be id 1, just like the "core id" fields are 0 & 1?
>
> In theory it could be an uninitialized phys_proc_id (0xff >> 1),
> but it could be also the BIOS just setting the local APIC of CPU 1
> to 0xff for some reason.
>
> If you add a printk("PHYSCPU %d %x\n", smp_processor_id(), phys_proc_id[smp_processor_id()])
> at the end of arch/x86_64/kernel/setup.c:early_identify_cpu() what does
> dmesg | grep PHYSCPU output?
>
Not a thing since I'm using arch/i386 here (32bit distribution
(Slackware), just building a 32bit kernel optimized for K8).
But, I stuck that printk into identify_cpu() in
arch/i386/kernel/cpu/common.c instead, and this is what I get :
$ dmesg | grep PHYSCPU
[   30.323965] PHYSCPU 0 0
[   30.402588] PHYSCPU 1 7f


> >
> > Second thing I find slightly odd is the lack of "sse3" in the "flags" list.
> > I was under the impression that all AMD Athlon 64 X2 CPU's featured SSE3?
> > Is it a case of:
> >  a) Me being wrong, not all Athlon 64 X2's feature SSE3?
> >  b) The CPU actually featuring SSE3 but Linux not taking advantage of it?
> >  c) The CPU features SSE3 and it's being utilized, but /proc/cpuinfo
> > doesn't show that fact?
> >  d) Something else?
>
> It's called pni (prescott new instructions) for historical reasons. We added
> the bit too early before Intel's marketing department could make up its
> mind fully, so Linux is stuck with the old codename.
>
Does anything actually parse the /proc/cpuinfo flags field? are we
really stuck with it?
Ohh well, no big deal.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
