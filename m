Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWFUJKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWFUJKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWFUJKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:10:35 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:62175 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751427AbWFUJKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:10:35 -0400
Date: Wed, 21 Jun 2006 11:10:33 +0200
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hal@lists.freedesktop.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB/hal: USB open() broken? (USB CD burner underruns, USB HDD hard resets)
Message-ID: <20060621091033.GA11447@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060619082154.GA17129@rhlx01.fht-esslingen.de> <20060620013741.8e0e4a22.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620013741.8e0e4a22.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 20, 2006 at 01:37:41AM -0700, Andrew Morton wrote:
> On Mon, 19 Jun 2006 10:21:54 +0200
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> 
> > I'm having severe issues with cdrecord aborting with "buffer underrun"
> > message, *always*. Problem nailed, see below.
> 
> [hald polling causes cdrecord to go bad on a USB CD drive]
> 
> One possible reason is that we're shooting down the device's pagecache by
> accident as a result of hald activity.  This shouldn't happen, but still.
> Could you please do
> 
> `watch -n1 cat /proc/meminfo' and/or `vmstat 1'
> 
> then run cdrecord
> 
> then wait a bit
> 
> then run hald, see if the amount of pagecache (/proc/meminfo:Buffers or
> /proc/meminfo:Cached) suddenly decreases.
> 
> If the answer is "no" then I guess there's some unpleasant interaction
> happening at the USB level

"no":
both values don't show any noticeable decrease whatsoever upon a second
parallel open() of the device which makes burning abort.

It seems to be a USB thingy, as I will show in my next mail.

Andreas Mohr
