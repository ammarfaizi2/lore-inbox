Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVD2O6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVD2O6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVD2O5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:57:36 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:27038 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262756AbVD2O4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:56:04 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 mmap lack of consistency among runs
Date: Fri, 29 Apr 2005 14:25:46 GMT
Message-ID: <0563MQZ12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> > You can disable randomization on a per-executable basis by setting an ELF
> > personality.  I forget the magic incantation.  Arjan?
> 
> setarch -R

I had no success with it:
/usr/src/setarch-1.7/setarch i386 -R /pliant/fullpliant

I even tried adding the following instruction at the very beginning of my
C program, with no more success:
personality(0x0040000); // ADDR_NO_RANDOMIZE

Basically, the behaviour is not changed, as opposed to if I do:
echo 0 >/proc/sys/kernel/randomize_va_space

> > . second, my process restart succeeding roughly in 50% cases means that the
> >   randomisation performed is just a toy. A virus assuming fixed memory layout
> >   will still succeed 50% of times to install.
> 
> It just means that half the time the old value was below the current
> boundary, and half the time above. Eg half the time it was in free
> space and you succeeded but left a gap, the other half there was a conflict.
> Says nothing about the value of randomisation...

Understood.

> > All in all, I'm not concerned about Linux kernel to randomise or not,
> > but I need to have a reliable way to request a memory region and be granted
> > that I can request the same one in a futur run.
> > What is the proper way to get such a memory area ?
>  
> > MAP_FIXED?
> 
> MAP_FIXED is generally a really bad idea though.

If I replace
  PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0
with
  PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0
the call just fails.

