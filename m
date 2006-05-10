Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWEJXHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWEJXHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWEJXHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:07:51 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:15325 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S965065AbWEJXHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:07:50 -0400
Message-ID: <4462723B.9060309@dunaweb.hu>
Date: Thu, 11 May 2006 01:07:39 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in au8830 driver on x86-64
References: <446271C6.9050509@dunaweb.hu>
In-Reply-To: <446271C6.9050509@dunaweb.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi írta:
> Hi,
>
> I bought a used sound card for secondary uses, it happens to be
> a Diamond Sound Monster MX300 with an Aureal Vortex2 chip.
> Unfortunately, after putting it into the machine, it doesn't boot up,
> I get an oops that prevents booting further. I have hand-copied
> the relevant info:
>
> RIP: {:snd_au8830:snd_vortex_probe+411}
> ...
> Call Trace: {sprintf+81} {__wake_up+56}
> {pci_device_probe+256} {driver_probe_device+82}
> {__driver_attach+142} {__driver_attach+0}
> {bus_for_each_dev+67} {bus_add_driver+118}
> {__pci_register_driver+142} {stop_machine_run+58}
> {sys_init_module+278} {system_call+126}
>
> The kernel is not tainted.
>
> $ uname -a
> Linux xxxxxx 2.6.16-1.2111_FC5 #1 SMP Thu May 4 21:16:04 EDT 2006 
> x86_64 x86_64 x86_64 GNU/Linux
>
> System is an FC5/x86-64 updated to the latest erratas.
>
> There is only one sprintf() call in the whole au88x0 driver source,
> line 328 in au88x0.c. Why it fails for x86-64 is beyond my understanding.
> This is the code in question:
>
> 327:    strcpy(card->shortname, CARD_NAME_SHORT);
> 328:    sprintf(card->longname, "%s at 0x%lx irq %i",
>                card->shortname, chip->io, chip->irq);
>
> Pointer "card" exists or the driver would have failed earlier 
> allocating or dereferencing it.
> card->longname is 80 byte large, length of the string is at most 44 byte:
> 12 byte (format string fillings + terminating NULL) +
> 6 byte (CARD_NAME_SHORT) +
> 6 byte (unsigned long written in hex) +

This is 16, not 6, before anyone complains I can't count. :-)

> 10 byte (unsigned int written in dec)
>
> I couldn't seek further, I put the card away for now. :-)
>
> Best regards,
> Zoltán Böszörményi
>
>

