Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTECMel (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 08:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTECMel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 08:34:41 -0400
Received: from mbox2.netikka.net ([213.250.81.203]:151 "EHLO mbox2.netikka.net")
	by vger.kernel.org with ESMTP id S263298AbTECMek convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 08:34:40 -0400
From: Thomas Backlund <tmb@iki.fi>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Date: Sat, 3 May 2003 15:46:57 +0300
User-Agent: KMail/1.5.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EB0413D.2050200@superonline.com> <200305020314.01875.tmb@iki.fi> <20030502130331.GA1803@alpha.home.local>
In-Reply-To: <20030502130331.GA1803@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305031546.57631.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viestissä Perjantai 2. Toukokuuta 2003 16:03, Willy Tarreau kirjoitti:
> On Fri, May 02, 2003 at 03:14:01AM +0300, Thomas Backlund wrote:
> > And here are the results...
>
> [snip]
>
> Hi Thomas,
>
> With this patch, vesafb doesn't work anymore on my vaio notebook in
> 1400x1050 nor 1280x1024, because scree_info.lfb_size is reported to be
> 127, while it should be 175 and 160 instead ! So I modified your patch a
> little bit to get it right :
>
> - video_size          = screen_info.lfb_size * screen_info.lfb_height *
> video_bpp; + video_size          = screen_info.lfb_width/8 *
> screen_info.lfb_height * video_bpp;
>
> and it now works again.
> Maybe I have a broken bios, but other people might have the problem too.
>
> Cheers,
> Willy

Oh man...
I must have been sleeping when I posted that patch...

the correct line should AFAIK be:
video_size = screen_info.lfb_width * screen_info.lfb_height * video_bpp;

(AFAIK we are calculating bits here, not bytes so the '/8' you used is 
wrong... could you try without it, and let me know...)

or even shorter:

video_size = video_width * video_height * video_bpp;


I'll be rebuilding and retesting my system today or tommorrow,
but I wuold like to hear if it works for you...


-- 
Thomas Backlund

tmb@iki.fi
www.iki.fi/tmb

