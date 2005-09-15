Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVIOMce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVIOMce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVIOMce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:32:34 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:613 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964952AbVIOMce convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:32:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mt/zjdUc9m2Jm/ewlE6XqMKa+vPEfqi9VXC3wUVejFByD3ilKYsGLRZKZzmcVDimblkacgfFB5aBYnFTasnr4kdS1GHQbsdAhWDJ1lj1H60u3i+EIqC6r+Suumax8pmUt008k85XCQub8Eg6HqPd8QmbcECXT8PWsFBxSUwNBlU=
Message-ID: <47f5dce3050915053266745a8f@mail.gmail.com>
Date: Thu, 15 Sep 2005 20:32:28 +0800
From: jayakumar alsa <jayakumar.alsa@gmail.com>
Reply-To: jayakumar.alsa@gmail.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] [RFC 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Cc: perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hk6hi8wnr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509150904.j8F94NKP000991@localhost.localdomain>
	 <s5hk6hi8wnr.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Takashi Iwai <tiwai@suse.de> wrote:
> Just small glitches I found below:

Much appreciated. Thanks for reviewing. :-)

> You can put this header filer into sound/pci/cs5535, so that it won't
> be exported.  Then you don't need __KERNEL__ check, too.

Will do.

> > +     u16 eot:1;
> > +} cs5535audio_dma_desc_t;
> 
> The bitfield isn't portable to use to comminucate with the hardware.
> Better to use u16 and normal bit operations.

I think 5535 is x86-32 specific, but you are right, I shouldn't use
bit fields. I'll convert over to masks.

> The loop with do_delay() should be replaced with more portable ones
> like msleep().

Will do.

> 
> > +{
> > +     unsigned long regdata=0;
> 
> Unnecessary initialization :)

Good catch.

> > +     cs5535au = kcalloc(1, sizeof(*cs5535au), GFP_KERNEL);
> 
> Let's use the new kzalloc().

Will do.

> > +     spin_lock(&cs5535au->reg_lock);
> > +     dma->ops->disable_dma(cs5535au);
> > +     dma->ops->setup_prd(cs5535au, jmpprd_addr);
> > +     spin_unlock(&cs5535au->reg_lock);
> 
> You need spin_lock_irq() here, instead.
> 

Got it. Will do.

Thanks,
jk
