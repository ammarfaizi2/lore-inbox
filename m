Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTKLQdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbTKLQdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:33:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:20389 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262679AbTKLQdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:33:10 -0500
Date: Wed, 12 Nov 2003 08:33:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Andreas Jellinghaus <aj@dungeon.inka.de>, <linux-kernel@vger.kernel.org>
Subject: Re: ide cdrom sg like access / rpcmgr ?
In-Reply-To: <20031112143130.GL21141@suse.de>
Message-ID: <Pine.LNX.4.44.0311120829060.3288-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Nov 2003, Jens Axboe wrote:
> 
> To make the below work, all you probably need to do is change sgio() to
> use CDROM_SEND_PACKET for instance. That'll work in 2.4 and 2.6. You
> just need to fill a cdrom_generic_command and send it to the cdrom fd.

Don't forget: you also need to open the device with "O_NONBLOCK", so as to 
not make the kernel try to figure out the media etc. Otherwise you can't 
do anything with media that the kernel can't figure out (ie empty media 
that hasn't been written to, or even no media at all).

Depending on what your tool is for, this may or may not be a problem, of 
course. If you only want to send commands to a drive that already has a 
readable media in it, you can skip the O_NONBLOCK.

		Linus

