Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281495AbRKRGXi>; Sun, 18 Nov 2001 01:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281513AbRKRGX3>; Sun, 18 Nov 2001 01:23:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28679 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281495AbRKRGXS>; Sun, 18 Nov 2001 01:23:18 -0500
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sat, 17 Nov 2001 22:17:24 -0800
Message-Id: <200111180617.fAI6HO901257@penguin.transmeta.com>
To: tw@webit.com, linux-kernel@vger.kernel.org
Subject: Re: USB-OHCI + USB broken in 2.4.14/15pre2?
Newsgroups: linux.dev.kernel
In-Reply-To: <3BF735A6.E7E67ABD@webit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BF735A6.E7E67ABD@webit.com> you write:
>
>I tried to "recover" this behavior by temporarily patching
>ohci_pci_resume() so that it does a brutal hc_restart(ohci) instead of
>nothing when detecting this "odd PCI resume" situation - without any
>success.

I would suggest trying to do a "pci_enable_device(dev);" at the very top
of ohci_pci_resume(). It sounds like your suspend/resume doesn't
re-enable PCI interrupt routing, and doing the device enable will make
the kernel re-route the interrupt for you.

If that helps, please send me the tested patch, and forward it to the
appropriate USB people too.

		Linus
