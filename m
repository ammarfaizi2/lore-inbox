Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVLSLmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVLSLmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 06:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbVLSLmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 06:42:36 -0500
Received: from mail.gmx.de ([213.165.64.21]:59075 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030277AbVLSLmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 06:42:35 -0500
X-Authenticated: #19855039
Date: Mon, 19 Dec 2005 12:42:31 +0100
From: Marc-Jano Knopp <pub_ml_lkml@marc-jano.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] mlockall() not working properly in 2.6.x
Message-ID: <20051219114231.GA2830@mjk.myfqdn.de>
References: <20051218212123.GC4029@mjk.myfqdn.de> <20051219022108.307e68b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219022108.307e68b8.akpm@osdl.org>
User-Agent: Mutt/1.5.1i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005 at 02:21 (-0800), Andrew Morton wrote:
> Marc-Jano Knopp <pub_ml_lkml@marc-jano.de> wrote:
> >
> > A year ago, I wrote a small mlockall()-wrapper ("noswap") to make
> > certain programs unswappable. It used to work perfectly, until I
> > upgraded to kernel 2.6.x (2.6.13.1 in my case, but that shouldn't
> > matter), which made the mlockall() execute without error, but also
> > without any effect (the "L" in the STAT column of "ps axf" which
> > indicates locked pages is missing).
> > 
> 
> Question is: what kernel version did you upgrade from?

2.4.31. Just rebooted to 2.4.31 and tried again - mlockall() seems to
work perfectly:

# ps axf|grep [9]99
 1037 tty1     SL+    0:00      \_ sleep 999
# uname -a
Linux pc8 2.4.31 #3 Thu Sep 8 16:49:45 CEST 2005 i686 unknown
#


> Prior to 2.4.18 the kernel would allow MCL_FUTURE to propagate into child
> processes.  But that was disabled in 2.4.18 and later.  I seem to recall
> that we did this because inheriting MCL_FUTURE is standards-incorrect.

Oh! So how can I make programs unswappable with kernel 2.6.x then?


Best regards

  Marc-Jano
