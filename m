Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162058AbWKVLBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162058AbWKVLBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162060AbWKVLBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:01:33 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:11658 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1162058AbWKVLBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:01:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jTuRbrigj2BwIUUnHuu4w27x4PkIF4a86fzPMvtBkJ1at2fwwfc8YkcVyU+W/Zcim4mbwC7wuuS6CHHXaz/Vw5tRdBno6n+sKHnPBz39oM+PyVabZnr+oVdLWpkYd1bzcqf/s4gCQsCP+UKgSI45zZWY3axnc/4fkbjXJ/xayrs=
Message-ID: <9a8748490611220300s52ec1c18kf1877d300b4fe46e@mail.gmail.com>
Date: Wed, 22 Nov 2006 12:00:59 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
	 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
	 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
	 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
	 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
	 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
	 <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
	 <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
	 <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 22 Nov 2006, Jesper Juhl wrote:
> >
> > So it *seems* to be somehow related to running low on RAM and swap
> > starting to be used.
>
> Does it happen if you just do some simple "use all memory" script, eg run
> a few copies of
>
>         #define SIZE (100<<20)
>
>         char *buf = malloc(SIZE);
>         memset(buf, SIZE, 0);
>         sleep(100);
>
> on your box?
>

I'll try, when I get home from work. I'll let you know later.


> > The box has 2GB of RAM and 768MB swap.
>
> I wonder.. It _used_ to be true that we were pretty good at making swap be
> "extra" memory. But maybe we've lost some of that, and we have trouble
> with having more physical memory. We could end up in a situation where we
> allocate it all very quickly (because we don't actually page it out, we
> just allocate backing store for the pages), and we screw something up.
>
> But stupid bugs there should still leave us trivially able to do the SysRQ
> things, so..
>
Well, it's a fact that sysrq works just fine before the lockup but
does not work at all after a lockup, so...


> Is it highmem-related? Some bounce-buffering problem while having to swap?

I can try building a kernel without highmem support and see if I can
still cause it to lockup. Would be an interresting datapoint.

I'll also try reproducing the lockup without any swap active to see if
that makes a difference.


> What block device driver do you use for the swap device?
>
It's a swap partition on a IBM Ultra160 10K RPM SCSI disk. The
controller is an Adaptec 29160N. Using the SCSI_AIC7XXX driver.


> I don't think we use any irq-disable locking in the VM itself, but I could
> imagine some nasty situation with the block device layer getting into a
> deadlock with interrupts disabled when it runs out of queue entries and
> cannot allocate more memory..
>
Just let me know what you would like me to try/test to prove/disprove that.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
