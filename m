Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbUKIV4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbUKIV4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUKIV4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:56:18 -0500
Received: from smtp.loomes.de ([212.40.161.2]:34462 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S261713AbUKIV4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:56:15 -0500
Subject: Re: [patch] 2.6.10-rc1-mm4: bttv-driver.c compile error
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
In-Reply-To: <20041109211107.GB5892@stusta.de>
References: <20041109074909.3f287966.akpm@osdl.org>
	 <1100018489.7011.4.camel@lb.loomes.de>  <20041109211107.GB5892@stusta.de>
Content-Type: text/plain
Date: Tue, 09 Nov 2004 22:55:58 +0100
Message-Id: <1100037358.1519.6.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 22:11 +0100, Adrian Bunk wrote:
> On Tue, Nov 09, 2004 at 05:41:28PM +0100, Markus Trippelsdorf wrote:
> > On Tue, 2004-11-09 at 07:49 -0800, Andrew Morton wrote:
> > 
> > > - v4l updates, fbdev updates.
> > 
> > It does not link here on amd64 using an build-in BT848 driver.  
> > 
> > LD      vmlinux
> > drivers/built-in.o(.init.text+0xba4d): In function `p_radio':
> > : undefined reference to `bttv_parse'
> > make: *** [vmlinux] Error 1

> 
> @Gerd:
> This is caused by your bttv updates included in -mm.
> 
> As far as I can see, the radio parameter is already handled correctly.
> Is the patch below correct?

Now the kernel is linked correctly.
However, on reboot I get this nasty error in my dmesg:
...
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
kobject_register failed for <NULL> (-17)

Call Trace:[<ffffffff80208fa6>] [<ffffffff80277a9b>]
[<ffffffff80278002>] 
       [<ffffffff802f8930>] [<ffffffff8010b0e8>] [<ffffffff8010ea03>] 
       [<ffffffff8010b050>] [<ffffffff8010e9fb>] 

and a little later:

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging
interupts

All this goes away if I disable the BT848 driver...

__ 
Markus


