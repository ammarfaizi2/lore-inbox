Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVC3TYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVC3TYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVC3TWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:22:46 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:27408 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262411AbVC3TSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:18:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dHXJYP+GJIcMbAPtwAcgoT9mIQnwAeeC9dPxpzsvxu3mkvDDEjlatfDF8NQkEnlXAolkH8Lc55iefgkTlmEorgArDaVAxE+kcqOo6dYlPAkHE/ceeZnPL8u6C7SGwOM7wXR/6ViOlt5xO7AU8HsIReg8zlzmtVZXXFb+HsHbUF8=
From: Vicente Feito <vicente.feito@gmail.com>
Organization: none
To: linux-os@analogic.com
Subject: Re: How to debug kernel before there is no printk mechanism?
Date: Wed, 30 Mar 2005 16:16:10 +0000
User-Agent: KMail/1.7.1
Cc: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <424AD247.4080409@globaledgesoft.com> <200503301454.41322.vicente.feito@gmail.com> <Pine.LNX.4.61.0503301305260.28280@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503301305260.28280@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301616.10450.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 06:09 pm, linux-os wrote:
> On Wed, 30 Mar 2005, Vicente Feito wrote:
> > Video memory is at b800:0000, for humans 0x0000b800, not at 0x000b8000
>
> Wrong. "real-mode" can use a segment address of b800, that doesn't
> work in protected mode. A segment address of b800:0000 is never
> under any conditions 0000b800.
I was referring to the basic conditions, haven't played under protected mode 
with that, only in real mode, I assumed the question was under that mode.
What you mean is this:
B800:0010 -> B8010H right?

>
> FYI, a real-mode segment is a 16-byte entity, therefore there are
> many segment:offset combinations that can get you to 0x000b8000.
I'm aware of that, it has nothing to do with my statement.

>
> > On Wednesday 30 March 2005 04:47 pm, linux-os wrote:
> >> On Wed, 30 Mar 2005, krishna wrote:
> >>> Hi all,
> >>>
> >>> How can one debug kernel before there is no printk mechanism in kernel.
> >>>
> >>> Regards,
> >>> Krishna Chaitanya
> >>
> >> Write directly to screen memory at 0x000b8000, or write to the
> >> RS-232C UART while polling the TX buf empty bit, or just write
> >> bits that mean something to you out the printer port.
> >>
> >> Screen - memory is 16-bit words with the high-word being
> >> an attibute byte. FYI 0x07 is a good B&W byte. You can
> >> initialize a pointer to it as:
> >>
> >> unsigned short *screen = 0xc00b8000; Since low memory
> >> is always mapped, the above cheat will work. The 0xc0000000
> >> is PAGE_OFFSET.
> >>
> >> An early '486 was brought up into a 32-bit protected-mode
> >> (non linux) operating system using these debugging methods.
> >> The first time I got to see some symbol written to the
> >> screen in protected-mode marked the start of a week-end-
> >> long party. Have fun!
> >>
> >> Cheers,
> >> Dick Johnson
> >> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
> >>   Notice : All mail here is now cached for review by Dictator Bush.
> >>                   98.36% of all statistics are fiction.
> >> -
> >> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> >> in the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by Dictator Bush.
>                   98.36% of all statistics are fiction.
