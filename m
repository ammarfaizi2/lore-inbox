Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWDRXpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWDRXpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWDRXpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:45:16 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:9924 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750817AbWDRXpO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:45:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rnH1ZfQp4PJ1Vk6IU1v9HbcCs2f19XosTRU5ki6+yyzf3sImf/D292IXKxML9lTTMn3XzF/i5/jnguGxwtrlK4Ht49SUuSNIb/3YI+imKAYvt9nSXq0vhFxMesCpQ+BW5DMl3csaJEx1JOMVQpD0o7XberMpDZfLqKTijOjfpJg=
Message-ID: <35fb2e590604181645h32107d4fma13ddd8c7649bc13@mail.gmail.com>
Date: Wed, 19 Apr 2006 00:45:14 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [PATCH] sound: fix hang in mpu401_uart.c
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <s5hbquzxbsm.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060416031235.GA6741@apogee.jonmasters.org>
	 <s5hbquzxbsm.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/06, Takashi Iwai <tiwai@suse.de> wrote:

> > +             if ((err = snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1))) {
> > +                     return -EFAULT;
>
> IMO, -EFAULT isn't a good choice for this kind of error.

What would you suggest?

> >       if (mpu->open_output && (err = mpu->open_output(mpu)) < 0)
> >               return err;
> >       if (! test_bit(MPU401_MODE_BIT_INPUT, &mpu->mode)) {
> > -             snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1);
> > -             snd_mpu401_uart_cmd(mpu, MPU401_ENTER_UART, 1);
> > +             if ((err = snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1)))
> > +                     return -EFAULT;
> > +             if ((err = snd_mpu401_uart_cmd(mpu, MPU401_ENTER_UART, 1)))
> > +                     return -EFAULT;

> Missing close in the error path?

I'll respin the patch later, but first, what should I return on open
when the underlying hardware is not there?

Jon.
