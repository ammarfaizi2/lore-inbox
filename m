Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265300AbSJXDYL>; Wed, 23 Oct 2002 23:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265302AbSJXDYL>; Wed, 23 Oct 2002 23:24:11 -0400
Received: from host179.debill.org ([64.245.56.179]:19649 "EHLO mail.debill.org")
	by vger.kernel.org with ESMTP id <S265300AbSJXDYK>;
	Wed, 23 Oct 2002 23:24:10 -0400
Date: Wed, 23 Oct 2002 22:30:22 -0500
To: Chris Newland <chris.newland@emorphia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 fs corruption
Message-ID: <20021024033022.GA2334@debill.org>
References: <20021023144620.GB1317@debill.org> <OAEPKDBINGEGKPCJJAJDKEMDHJAA.chris.newland@emorphia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OAEPKDBINGEGKPCJJAJDKEMDHJAA.chris.newland@emorphia.com>
User-Agent: Mutt/1.3.28i
From: erik@debill.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 04:13:52PM +0100, Chris Newland wrote:
> My solution was to stick a USB->PS2 converter on my MS Intellimouse.
> Disabling DMA on my hard disks also worked (but causes a massive performance
> hit).
> 
> A good way to test if the problem has gone is to try to 'dd' the contents of
> an entire partition into /dev/null. This used to have a 100% lockup rate
> when I had the problem.
> 
> dd if=/dev/hda5 of=/dev/null bs=1048576


Well...  I went nuts with this and here's what I came up with:

2.5.44 generic driver no DMA no mouse:  works fine
2.5.44 + Viper driver no DMA no mouse:  works fine
2.4.18 generic driver no DMA no mouse:  works fine
2.4.18 generic driver + DMA no mouse:   works fine
2.5.44 + Viper driver + DMA + mouse:    works fine
2.5.44 + Viper driver + DMA no mouse:   lockup

yes.  2.4.18 with the generic PCI DMA driver will let me set the drive
to DMA.  And it works fine.  dd'd the whole drive.  The 2.5 generic
driver won't let me set DMA.

Looks like either I'm just plain lucky under 2.4.18, or there's
something bad w/ the Viper driver.  I've been running 2.4.18 since
June 1 (and other 2.4 kernels before that) without any problems, so
I'm inclined to blame the new kernel version.  It is, after all, a
development kernel.


Erik
