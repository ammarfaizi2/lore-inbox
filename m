Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315994AbSENSz5>; Tue, 14 May 2002 14:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315995AbSENSz4>; Tue, 14 May 2002 14:55:56 -0400
Received: from mailg.telia.com ([194.22.194.26]:14053 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S315994AbSENSzy>;
	Tue, 14 May 2002 14:55:54 -0400
From: "Christer Nilsson" <christer.nilsson@kretskompaniet.se>
To: "Greg KH" <greg@kroah.com>, <lepied@xfree86.org>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.19-pre8  Fix for Intuos tablet in wacom.c
Date: Tue, 14 May 2002 20:56:14 +0200
Message-ID: <IBEJLIFNGHPKEKCKODPDMEDODPAA.christer.nilsson@kretskompaniet.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020514153735.GB18532@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic.

Can you take a look at this?

I've looked at the code at
http://people.mandrakesoft.com/~flepied/projects/wacom/ and found that
there's a couple of lines missing in the kernel driver. It seems that a
smoothing algorithm is left out
in the kernel source. My patch just circumvents that.

Christer Nilsson

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, May 14, 2002 5:38 PM
> To: Christer Nilsson; lepied@xfree86.org
> Cc: Linux-Kernel
> Subject: Re: [PATCH] 2.4.19-pre8 Fix for Intuos tablet in wacom.c
>
>
> On Tue, May 14, 2002 at 10:31:45AM +0200, Christer Nilsson wrote:
> >
> > The changes between 2.4.19-pre7 and 2.4.18-pre8 broke the Intuos part in
> > wacom.c
> > This will fix it.
> >
> > --- linux/drivers/usb/wacom.c.org	Tue May 14 00:40:12 2002
> > +++ linux/drivers/usb/wacom.c	Tue May 14 00:41:31 2002
> > @@ -288,8 +288,8 @@
> >  	x = ((__u32)data[2] << 8) | data[3];
> >  	y = ((__u32)data[4] << 8) | data[5];
> >
> > -	input_report_abs(dev, ABS_X, wacom->x);
> > -	input_report_abs(dev, ABS_Y, wacom->y);
> > +	input_report_abs(dev, ABS_X, wacom->x = x);
> > +	input_report_abs(dev, ABS_Y, wacom->y = y);
> >  	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);
> >
> >  	if ((data[1] & 0xb8) == 0xa0) {
> 	/* general pen packet */
> >
>
> Can you ask lepied@xfree86.org if this will break anything else, as that
> change was in his patch that is found at:
> 	http://people.mandrakesoft.com/~flepied/projects/wacom/
>
> thanks,
>
> greg k-h
>


