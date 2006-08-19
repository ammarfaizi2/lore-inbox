Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWHSLcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWHSLcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 07:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWHSLcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 07:32:18 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:29404 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750706AbWHSLcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 07:32:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MO8hpbpJHQ7Nn9ulT7fVoK0ok/160xNHBE4WmLw6jw4V6aQp6mrQeALcTFkUImH/5vL8WSLZGaKl/vZKpJMo7G1E11HmkxCzGgdCdKudf9kzuzewvpkKg7SdaLZs9W7l67PEokqDAUYRMAQETeBueoLD+iP1aANBR5xYKxzPoow=
Message-ID: <acd2a5930608190432l17c4afebqcc5a941c8e81ebb5@mail.gmail.com>
Date: Sat, 19 Aug 2006 15:32:16 +0400
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Vitaly Wool" <vitalywool@gmail.com>, jean-paul.saman@philips.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] UART driver for PNX8550/8950 revised
In-Reply-To: <20060819095210.GD25767@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060819122600.000017e6.vitalywool@gmail.com>
	 <20060819090427.GB25767@flint.arm.linux.org.uk>
	 <acd2a5930608190234y4b4bee8dqfc17d109f86d4318@mail.gmail.com>
	 <20060819095210.GD25767@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > >This comment's not correct - where is the break condition disabled?
> > >I thought it might be in the next serial_out() but it seems to be
> > >missing from there as well?
> >
> > I don't think you're right here - break condition is also disabled
> > unsetting the corresponding bit in  IEN register for this particular
> > UART.
>
> Hmm, in that case why does break_ctl do this:
>
> +       lcr = serial_in(sport, PNX8XXX_LCR);
> +       if (break_state == -1)
> +               lcr |= PNX8XXX_UART_LCR_TXBREAK;
> +       else
> +               lcr &= ~PNX8XXX_UART_LCR_TXBREAK;
> +       serial_out(sport, PNX8XXX_LCR, lcr);
>
> which appears to imply that the bit for the break state is in the LCR.
> Moreover, there isn't a PNX8XXX_INT_* bit defined for break.  Confused.

Yeah, looking more attentively into docs, I must admit that you're
right here, and I'm wrong.

Vitaly
