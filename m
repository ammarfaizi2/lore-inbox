Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWIYPHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWIYPHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 11:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWIYPHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 11:07:41 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:60541 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750905AbWIYPHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 11:07:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y9cEESK+eFet51L2H9uoThgEpHqVLai4PJwirz24edEAJnHTgWcRWV5StVKZP4ghYJCPCUz1UXlO0C9Up3W9nFGlYdrHEi8hsjfvuwNQE77A7ZcsEk0cOKbqECccRutWH+qhUSsE7nq5TwQtl43KpaX127HFSau6Nt2dia/7GOw=
Message-ID: <fbf7c10b0609250807x142f073r5d252b1fa3e575fa@mail.gmail.com>
Date: Mon, 25 Sep 2006 11:07:39 -0400
From: "Ryan Moszynski" <ryan.m.lists@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /drivers/usb/class/cdc-acm.c patch question, please cc
In-Reply-To: <fbf7c10b0609241040j10bef8a0qce1d95d8cd98f981@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fbf7c10b0609221445q1329eb5bsfe304c02f7f336db@mail.gmail.com>
	 <200609241526.48659.oliver@neukum.org>
	 <fbf7c10b0609241040j10bef8a0qce1d95d8cd98f981@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, chalk that up to false optimism.

my last message said that everything worked fine.  It did, while I was
at home, where the maximum download speeds I can get are around 16
kbps, however, when I got into town where my speeds average 120 kbps
or so, the device is unusable.  It can connect, and you can browse the
web, but as soon as you try to download something the connection
ceases to work, even though the card is still blinking like it's
connected.  Setting the maxSize variable in the 2.6.15 patch fixed
this problem, i'm not sure whats in 2.6.18 thats supposed to do the
same job.


On 9/24/06, Ryan Moszynski <ryan.m.lists@gmail.com> wrote:
> sorry guys, my bad.
>
> I just compiled 2.6.18 again with my stock config, and everything
> worked. With 2.6.15 i had to recompile using the patch and load these
> in /etc/modules in order for my card to work at full speed.
>
> ######
> ohci-hcd
> usbserial vendor=0x0c88 product=0x17da maxSize=2048
> cdc_acm maxszr=16384 maxszw=2048
> #######
>
> however, now, at boot the kernel loads the 'airprime' driver, and
> everything works without any manual module loading.  Yay.  2.6.15 had
> the airprime driver, but i guess it didn't recognize my card at that
> point.
>
> However, to get this(and i would guess any other evdo) card to work,
> you still have set up 4 config files:
>
> ######
> etc/ppp/chap-secrets
> etc/ppp/peers/verizon
> etc/chatscripts/verizon-connect
> etc/chatscripts/verizon-disconnect
> #######
>
> which makes it a lot more labor intensive to set up for the first time
> than it is in windows, but at least everything works.
>
>
>
> On 9/24/06, Oliver Neukum <oliver@neukum.org> wrote:
> > Am Freitag, 22. September 2006 23:45 schrieb Ryan Moszynski:
> > > since 2.6.14 i have been applying the following patch and recompiling
> > > my kernel so
> > > that i can use my verizon kpc650 evdo card with my laptop. I've
> > > applied this patch
> > > succesfully on 2.6.14 and 2.6.15. It works great and I have no problems. I am
> > > trying to apply the patch to 2.6.18 but it fails, and i don't want to
> > > break anything,
> >
> > First give me a description of your device. Secondly, we'll try
> > to find a generic solution. Thirdly, if nothing else helps, we'll add
> > a generic quirk to the driver.
> >
> >         Regards
> >                 Oliver
> >
>
