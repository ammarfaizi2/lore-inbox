Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWISWIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWISWIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWISWIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:08:24 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:42154 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751202AbWISWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:08:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m0WgrxtHcoVREah1UK6AKLd9llOOR+kaYz0+1vd8YW9f9R+f2lYQOdtiDRZU/sCz02ATGz0iXhdJL4yGNKuKZj3p1sGSqzdykgUrPp07HTBciq+Q+TqSfkd+eC2GLcuYu48g7bDPqd7jRzRmgzCzR1ggOS47AW5Pv7LLqF6+F9M=
Message-ID: <653402b90609191508yff445d4ybf3ee33afb85838d@mail.gmail.com>
Date: Wed, 20 Sep 2006 00:08:22 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH 1/1 Re] drivers: add lcd display support
Cc: torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060919200224.GD7246@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060915030508.2900b9dd.maxextreme@gmail.com>
	 <20060919200224.GD7246@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack, thank you for your review!

On 9/19/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > Please tell me if you agree.
> >
> > Adds LCD Display support.
> > Adds ks0108 LCD controller support.
> > Adds cfag12864b LCD display support.
> >
> > Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
>
>
> > diff -uprN -X linux-2.6.18-rc7/Documentation/dontdiff linux-2.6.18-rc7-vanilla/drivers/lcddisplay/cfag12864b.c linux-2.6.18-rc7/drivers/lcddisplay/cfag12864b.c
> > --- linux-2.6.18-rc7-vanilla/drivers/lcddisplay/cfag12864b.c  1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.18-rc7/drivers/lcddisplay/cfag12864b.c  2006-09-13 05:03:29.000000000 +0200
> > @@ -0,0 +1,558 @@
> > +/*
> > + *    Filename: cfag12864b.c
> > + *     Version: 0.1.0
> > + * Description: cfag12864b LCD Display Driver
> > + *     License: GPL
>
> v2 or v2 and later?
>
> > +static const unsigned int cfag12864b_firstminor = 0;
>
> No need to initialize to zero.
>
> > +static const unsigned int cfag12864b_ndevices = 1;
> > +static const char * cfag12864b_name = NAME;
>                       ~- kill this space.
>
> > +#define bit(n) ((unsigned char)(1<<(n)))
> > +#define nobit(n) ((unsigned char)(~bit(n)))
>
> Uh? We have generic functions for this.
>
> > +static unsigned char cfag12864b_state = 0;
>
> No zeros.
>
> > +static void cfag12864b_e(unsigned char state)
> > +{
> > +     if(state)
>           ~ missing space.
>
> > +             cfag12864b_state |= bit(0);
> > +     else
> > +             cfag12864b_state &= nobit(0);
> > +     cfag12864b_set();
>
> This repeats few times, perhaps you could create helper for that?
> > +static void cfag12864b_secondcontroller(unsigned char state)
> > +{
> > +     if(state)
> > +             cfag12864b_cs2(0);
> > +     else
> > +             cfag12864b_cs2(1);
> > +}
>
> Is this needed?
>
> > +             /*if(address != tmpaddress) {
> > +                     address = tmpaddress;
> > +                     cfag12864b_address(address);
> > +                     cfag12864b_nop();
> > +             }*/
> > +
> > +             /*if(tmpcontroller == 0) {
> > +                     if(address != tmpaddress) {
> > +                             address = tmpaddress;
> > +                             cfag12864b_address(address);
> > +                     }
> > +             }
> > +             else {
> > +                     cfag12864b_address(tmpaddress);
> > +                     cfag12864b_nop();
> > +             }*/
>
> Remove unused code, do not comment it out.
>                                                                 Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
