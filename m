Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbSLLMCU>; Thu, 12 Dec 2002 07:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbSLLMCU>; Thu, 12 Dec 2002 07:02:20 -0500
Received: from mail.zmailer.org ([62.240.94.4]:57041 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267454AbSLLMCS>;
	Thu, 12 Dec 2002 07:02:18 -0500
Date: Thu, 12 Dec 2002 14:10:04 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: i4l dtmf errors
Message-ID: <20021212121004.GC32122@mea-ext.zmailer.org>
References: <200212121145.26108.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200212121145.26108.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This is possibly more of   linux-isdn@vger.kernel.org  list thing,
  than linux-kernel per se.

On Thu, Dec 12, 2002 at 11:45:26AM +0100, Roy Sigurd Karlsbakk wrote:
> hi
> 
> it seems isdn4linux detects DTMF tones from normal speach. This is rather 
> annoying when using i4l for voice with Asterisk.org. This is tested on all 
> recent kernels
> 
> see thread "[MGCP] Asterisk/D-Link phones generates ugly DTMF tones!!!" at 
> http://www.marko.net/asterisk/archives/ for more info.

  Quick reading of  drivers/isdn/isdn_audio.c(*)  shows that it does use
  fixed-point Görtzel (Goertzel in english) algorithm for detecting
  tones, but it does _not_ do comparison of received overall signal
  power vs. detected DTMF tone powers.

  When there is signal power outside the DTMF channels, signal should
  not be detected.  Also, DTMF tone powers should be roughly equal,
  and exactly two tones should be present for valid detection.

      http://www.numerix-dsp.com/goertzel.html

  Adding those power tests should be fairly trivial, but I leave it
  to Somebody Else...

(*) kernel version I looked upon was 2.4.16-0.11custom -- some RH kernel

> roy
> -- 
> Roy Sigurd Karlsbakk, Datavaktmester
> ProntoTV AS - http://www.pronto.tv/
> Tel: +47 9801 3356

/Matti Aarnio
