Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVC3Cd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVC3Cd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 21:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVC3Cd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 21:33:59 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:42171 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261232AbVC3Cd4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 21:33:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:subject:date:user-agent:to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sqH5r3a9pfB1e4qUOZJdlmbNusHbKrgpWsQ5wX52186O6vH1znIiKbnun7k+ZS6rDa/moKvvTNUORQTjqFS6MRfzF3Rxe5UNaNfWYB7R4Sbz7Q4ipxq+bvu+Czr2XToy+TN8noaTmYsVxEYWE3l5TG+LYOBFFCFcB/I8j19Xc40=
From: Vicente Feito <vicente.feito@gmail.com>
Organization: none
Subject: Re: [PATCH] embarassing typo
Date: Tue, 29 Mar 2005 23:31:46 +0000
User-Agent: KMail/1.7.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503292331.46832.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As long as the variable doesn't get overflowed you would have a negation, you
shouldn't do dri_data[5] = ptr->dri * 0xff; if ptr->dri it's 255, but if
ptr->dri = 1 i.e. (like is set in zr36050_setup) then you would be getting
the negation, -1. the Direct rendering support is a flag afaik, so in this
case I believe is a worthy C obfuscated negation code :)
btw, are you sure about this patch?I would contact the maintainer first,
because and'ing that doesn't make much sense...
Disclaimer, all this is: AFAIK! :)

On Tuesday 29 March 2005 09:58 pm, you wrote:
> Måns Rullgård wrote:
> > "Ronald S. Bultje" <rbultje@ronald.bitfreak.net> writes:
> >>--- linux-2.6.5/drivers/media/video/zr36050.c.old 16 Sep 2004 22:53:27
> >> -0000 1.2 +++ linux-2.6.5/drivers/media/video/zr36050.c 29 Mar 2005
> >> 20:30:23 -0000 @@ -419,7 +419,7 @@
> >>  dri_data[2] = 0x00;
> >>  dri_data[3] = 0x04;
> >>  dri_data[4] = ptr->dri >> 8;
> >>- dri_data[5] = ptr->dri * 0xff;
> >>+ dri_data[5] = ptr->dri & 0xff;
> >
> > Hey, that's a nice obfuscation of a simple negation.
>
> It's not a negation.  This statement always assigns zero to
> dri_data[5] if dri_data is char[].  Looks like gcc isn't catching
> this problem.
>
> > BTW, when assigning to a char type, is the masking really necessary at
> > all?  I can't see that it should make a difference.  Am I missing
> > something subtle?
>
> Well, it's a matter of readability mostly.  For now at least, when
> char is always 8 bytes...
>
> /mjt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
