Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVARLzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVARLzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVARLza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:55:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58781 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261257AbVARLzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:55:21 -0500
Date: Tue, 18 Jan 2005 06:45:26 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118084526.GB25979@logos.cnet>
References: <20050115233530.GA2803@darkside.22.kls.lan> <20050117194635.GD22202@logos.cnet> <20050118105547.GD8747@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118105547.GD8747@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andries,

On Tue, Jan 18, 2005 at 11:55:47AM +0100, Andries Brouwer wrote:
> On Mon, Jan 17, 2005 at 05:46:35PM -0200, Marcelo Tosatti wrote:
> > On Sun, Jan 16, 2005 at 12:35:30AM +0100, Mario Holbe wrote:
> 
> > > mounting an ext2 (ext3 as well) filesystem seems to modify the
> > > block device's EOF behaviour: before the mount the device returned
> > > EOF, after the mount it doesn't anymore:
> > > 
> > > [on a fresh booted system]
> > > root@darkside:~# uname -a
> > > Linux darkside 2.4.27 #1 Sat Jan 15 17:07:20 CET 2005 i686 GNU/Linux
> > > root@darkside:~# dd if=/dev/hdg7 of=/dev/null
> > > 9992366+0 records in
> > > 9992366+0 records out
> > > root@darkside:~# mount -t ext2 -o ro /dev/hdg7 /mnt
> > > root@darkside:~# umount /dev/hdg7
> > > root@darkside:~# dd if=/dev/hdg7 of=/dev/null
> > > attempt to access beyond end of device
> > > 22:07: rw=0, want=4996184, limit=4996183
> > > dd: reading `/dev/hdg7': Input/output error
> > > 9992360+0 records in
> > > 9992360+0 records out
> > > root@darkside:~# bc
> > > 1249045 * 4
> > > 4996180
> > > 1249045 * 4 * 2
> > > 9992360
> > > 
> > > Could somebody please explain this to me? Is this intentional?
> > 
> > No
> > 
> > Its indeed strange.
> 
> I suppose that what happens is the following:
> mounting sets the blocksize to 4096.
> After reading 9992360 sectors, reading the next block means reading
> the next 8 sectors and that fails because only 6 sectors are left.

So this is either not a Linux error and not a disk error, its just that the
"use with filesystem" then "direct access" is a unfortunate combination.

What would be the correct fix for this for this, if any? 

v2.6 should suffer from the same issues?

> Test that this is what happens using blockdev --getbsz.
> 
> If you want to restore the device to full size, use
> blockdev --setbsz 512.



