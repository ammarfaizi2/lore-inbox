Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265698AbUF2KxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUF2KxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 06:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbUF2KxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 06:53:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:9606 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265698AbUF2KxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 06:53:12 -0400
Date: Tue, 29 Jun 2004 12:53:10 +0200 (CEST)
From: Steffen Winterfeldt <snwint@suse.de>
To: Kurt Garloff <garloff@suse.de>
Cc: Bart Hartgers <bart@etpmod.phys.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: hwscan hangs on USB2 disk - SCSI_IOCTL_SEND_COMMAND
In-Reply-To: <20040629094557.GR4732@tpkurt.garloff.de>
Message-ID: <Pine.LNX.4.58.0406291250200.27235@ligeti.suse.de>
References: <20040629093739.40243364C@etpmod.phys.tue.nl>
 <20040629094557.GR4732@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Jun 2004, Kurt Garloff wrote:

> On Tue, Jun 29, 2004 at 11:37:36AM +0200, Bart Hartgers wrote:
> > The problem is that both hwscan and usb-storage get stuck in the 'D"
> > state until I unplug the harddisk.
> > 
> > A strace of hwscan shows:
> > 
> > 21141 open("/dev/sda", O_RDONLY|O_NONBLOCK) = 3
> > 21141 ioctl(3, 0x301, 0xbfffeba0)       = 0
> > 21141 ioctl(3, BLKSSZGET, 0xbfffeb9c)   = 0
> > 21141 ioctl(3, 0x80041272, 0xbfffeb90)  = 0
> > 21141 ioctl(3, FIBMAP, 0xbfffec40)      = 0  <--- hwscan gets stuck here

[...]

> Does it work if you send the INQUIRY with 36 bytes allocation length?
> scsi_cmd_buf[8 + 4] = 0x26;

It's indeed the inquiry size, sticking to the minium 36 bytes helps. 
That's fixed in sles9. Update for 9.1 planned.


Steffen
