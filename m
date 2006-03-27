Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWC0XyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWC0XyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWC0XyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:54:10 -0500
Received: from s93.xrea.com ([218.216.67.44]:53954 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S932115AbWC0XyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:54:08 -0500
Message-Id: <200603272357.AA00920@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Tue, 28 Mar 2006 08:57:36 +0900
To: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Jim Crilly <jim@why.dont.jablowme.net>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, xen-devel@lists.xensource.com
Subject: Re: Fwd: Faster resuming of suspend technology.
In-Reply-To: <200603211133.AA00855@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
References: <200603211133.AA00855@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I wasn't thinking suspend2 was the topic, but I'll freely admit my bias and 
>say I think it's the best tool for the job, for a number of reasons:
>
>First, speed is not the only criteria that should be considered. There's also 
>memory overhead, the difference in speed post-resume, reliability, 
>flexibility and the list goes on.
>
>Second, Xen would not be the most practical candidate now. It would be slower 
>than suspend2 because suspend2 is reading the image as fast as the hardware 
>will allow it (Ok. Perhaps algorithm changes could make small improvements 
>here and there). In contrast, what is Xen doing? I'm not claiming knowledge 
>of its internals, but I'm sure it will have at least some emphasis on 
>keeping other vms (or whatever it calls them) running and interactive while 
>the resume is occuring. It will therefore surely be resuming at something less 
>than the fastest possible rate.
>
>Additionally, Xen cannot solve the problems raised by the kernel lacking 
>complete hotplug support. Only further development in the kernel itself can 
>address those issues.
>

I made very easy testing.

H/W
  CPU:Sempron64 2600+
  MEM:1G    for Xen3.0 (I put 768MB for dom0, and 256MB for domU)
      256MB for swsusp2
  WAN:100Mbps FTTH ( up to about 8MBytes/sec , from ISP's web server).
  HDD:250G 7200rpm ATA
  DVD:x16 DVD-R ATA
S/W
  SuSE10 with Xen3.0
  Using KDE3 desktop, with Firefox and OOo 2.0 Writer launched.

Performance:
swsusp2    -> about 10sec after "uncompressing Linux kernel".
              (from HDD, of course.)
Xen resume -> almost same! But needs to boot dom0 first.

On Xen experiment, I booted dom0 from HDD, but loaded the suspend image
from x16 DVD-R. And, it resumed about in 10sec including decompressing
time of suspend image. This means, Xen can resume almost same speed
as swsusp2 from DVD-R, with H/W abstraction which current swsusp2 lacks.
(Note: I did vnc reconnection workaround manually, so the time is just
an estimation.)
And, for example, if you boot dom0 up within 10 sec, ( and this
is quite possible, check my site http://www.machboot.com/), you can get
KDE3+FF1.5+OOo2 workinig  within 20sec measured from ISOLINUX loaded,
with x16 DVD-R. Yes, DVD is not slow any more!.

And, I also tried to do Xen resume from Internet.
What I did was very easy. Just did like this.
(Sorry, no gpg yet.)
# wget $URL -o - | gzip -d > /tmp/$TMP.chk && xm restore /tmp/$TMP.chk

The result is, I succeeded to "boot" (actually resume) KDE3+FF1.5+OOo2
in about 15 sec from Internet!. I believe this is the fastest record of
Internet booting ever.

What I want to say is, using Xen suspend is one way to "boot" your desktop
faster, especially if you use big apps and big window manager.

Note: This experiment is very easy one, and no guarantee of correctness or
reproducitivity. Must have many mistakes and misunderstanding and
misconception, so on. I am afraid that even me could not reproduce it.
So, dont accept this figure on faith, but treat as just one suggestion.
But, I believe my suggestion must be meaningful one.
Dont you want to boot your desktop within 20 sec from x48 CD-R?
I suggest that this is not just a dream, but maybe feasible.

>> I admit that Jim Crilly's concern is right, but with using Xen suspend,
>> it can be solved very easily. What you do is just like this:
>> [Xen DOM0]# wget
>> http://www.geocity.com/1235089/suspend_image/debian.image [Xen DOM0]# gpg
>> --verify debian.image
>> [Xen DOM0]# xen --resume debian.image
>
>Given this example, I guess you're talking about Xen (or vmware for that 
>matter) providing an abstraction of the hardware that's really available. 
>Doesn't this still have the problems I mentioned above, namely that your Xen 
>image can't possibly have support for any possible hardware the user might 
>have, allowing that hardware to be used with full functionality and full 
>speed. Surely such any such solution must be viewed as second best, at best?
>
>

I have not checked this feature yet.
I only have one Xen installed PC and to make matters worse,
the condition of the PC is very unstable, so it is a bit tough
to check this by myself.

Do somebody know about this?
I mean, Xen really does not have an abstraction layer of the H/W?
I think it must have and you can use the same suspend image on all Xen PCs.

              --- Okajima, Jun. Tokyo, Japan.

