Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbSKOW3W>; Fri, 15 Nov 2002 17:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbSKOW3E>; Fri, 15 Nov 2002 17:29:04 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:11423 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S266852AbSKOW1X> convert rfc822-to-8bit;
	Fri, 15 Nov 2002 17:27:23 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Justin A <ja6447@albany.edu>
To: Samuli Suonpaa <suonpaa@iki.fi>
Subject: Re: 2.5.47-ac4 panic on boot.
Date: Fri, 15 Nov 2002 17:36:18 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200211150059.51743.ja6447@albany.edu> <200211150254.25306.ja6447@albany.edu> <877kfelcdy.fsf@puck.erasmus.jurri.net>
In-Reply-To: <877kfelcdy.fsf@puck.erasmus.jurri.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211151736.18881.ja6447@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! that lets pcmcia_core load at least...It still doesn't work though:(
I had the same problem with 2.4.19 though, I need to use pcmcia-cs for it to 
work.  pcmcia-cs is 3.2.1 while the kernel is 3.1.22, and I haven't figured 
out how to get pcmcia-cs to work with 2.5 yet:) 

On Friday 15 November 2002 05:02 pm, Samuli Suonpaa wrote:
> Justin A <ja6447@albany.edu> writes:
> > On another note, pcibios_read_config_dword seems to be missing, and
> > pcmcia-core wants it. I'll have to see whats up with that
> > tomorrow...but at least I got it booting now:)
>
> Osamu Tomita sent following fix a few days ago. No rediffed against
> 2.5.47-ac4. With this, I was able to get pcmcia_core loading. On the
> other hand, I seem to be able to crash my Dell Latitude by removing
> and then re-inserting 3c59x -cardbus-adapter. And by trying to reboot
> or halt, so I really cannot tell whether this patch _really_ works.
> But it definitely did something!-)
>
> Suonpää...
>
> --- linux-2.5.47-ac4/drivers/pcmcia/cistpl.c.orig	2002-11-15
> 23:29:24.000000000 +0200 +++
> linux-2.5.47-ac4/drivers/pcmcia/cistpl.c	2002-11-15 23:31:35.000000000
> +0200 @@ -430,7 +430,7 @@
>  #ifdef CONFIG_CARDBUS
>      if (s->state & SOCKET_CARDBUS) {
>  	u_int ptr;
> -	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28,
> &ptr); +	pci_bus_read_config_dword(s->cap.cb_dev->subordinate, 0, 0x28,
> &ptr); tuple->CISOffset = ptr & ~7;
>  	SPACE(tuple->Flags) = (ptr & 7);
>      } else

-- 
-Justin

