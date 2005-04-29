Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVD2NfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVD2NfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVD2NfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:35:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38833 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262598AbVD2New (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:34:52 -0400
Date: Fri, 29 Apr 2005 15:34:33 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hubert Tonneau <hubert.tonneau@fullpliant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 mmap lack of consistency among runs
Message-ID: <20050429133432.GA13004@devserv.devel.redhat.com>
References: <0563I2L12@server5.heliogroup.fr> <20050429062053.2c9943ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429062053.2c9943ce.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 06:20:53AM -0700, Andrew Morton wrote:
> >   application can only speak for itself so desabling should be on a per process
> >   bias.
> 
> You can disable randomization on a per-executable basis by setting an ELF
> personality.  I forget the magic incantation.  Arjan?

setarch -R

> 
> >   I can hardly imagine to publish a warning in the README such as:
> >   This software only works if your Linux kernel is configured so that
> >   /proc/sys/kernel/randomize_va_space = 0
> > 
> > . second, my process restart succeeding roughly in 50% cases means that the
> >   randomisation performed is just a toy. A virus assuming fixed memory layout
> >   will still succeed 50% of times to install.
> 
> Dunno.

It just means that half the time the old value was below the current
boundary, and half the time above. Eg half the time it was in free
space and you succeeded but left a gap, the other half there was a conflict.
Says nothing about the value of randomisation...


> 
> > All in all, I'm not concerned about Linux kernel to randomise or not,
> > but I need to have a reliable way to request a memory region and be granted
> > that I can request the same one in a futur run.
> > What is the proper way to get such a memory area ?
> 
> MAP_FIXED?

MAP_FIXED is generally a really bad idea though.
