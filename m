Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUHXBMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUHXBMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUHXBHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:07:55 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:52690
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S265027AbUHXBEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:04:04 -0400
Subject: Re: [RFC][PATCH] inotify 0.8.1 [u]
From: John McCutchan <ttb@tentacle.dhs.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1093290259.9495.18.camel@nosferatu.lan>
References: <1092889961.31314.3.camel@vertex>
	 <1093290259.9495.18.camel@nosferatu.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093309447.5519.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 21:04:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 15:44, Martin Schlemmer [c] wrote:
> On Thu, 2004-08-19 at 06:32, John McCutchan wrote:
> 
> Hi
> 
> > I am resubmitting inotify for comments and review. Inotify has
> > changed drastically from the earlier proposal that Al Viro did not
> > approve of. There is no longer any use of (device number, inode number)
> > pairs. Please give this version of inotify a fresh view.
> > 
> 
> I applied this to 2.6.8.1 and most of -mm4's patches - it applied
> cleanly and compiled fine.
> 
> I use devicemapper to stripe two 80gb sata drives on intel sata
> controller, using initramfs.
> 
> Now when I boot, I see something like:
> 
> ---
> BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
> Freeing unused kernel memory: 264k freed
> inotify device opened
> dm ioctl error or such
> ---
> Which then results in a panic as the dm volumes cannot be setup
> and no / found by kernel.  So basically it seems like inotify
> mess with dm in some way or other - any quick ideas what it
> could be?
> 

This is very strange. 'inotify device opened' is printed when an app
opens /dev/inotify. Do you have code that is doing that? I am wondering
if inotify's MAJOR/MINOR is getting confused with device mappers. I
don't know how it could be happening since /dev/inotify has the kernel
assign it an available minor number, and its major number is the major
number for all misc char devices.

> I do not have serial console, so if you need a more complete log,
> just let me know from where abouts I should start, and if any
> debugging should be turned on, etc.

Could you find out what the major/minor numbers are on /dev/inotify and
whatever dev device mapper has?

Thanks for testing.

John
