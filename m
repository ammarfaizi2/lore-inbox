Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUG2W6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUG2W6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUG2Wzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:55:49 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:60332 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267490AbUG2Wxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:53:55 -0400
Subject: Re: fixing usb suspend/resuming
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>,
       Alexander Gran <alex@zodiac.dnsalias.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729223959.GF18623@elf.ucw.cz>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org>
	 <40F962B6.3000501@pacbell.net>
	 <200407190927.38734@zodiac.zodiac.dnsalias.org>
	 <200407202205.37763.david-b@pacbell.net>
	 <20040729083543.GG21889@openzaurus.ucw.cz>
	 <1091103438.2703.13.camel@desktop.cunninghams>
	 <20040729210256.GC18623@elf.ucw.cz>
	 <1091140000.2703.27.camel@desktop.cunninghams>
	 <20040729223959.GF18623@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1091141476.2703.47.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 30 Jul 2004 08:51:16 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-30 at 08:39, Pavel Machek wrote:
> > I'm assuming (and believe I have achieved) that the only process doing
> > anything significant is suspend, in which case the image isn't going to
> > get damaged.
> 
> Well, only suspend is doing something significant, but driver might
> take arbitrary time to do its DMA... Like
> 
> Freeing some memory... [write starts]
> Suspending devices... [but you did not suspend disk!]
> Atomic copy... [oops, that disk was *still* doing DMA]

Sorry. Should have mentioned that one of my freezer changes includes
running sync between freezing userspace and freezing the kernel threads,
that I double check there are no dirty buffers afterwards and wait on
the completion of all suspend's I/O between after each part of the image
is written/read (have to be paranoid because of the way I reuse LRU
pages).

> > > need something like
> > > 
> > > suspend_fast_ill_resume_you_soon().
> > 
> > Don't understand what you're saying here, sorry.
> 
> Well, I believe we really need to suspend *all* devices. We just do
> not need to spin the disks down and make screens blank; we still need
> drivers to be stopped so that no activity happens during atomic copy.

Ah with you now. The typo got me (_ill_).

