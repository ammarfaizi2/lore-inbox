Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWJWQvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWJWQvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWJWQvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:51:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:58422 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932177AbWJWQvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:51:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oKRSq5j//nutF2wlij2PVRXMe98/hEQjRTHRkOmb4f3p8QlbUcYfnqijn7ssZ4FeRTrue1YgGZvO22BkBgcPmAuHh+4TIkC+Kk7bUReSB2xsVDPJlW9S6SSuZObU82XNzgVM7alKTHX9RNI/rnABcHUR+x6GANOm5Fw0A5ImaYU=
Message-ID: <cda58cb80610230951l4a1319bbs6956fea5143c021a@mail.gmail.com>
Date: Mon, 23 Oct 2006 18:51:14 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <653402b90610230921j595446a4xda5e6d9444e108da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE143.3070909@innova-card.com>
	 <653402b90610230921j595446a4xda5e6d9444e108da@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> On 10/23/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >
> > [ note I'm not familiar with lcds...just try to understand what you've
> >   done ]
> >
> > What I was worry about is that you actually wrote a frame buffer
> > driver, which are normally located in drivers/video, and put it in a
> > new directory drivers/auxdisplay. So now we have two places for frame
> > buffer drivers. It looks like, now some frame buffer drivers in
> > drivers/video should be moved in drivers/auxdisplay, shouldn't it ?
> >
> > Maybe just a stupid idea but why not restructuring the thing like:
> >
> >                 drivers
> >                 |-- display
> >                 |      |-- video
> >                 |      |-- aux
> >                 |      |-- fbmem.c
> >                 |      |-- ...
> >
> >
>
> Yes, I got your idea in your first message, and well, that was
> discussed (however, not being a fbdev), and the people thought that
> putting them together will, maybe, cause confusion; so having them out
> from drivers/video should be better. Your idea, which merge them into
> a "drivers/display" could be a good one, but I don't think people will
> like to change such critical tree right now. Also, I'm not the one who
> maintain such tree, so my opinion won't make changes about that ;)
>

well, if it is the right thing to do, why not doing it. (note: I don't
claim it's the right thing to do though). Futhermore such change is
going to move a lot of files _but_ if after the move it compiles, then
it works...

> >
> > Another point: does the ks0108 controller is only used with the 'cfag'
> > display ? If not, suppose I'm using the same controller with another
> > lcd different from 'cfga'...Am I supposed to reuse your code in
> > cfag12864b.c ?
> >
>
> No. You are supposed to _use_ the ks0108's exported functions: I split
> the code into the ks0108 and the cfag12864b because I thought it was
> the logical way, as the cfag12864b LCD just send the data through two
> different ks0108 controllers. The same way, you can use the ks0108's
> exported functions to create another whateverlcd.c which has one or
> more ks0108 controllers.
>

So, to sum up, if I have a lcd named 'foo_lcd' which use 4 ks0108
controllers (256x128), and want to make your fb driver work on it, I
need to copy your  cfag12864b.c file, rename it to foo_lcd256128.c and
just change the number of controllers, is that correct ?

> >
> > BTW, did you try to mmap your fbdev ? Does it work ?
> >
>
> Why it shouldn't? It doesn't work for you? AFAIK, it is a usual fbdev,
> and you can map any fbdev as they are simple character file devices.
>

well you actually haven't answered to the initial question... I
suspect it won't work since you haven't setup "info->fix.smem_start"
anywhere. But I may be wrong since I don't know fb code.

-- 
               Franck
