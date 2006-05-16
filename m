Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWEPTNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWEPTNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWEPTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:13:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:63077 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750910AbWEPTNj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:13:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aaMT01qpa4Dgn5v8HLNu8y7t2JJY0xZ483TgdH/janhVcU0dKzdA5Y3Y3EsSrjLoz4lNT8edOaggM2pMf8RpcEbcMRPknrQrIaMMyL6scOHRwobl4wlO8ZuxjzyMOTZHUTKPPC0KTOukwrA5iPyJatbm2Up0gV4cApahJCxY1Hg=
Message-ID: <7c3341450605161213vc23ee70r6d9809c1bafdbc17@mail.gmail.com>
Date: Tue, 16 May 2006 20:13:37 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: Make number of IDE interfaces configurable
Cc: "Matt Mackall" <mpm@selenic.com>, akpm@osdl.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060516164011.GH5677@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060512222952.GQ6616@waste.org> <20060516160250.GE5677@stusta.de>
	 <20060516162934.GR24227@waste.org> <20060516164011.GH5677@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted a patch ages ago similar (but differnet ;-) ) to this:

http://lkml.org/lkml/2005/6/25/69

I couldn't/don't see why I get six ide probes when I know I have only
2 IDE interfaces - I thought it would be better to stick to default
_unless_ the kernel builder knew otherwise and specified the amount.

Alan Cox didn't like it as it introduces more config unnecessary config options.

But it would be nice though if this could be included with that enhancement too.

Nick

On 16/05/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Tue, May 16, 2006 at 11:29:34AM -0500, Matt Mackall wrote:
> > On Tue, May 16, 2006 at 06:02:50PM +0200, Adrian Bunk wrote:
> > > On Fri, May 12, 2006 at 05:29:52PM -0500, Matt Mackall wrote:
> > > >...
> > > > --- 2.6.orig/include/linux/ide.h	2006-05-11 15:07:32.000000000 -0500
> > > > +++ 2.6/include/linux/ide.h	2006-05-12 14:01:53.000000000 -0500
> > > > @@ -252,7 +252,8 @@ static inline void ide_std_init_ports(hw
> > > >
> > > >  #include <asm/ide.h>
> > > >
> > > > -#ifndef MAX_HWIFS
> > > > +#if !defined(MAX_HWIFS) || defined(CONFIG_EMBEDDED)
> > > > +#undef MAX_HWIFS
> > > >  #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
> > > >  #endif
> > >
> > > Why do you need this?
> >
> > Doesn't work without it?
> >
> > Most platforms define MAX_HWIFS.
>
> OK, now I got it.
>
> Setting this value is sometimes done in heder files and sometimes
> done in the Kconfig file.
>
> That is extremely ugly.
>
> Bart, would you accept a patch to set in in the Kconfig file on all
> architectures?
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
