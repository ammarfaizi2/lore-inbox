Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286728AbRLVIpa>; Sat, 22 Dec 2001 03:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286730AbRLVIpS>; Sat, 22 Dec 2001 03:45:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46088 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286728AbRLVIpG>; Sat, 22 Dec 2001 03:45:06 -0500
Subject: Re: PROBLEM: arcnet bugs in 2.4.x
To: petr@vt.cs.nstu.ru (Petr Bavorovsky)
Date: Sat, 22 Dec 2001 08:48:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112092255.fB9Mtwg18442@vt.cs.nstu.ru> from "Petr Bavorovsky" at Dec 10, 2001 03:57:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HhpY-0003Q3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> arc0: arcnet_header: Yikes!  skb->len(0) !=3D len(18)!
> Unable to handle kernel NULL pointer dereference at virtual address 000=
> 00064
>  printing eip:

It looks like the drivers are making a few assumptions about headers and
length they shouldn't be. I don't think anyone is maintaining ARCnet any
more, all those who worked on it before have moved on to more real
networking. Its one of those things that may well just vanish in 2.5 if
nobody becomes a maintainer.

Looking at the code it looks like arcnet_header is a bit fragile when handed
non random "normal" network layer frames.

The length check is redundant (and wrong) - which explains the message, but
the oops isn't obvious from inspection. Probably you want to turn on debug
and see where in the build/rebuild of the header it dies

Alan

