Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269105AbUJKPlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269105AbUJKPlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUJKPiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:38:21 -0400
Received: from soundwarez.org ([217.160.171.123]:23185 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S269105AbUJKPhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:37:25 -0400
Date: Mon, 11 Oct 2004 17:37:19 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: bert hubert <ahu@ds9a.nl>, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc4] USB && mass-storage && disconnect broken semantics
Message-ID: <20041011153719.GA4118@vrfy.org>
References: <20041011120701.GA824@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011120701.GA824@outpost.ds9a.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 02:07:01PM +0200, bert hubert wrote:
> Ok,
> 
> This is about stupid users (including me) unplugging USB devices whilst
> still mounted, and expecting sane semantics.
> 
> This has generally not been the 'Unix' or even 'Linux' way, but people
> expect it to work. I also see no clear automated and robust solution from
> userspace. "Don't do that then" is a pretty weak answer, especially since we
> want to work on the desktop.
> 
> The expected behaviour is that on forceably unplugging an USB memory stick,
> the created SCSI device should vanish, along with the mounts based on it.

That is clearly bejond the scope of the kernel or hotplug. This policy
belongs to some other device management software. We are currently working on
HAL as one example, to make that happen.

> When the user plugs in the device again, people expect to see it get the
> first available name, and be available for remount, possible automated.
...
> Sometimes however, sda appears to be still 'occupied', and higher names are
> used.
> 
> Now - the perhaps intended behaviour where the user can replug the USB
> device when it was disconnected by accident also does not work. When we do
> this, things get really out of whack, /dev/sda1 has now become invalid.

Forget about the kernel device names, these are "cookies" to access the
device and have no other meaning. Never rely on that longer as your
device session lasts! You may use a udev rule to create a stable name for
your device based on some unique device property and that will work.
Btw: With HAL we even don't care about the /dev-name, all volumes are
recognized by uuid or fslabel.

> Unmounting and unplugging and replugging saves us.
> 
> Greg, others, I hope you agree this needs work. I hope we have the
> infrastructure to umount based on USB disconnect events, or, alternatively,
> will support 'replugging' which at least does part of what people expect.

Yes, we need to make the unplug of mounted devices more safe, especially
with sync mount, but don't expect the kernel or hotplug to do anything
like that. It's up to some policy software higher in the stack.

Thanks,
Kay
