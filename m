Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWHGUfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWHGUfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWHGUfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:35:19 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:9167 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932346AbWHGUfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:35:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc3-mm2
Date: Mon, 7 Aug 2006 22:34:12 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Jens Axboe <axboe@suse.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060806155454.50935786.akpm@osdl.org> <200608071115.45307.rjw@sisk.pl>
In-Reply-To: <200608071115.45307.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608072234.12238.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 11:15, Rafael J. Wysocki wrote:
> On Monday 07 August 2006 00:54, Andrew Morton wrote:
> > On Mon, 7 Aug 2006 00:42:10 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > On Sunday 06 August 2006 12:08, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > > 
> > > My box's (Asus L5D, x86_64) keyboard doesn't work on this kernel at all, even
> > > if I boot with init=/bin/bash.  On the 2.6.18-rc2-mm1 it worked.
> > > 
> > > Unfortunately I have no indication what can be wrong, no oopses, no error
> > > messages in dmesg, nothing.
> > > 
> > > Right now I'm doing a binary search for the offending patch.
> > > 
> > 
> > Thanks.  I'd zoom in on
> > hdaps-handle-errors-from-input_register_device.patch and git-input.patch.
> 
> None of these, but close: remove-polling-timer-from-i8042-v2.patch breaks
> things here.  [FYI, the box is booted with "noapic", because the IRQ sharing
> doesn't work otherwise due to a BIOS issue, so it may be related.]
> 
> Attached is the dmesg output with i8042.debug=1 for Dmitry.  It's from
> 2.6.18-rc3 with -mm2 partially applied (up to and including
> logips2pp-fix-mx300-button-layout.patch).  I'll apply the rest tonight, after
> I find the patch that broke suspend for me.

Unfortunately this one is git-block.patch.  I have no idea which part of it
may break the suspend.

It hangs during suspend, right after the memory has been shrunk, when devices
should be suspended.  After pressing SysRq-P it shows it's spinning in the
idle thread and then hangs hard.

Greetings,
Rafael
