Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbUKJUkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUKJUkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbUKJUh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:37:29 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:12272 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262122AbUKJUgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:36:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AZwbUnrO4CFr922sCTWdPMxrPgaHfd1hBDt7lLqq3wSTcp3nCs9Zd1oUu6hp9aJef8F7iaplNL3jxViaypF7nbYrC+alH398/pJK6//dWwy/48jDnHf3+s0ULDsaU0NUAX/H/8mCDSmIKvLAJgTj1J0X0VXTeS3b5wWVfTNxsiA=
Message-ID: <fb20c214041110123615f89230@mail.gmail.com>
Date: Wed, 10 Nov 2004 14:36:50 -0600
From: Brian Jackson <notiggy@gmail.com>
Reply-To: Brian Jackson <notiggy@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6 vs 2.4: pxe booting system won't restart
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1100111849.20555.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fb20c214041110103647fc6b51@mail.gmail.com>
	 <1100111849.20555.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004 18:37:31 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2004-11-10 at 18:36, Brian Jackson wrote:
> 
> 
> > I'm having a problem with 2.6 (many versions), and my Via Epia M10000
> > not rebooting correctly. 2.4 works fine. The problem is after the
> > computer restarts, and the pxe stuff from the bios tries to do it's
> > thing, it fails. I get the following error:
> > PXE_M0F: Exiting Intel PXE ROM.
> >
> > Then the bios tries to fallback to other means of booting, and there
> > are none. Anybody got any clues where to start looking for fixes?
> 
> Remove the kernel code that powers down the ethernet chip. If that works

Yay, looks like this bit near line 1950 of via-rhine.c:
	/* Hit power state D3 (sleep) */
	writeb(readb(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);

I removed that, and it works like a charm now. Thank you very much.

> then poke VIA.

Poke them to fix the driver or to fix the bios?

> 
>
