Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265328AbRF2QaB>; Fri, 29 Jun 2001 12:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265416AbRF2Q3v>; Fri, 29 Jun 2001 12:29:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33288 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265328AbRF2Q3q>; Fri, 29 Jun 2001 12:29:46 -0400
Subject: Re: VFS locking & HFS problems (2.4.6pre6)
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 29 Jun 2001 17:29:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010629161052.15124@smtp.adsl.oleane.com> from "Benjamin Herrenschmidt" at Jun 29, 2001 06:10:52 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15G18r-0000ab-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yup. It's the problem. It locks, then calls some alloc routines, which
> fills a cache and uses kmalloc with GFP_KERNEL.

Thats quite common. If it can safely sleep there without other deadlocks a
semaphore may be better

> Turning it into GFP_ATOMIC might not be the best idea as the HFS
> filesystem currently shares a single hfs_malloc() for everybody and
> turning it into GFP_ATOMIC would cause all of HFS allocs to be atomic.

Another approach is to prealloc the object and pass it in, then free it
if not needed
