Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWDKWGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWDKWGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDKWGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:06:15 -0400
Received: from wproxy.gmail.com ([64.233.184.227]:54979 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751140AbWDKWGP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:06:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PcsDg75MB8QsOtgYmWU+LuRRy8kvYc6pVFNd7niom0qEN8kZ69xYIE+beAyE2LCTHOwRe/Qz5m2q7qy9zkpLmVMqmanZV+zN2u4MZDfscGH+XA2DrqXtgxjkukIg0QkUBfjij5ISChkIES5KI2LZjF/lQ6CvwVl8U9w/Yj1fCwc=
Message-ID: <5a4c581d0604111506j5f6d0a05y1666e6a7705d7905@mail.gmail.com>
Date: Wed, 12 Apr 2006 00:06:13 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same kernel
Cc: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0604111249g57882f7g29e132a7f4c0ab38@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
	 <20060411122806.GA26836@rhlx01.fht-esslingen.de>
	 <5a4c581d0604111111s4946b39x3686ade1275ded90@mail.gmail.com>
	 <Pine.LNX.4.61.0604112042060.25940@yvahk01.tjqt.qr>
	 <5a4c581d0604111249g57882f7g29e132a7f4c0ab38@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> On 4/11/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > >> > I'll be filing a FC5 performance bug for this but would like an opinion
> > >> >  from the IDE kernel people just in case this has already been seen...
> > >> >
> > >> > I just upgraded my home K7-800, 512MB RAM box from FC3 to FC5
> > >> >  and noticed a disk performance slowdown while copying files around.
> > >>
> > >> Just another suggestion: try eliminating/pinpointing I/O scheduler issues
> > >> (switch e.g. to "noop" at /sys/block/hda/queue/scheduler and compare again)
> > >
> > >Thanks Andi. Tried every scheduler (my default is anticipatory) and
> > > there aren't meaningful differences - 18.3 to 18.6MB/s.
> > >
> > >As a further data point, my box can burn a 8x DVD+R at up to 7.1x
> > > average speed under FC3, while it barely keeps up with 4x in FC5.
> >
> > Since you said it happens with the same kernel, I think it's caused by
> > userspace (do the boot-with-"-b" thing and you'll know). Possible someone
> > setting DMA to speeds as low as udma4 or udma2.
>
> Booting into /sbin/init -b indeed shows I get 33.3MB/s from hdparm,
>  as in FC3. DMA is (again according to hdparm) udma4 both booted
>  normally and in emergency mode. Note that at this point I'm testing
>  2.6.17-rc1-git4 in FC5, not to be trailing current kernels too much
>  (and yes, I already tested that normal 2.6.17-rc1-git4 boot in FC5
>  gets 18.5MB/s - without IDE_GENERIC, so that is also clearly a
>  non relevant factor).
>
> As per Bill Davidsen's question in another email, blockdev --getra
>  shows 256, which is the same value that hdparm shows.
>

Filed bugzilla #188630.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188630

Thanks,

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
