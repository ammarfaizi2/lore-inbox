Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWFTJFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWFTJFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWFTJFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:05:34 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:34974 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S965079AbWFTJFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:05:34 -0400
Date: Tue, 20 Jun 2006 11:05:32 +0200
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       hal@lists.freedesktop.org
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner underruns, USB HDD hard resets)
Message-ID: <20060620090532.GA6170@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060619082154.GA17129@rhlx01.fht-esslingen.de> <20060620013741.8e0e4a22.akpm@osdl.org> <1150794417.11062.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150794417.11062.30.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 20, 2006 at 10:06:56AM +0100, Alan Cox wrote:
> Ar Maw, 2006-06-20 am 01:37 -0700, ysgrifennodd Andrew Morton:
> > [hald polling causes cdrecord to go bad on a USB CD drive]
> > 
> > One possible reason is that we're shooting down the device's pagecache by
> > accident as a result of hald activity. 
> 
> On IDE hal causes problems with some drives because the additional
> commands sent while the drive is busy end up timing out which triggers a
> bus reset and breaks everything. Really HAL should have better manners
> than to poll a drive that is busy.

But how would HAL safely determine whether a (IDE/USB) drive is busy?
As my test app demonstrates (without HAL running), the *very first* open()
happening during an ongoing burning operation will kill it instantly, in the
USB case.
Are there any options left for HAL at all? Still seems to strongly point
towards a kernel issue so far.

One (rather less desireable) way I can make up might be to have HAL
keep the device open permanently and do an ioctl query on whether it's "busy"
and then quickly close the device again before the newly started
burning process gets disrupted (if this even properly works at all).

Andreas Mohr
