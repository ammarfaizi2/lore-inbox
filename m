Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTJQS0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTJQS0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:26:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:35733 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263562AbTJQS0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:26:11 -0400
Date: Fri, 17 Oct 2003 11:19:23 -0700
From: Greg KH <greg@kroah.com>
To: clemens@dwf.com
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       reg@orion.dwf.com
Subject: Re: [ANNOUNCE] udev 003 release
Message-ID: <20031017181923.GA10649@kroah.com>
References: <20031017055652.GA7712@kroah.com> <200310171757.h9HHvGiY006997@orion.dwf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310171757.h9HHvGiY006997@orion.dwf.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 11:57:16AM -0600, clemens@dwf.com wrote:
> 
> The new udev is nice, and it 'works', but Im still having two problems:
>     (1) Although the messages file shows that it is reading my 
>         /etc/udev/namedev.config file, the entries are being ignored.
>         Ive tried both:
> 	    LABEL, BUS="usb", serial="0B0201420527B284", NAME="usb_disk"
>         and
>             LABEL, BUS="usb", vendor="DMI", NAME="usb_disk"
> 
>         and all I get are /udev/ sda, sdb, sdc, sdd, ... as I plug and unplug.

If you turn on debugging for the parser in namedev.c by uncommenting the
comment at the top of the file:
/* define this to enable parsing debugging */
/* #define DEBUG_PARSER */

to look like:

/* define this to enable parsing debugging */
#define DEBUG_PARSER

It will give you a lot of information about what the parser is reading,
and trying to match up with your device.  If you could send me the
system debug log from when you plug in your device with the DEBUG_PARSER
define enabled, I'd be glad to look into it.

>         /udev, I now get just /udev/sda .  Previously (0.2) I got both
>         sda and sda1 .  Needless to say, a mount attempt on /udev/sda1
>         now fails.  [[ and if I tell it NAME="usb_disk" what should I
>         expect for the name of the first partition???
> 
> Am I missing something???

No, I think I broke the partition logic somewhere.  I think the name of
the first partition in this case should be "usb_disk1".  Yeah, it's a
hack for now, hopefully some new libsysfs changes in regards to the
block sysfs tree will help out with this (it's really hard to determine
the partition is different from the main block device right now in
udev.)

Ah, yeah, udev seg faults right now for partitions.  Let me try to track
down the bug, give me a bit of time...

thanks for letting me know,

greg k-h
