Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265766AbUFDLrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUFDLrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 07:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUFDLrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 07:47:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2736 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265746AbUFDLp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 07:45:57 -0400
Date: Fri, 4 Jun 2004 13:45:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040604114548.GV1946@suse.de>
References: <1085689455.7831.8.camel@localhost> <20040603193107.54308dc9.akpm@osdl.org> <20040604094256.GM1946@suse.de> <200406040722.14026.edt@aei.ca> <20040604113226.GU1946@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604113226.GU1946@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2004, Jens Axboe wrote:
> On Fri, Jun 04 2004, Ed Tomlinson wrote:
> > On June 4, 2004 05:42 am, Jens Axboe wrote:
> > > On Thu, Jun 03 2004, Andrew Morton wrote:
> > > > Ed Tomlinson <edt@aei.ca> wrote:
> > > > >
> > > > > Hi,
> > > > > 
> > > > > I am still getting these ide errors with 7-rc2-mm2.  I  get the errors even
> > > > > if I mount with barrier=0 (or just defaults).  It would seem that something is 
> > > > > sending my drive commands it does not understand...  
> > > > > 
> > > > > May 27 18:18:05 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > > > > May 27 18:18:05 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> > > > > 
> > > > > How can we find out what is wrong?
> > > > > 
> > > > > This does not seem to be an error that corrupts the fs, it just slows things 
> > > > > down when it hits a group of these.  Note that they keep poping up - they
> > > > > do stop (I still get them hours after booting).
> > > > 
> > > > Jens, do we still have the command bytes available when this error hits?
> > > 
> > > It's not trivial, here's a hack that should dump the offending opcode
> > > though.
> > 
> > Hi Jens,
> > 
> > I applied the patch below and booted into the new kernel (the boot
> > message showed the new compile time).  The error messages remained the
> > same - no extra info.  Is there another place that prints this (or
> > (!rq) is true)?
> 
> !rq should not be true, strange... are you sure it just doesn't to go
> /var/log/messages, it should be there in dmesg. Alternatively, add a
> KERN_ERR to that printk.

Sorry my bad, ide-disk has a private dump_status() of course. Let me
provide a new debug and possible fix, hang on.

-- 
Jens Axboe

