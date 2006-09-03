Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWICQzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWICQzz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 12:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWICQzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 12:55:54 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:43320 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751423AbWICQzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 12:55:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wy54g96pfO8Ad+BqnkcWOq7991dYbnMlIDZCEFvsrObfAwo2L7Q9R/BJCdVcgD+03vprqDNHNICCLdP0YLslKfmDhU4IQhxRh+TlOh0IC7A6yXlXiWhvkegyaxGcNEHOL0AB0N0RDcNq7OxwqTpIWK7JxQPueAFeRaMPcFyQP+M=
Message-ID: <a44ae5cd0609030955t6dfcf89bpd6de210d846cfa60@mail.gmail.com>
Date: Sun, 3 Sep 2006 09:55:52 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: 2.6.18-rc5-mm1 -- bcm43xx: Out of DMA descriptor slots!
Cc: "Michael Buesch" <mb@bu3sch.de>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, linville@tuxdriver.com
In-Reply-To: <44FAE00B.6030701@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609030218y547e1c94pd7ba5337e1a27b2b@mail.gmail.com>
	 <200609031433.49658.mb@bu3sch.de> <44FAE00B.6030701@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> Michael Buesch wrote:
> > On Sunday 03 September 2006 11:18, Miles Lane wrote:
> >> Michael, I think this is related to your code (bcm43xx_dma.c).  It is
> >> quite possible that the bug isn't in your code, but rather in the
> >> general management of DMA.
> >
> > Please try latest wireless-2.6 tree. I think it has a bugfix for this.
>
> There is a fix (commit 653d5b55c0125dca97a420b9a5e77fad7adbf3f0) for mac_suspended assertions in the
> latest wireless-2.6. If you just want that fix, use the following:
>
> Index: wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> ===================================================================
> --- wireless-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> +++ wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> @@ -3349,6 +3349,8 @@
>      memset(bcm->dma_reason, 0, sizeof(bcm->dma_reason));
>      bcm->irq_savedstate = BCM43xx_IRQ_INITIAL;
>
> +    bcm->mac_suspended = 1;
> +
>      /* Noise calculation context */
>      memset(&bcm->noisecalc, 0, sizeof(bcm->noisecalc));
>
>
> If this patch is already in your code, and you are still getting the assertions, please let me know.

Thanks.  2.6.18-rc5-mm1 doesn't have this patch.  Andrew, could you
pull a current wireless tree into your next mm release?

Cheerio,
      Miles

-- 
VGER BF report: H 5.12123e-05
