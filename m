Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTEFAJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTEFAJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:09:13 -0400
Received: from mbox1.netikka.net ([213.250.81.202]:42917 "EHLO
	mbox1.netikka.net") by vger.kernel.org with ESMTP id S261887AbTEFAJF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:09:05 -0400
From: Thomas Backlund <tmb@iki.fi>
To: Willy TARREAU <willy@w.ods.org>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Date: Tue, 6 May 2003 03:21:23 +0300
User-Agent: KMail/1.5.1
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EB0413D.2050200@superonline.com> <200305031546.57631.tmb@iki.fi> <20030504094900.GA342@pcw.home.local>
In-Reply-To: <20030504094900.GA342@pcw.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305060321.23459.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viestissä Sunnuntai 4. Toukokuuta 2003 12:49, Willy TARREAU kirjoitti:
> Hi Thomas,
>
> > the correct line should AFAIK be:
> > video_size = screen_info.lfb_width * screen_info.lfb_height *
> > video_bpp;
> >
> > (AFAIK we are calculating bits here, not bytes so the '/8' you used is
> > wrong... could you try without it, and let me know...)
>
> No, after verification, I insist, we're really calculating BYTES here.
> Please take a look :

Yes, 
you are right...

[...]
>
> So I think that the correct line really is :
>   video_size = screen_info.lfb_width * screen_info.lfb_height *
> video_bpp / 8;

There is a problem with this, ...
If we calculate the exact memory like this, there wont be any
memory remapped to do double/tripple buffering...
So the question is: shoud one take the formula and add ' * 2' to 
atleast get the double buffering supported...
(in the patch I made for mdk, I kept a modified override part so that
the user can change this, if he needs it....)

Alan,
any comments on this?

> (Which also handles line widths which are not multiple of 8).

Well actually, in that formula it does not matter where you put the '/8',
the result is always the same...

> BTW, I wonder why we truncate the mtrr size to the highest lower power
> of 2. Shouldn't we round it up to the next one ?
>

Isn't it a hardware requirement?
I think I read it in a nvidia document once... 
(of course they may be wrong...)

-- 
Thomas Backlund

tmb@iki.fi
www.iki.fi/tmb

