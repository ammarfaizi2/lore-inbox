Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWJHXu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWJHXu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWJHXu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:50:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:22428 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932122AbWJHXu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:50:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LUh4JSuTE87V7MjiRz4WxR/6h0cKSFLDCZh684j3SBTAoOzRT96KXW3rBjU/wzyJH7/5goDAsTr0MGoGwW2udoh+vHt/T/lnZbTeqdxPigE0sA0obX4d01njJtuuTUt24DqWEcaSAH55P6gvtrRAzeAtiTG56GG9MgIVnvuPO04=
Message-ID: <9a8748490610081650q26511b89s4e694f841803cda1@mail.gmail.com>
Date: Mon, 9 Oct 2006 01:50:26 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: sluggish system responsiveness under higher IO load
Cc: Christian <christiand59@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20061008170538.GZ8814@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608061200.37701.mlkernel@mortal-soul.de>
	 <200608131815.12873.mlkernel@mortal-soul.de>
	 <20061006175833.4ef08f06@localhost>
	 <200610081628.55012.christiand59@web.de>
	 <20061008170538.GZ8814@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Sun, Oct 08 2006, Christian wrote:
> > Am Freitag, 6. Oktober 2006 17:58 schrieb Paolo Ornati:
> > > On Sun, 13 Aug 2006 18:15:12 +0200
> > >
> > > Matthias Dahl <mlkernel@mortal-soul.de> wrote:
> > > > Just let me know once you got them, so I can safely delete them again.
> > > >
> > > > At the moment, I am trying without preemption but for example doing a
> > > > untar kernel sources still results in sluggish system responsiveness. :-(
> > >
> > > I used to have this type of problem and 2.6.19-rc1 looks much better
> > > than 2.6.18.
> > >
> > > I'm using CONFIG_PREEMPT + CONFIG_PREEMPT_BKL, CFQ i/o scheduler
> > > and /proc/sys/vm/swappiness = 20.
> >
> >
> > Which change in the new kernel has made it better? I was following the lkml
> > very close and didn't see any change that could have fixed that problem.
>
> There is a substantial CFQ update, so it could be that. Or it could be
> something unrelated of course, I didn't check if eg the cpu scheduler
> changed much. Or vm :-)
>
> --
> Jens Axboe
>
I want to chime in here and let you know that I've experienced
something similar.

I'm using CFQ as my default I/O schedular.
Since 2.6.18-git<something_I'm_not_sure_of> I've experienced that when
doing heavy (or even not so heave) disk I/O my system gets very
sluggish. Observable by the fact that my mouse pointer in X "jumps"
which it never did before, and switching windows I can see the new
window repaint slowly whereas earlier it would just snap onto the
screen.

<serious hand-waving enabled>
This is quite unreliable, but I *seem* to have observed a slightly
higher overall memory use for my system since 2.6.18+ as well as the
software interrupt rate (as observable by 'top' oscilating between 1.5
& 5 % with 2.6.18+ where with older kernels it would seem to mostly
stay below 1%.
I've also observed that when rebooting, unmounting my local
filesystems takes significantly longer (previously just a second or
two, recently up to a minute or not at all, that is, the system just
hangs) - may or may not be related to this.
<serious hand-waving disabled>

In any case, disk I/O seems to have a large negative impact on system
performance recently compared to pre-2.6.18* kernels.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
