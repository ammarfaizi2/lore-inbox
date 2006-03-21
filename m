Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWCULeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWCULeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWCULeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:34:11 -0500
Received: from s93.xrea.com ([218.216.67.44]:43162 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S1030344AbWCULeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:34:10 -0500
Message-Id: <200603211133.AA00855@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Tue, 21 Mar 2006 20:33:59 +0900
To: Nigel Cunningham <ncunningham@cyclades.com>,
       Jim Crilly <jim@why.dont.jablowme.net>, linux-kernel@vger.kernel.org
Cc: suspend2-devel@lists.suspend2.net, xen-devel@lists.xensource.com
Subject: Fwd: Faster resuming of suspend technology.
In-Reply-To: <200603201245.AA00848@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is forwarded from Cunningham's mail which we failed to post LKML
because of false positive of LKML's spam filter.
I also post this to Xen-devel, swsusp2-devel.

For the purpose of faster booting(=resuming, in this case),
You think what suspend technology is good in what aspect?

              --- Okajima.

-----------
Hi.

On Saturday 18 March 2006 03:46, Jun OKAJIMA wrote:
> >> > >> Especially, your way has problem if you boot( resume ) not from HDD
> >> > >> but for example, from NFS server or CD-R or even from Internet.
> >> > >
> >> > >Resuming from the internet? Scary. Anyway, I hope I'll understand
> >> > > better what you're getting at after your next reply.
> >> >
> >> > In Japan, it is not so scary.
> >> > We have 100Mbps symmetric FTTH ( optical Fiber To The Home), and
> >> > more than 1M homes have it, and price is about 30USD/month.
> >> > With this, theoretically you can download 600MB ISO image in one min,
> >> > and actually you can download 100MBytes suspend image within 30sec.
> >> > So, not click to run (e.g. Java applet) but "click to resume" is not
> >> > dreaming but rather feasible. You still think it is scary on this
> >> > situation?
> >>
> >> I don't think the scary part is speed, but security. I for one wouldn't
> >> want to resume from an image hosted on a remote machine unless I had
> >> some way to be sure it wasn't tampered with, like gpg signing or
> >> something.
> >
> >Another issues is that at the moment, hotplugging is work in progress. In
> >order to resume, you currently need the same kernel build you're booting
> >with, and the same hardware configuration in the resumed system. As
> > hotplug matures, this restriction might relax, and we could probably come
> > up with a way around the former restriction, but at the moment, it really
> > only makes sense to try to resume an image you created using the same
> > machine.
>
> Wait, wait. Let make it clear that what we are discussing.
>
> For me, the theme is "faster resuming with suspend technology", not
> swsusp2. I mean, in this point of view, the most practical candidate for
> now would be Xen suspend, not swsusp2. Of course, hotplugging once comes,
> swsusp2 will be a good candidate also, and hopefully what I call "generic
> suspend image" would be possible.

I wasn't thinking suspend2 was the topic, but I'll freely admit my bias and 
say I think it's the best tool for the job, for a number of reasons:

First, speed is not the only criteria that should be considered. There's also 
memory overhead, the difference in speed post-resume, reliability, 
flexibility and the list goes on.

Second, Xen would not be the most practical candidate now. It would be slower 
than suspend2 because suspend2 is reading the image as fast as the hardware 
will allow it (Ok. Perhaps algorithm changes could make small improvements 
here and there). In contrast, what is Xen doing? I'm not claiming knowledge 
of its internals, but I'm sure it will have at least some emphasis on 
keeping other vms (or whatever it calls them) running and interactive while 
the resume is occuring. It will therefore surely be resuming at something less 
than the fastest possible rate.

Additionally, Xen cannot solve the problems raised by the kernel lacking 
complete hotplug support. Only further development in the kernel itself can 
address those issues.

> I admit that Jim Crilly's concern is right, but with using Xen suspend,
> it can be solved very easily. What you do is just like this:
> [Xen DOM0]# wget
> http://www.geocity.com/1235089/suspend_image/debian.image [Xen DOM0]# gpg
> --verify debian.image
> [Xen DOM0]# xen --resume debian.image

Given this example, I guess you're talking about Xen (or vmware for that 
matter) providing an abstraction of the hardware that's really available. 
Doesn't this still have the problems I mentioned above, namely that your Xen 
image can't possibly have support for any possible hardware the user might 
have, allowing that hardware to be used with full functionality and full 
speed. Surely such any such solution must be viewed as second best, at best?

Regards,

Nigel

