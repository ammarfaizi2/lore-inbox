Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWFTKDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWFTKDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWFTKDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:03:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45982 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932551AbWFTKDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:03:35 -0400
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
	underruns, USB HDD hard resets)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andi@lisas.de
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       hal@lists.freedesktop.org
In-Reply-To: <20060620090532.GA6170@rhlx01.fht-esslingen.de>
References: <20060619082154.GA17129@rhlx01.fht-esslingen.de>
	 <20060620013741.8e0e4a22.akpm@osdl.org>
	 <1150794417.11062.30.camel@localhost.localdomain>
	 <20060620090532.GA6170@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jun 2006 11:18:10 +0100
Message-Id: <1150798690.11062.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 11:05 +0200, ysgrifennodd Andreas Mohr:
> But how would HAL safely determine whether a (IDE/USB) drive is busy?
> As my test app demonstrates (without HAL running), the *very first* open()
> happening during an ongoing burning operation will kill it instantly, in the
> USB case.
> Are there any options left for HAL at all? Still seems to strongly point
> towards a kernel issue so far.

In the IDE space O_EXCL has the needed semantics. At least it does on
Fedora and I don't think thats a Fedora patch, not sure if this is the
case for the USB side of things. 

> One (rather less desireable) way I can make up might be to have HAL
> keep the device open permanently and do an ioctl query on whether it's "busy"
> and then quickly close the device again before the newly started
> burning process gets disrupted (if this even properly works at all).

O_EXCL used by cdrecord is probably the right thing

