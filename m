Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVKLXli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVKLXli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVKLXli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:41:38 -0500
Received: from mail.gmx.de ([213.165.64.20]:37260 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964881AbVKLXlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:41:37 -0500
X-Authenticated: #20450766
Date: Sun, 13 Nov 2005 00:42:02 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: userspace block driver?
In-Reply-To: <Pine.LNX.4.60.0511092130230.9330@poirot.grange>
Message-ID: <Pine.LNX.4.60.0511130029120.4090@poirot.grange>
References: <4371A4ED.9020800@pobox.com> <Pine.LNX.4.60.0511092130230.9330@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 9 Nov 2005, Jeff Garzik wrote:
> 
> > 
> > Has anybody put any thought towards how a userspace block driver would work?
> > 
> > Consider a block device implemented via an SSL network connection.  I don't
> > want to put SSL in the kernel, which means the only other alternative is to
> > pass data to/from a userspace daemon.
> > 
> > Anybody have any favorite methods?  [similar to] mmap'd packet socket? ramfs?

Hm, how about a simple trick:

you write a "remote resource access" filesystem and do

mount -t remote_resourse -o access_control.conf 192.168.1.1 /mnt/server1

then you "just" write a library to overload open, close, read, write, 
ioctl,... do

export LD_PRELOAD=remote_libc.so

and then

mount /mnt/server1/hda1 /usr/local

In /mnt/server1/ you could have interesting things like

mouse0
dsp0

or even

network0
node0/cpu0
node0/ram0

Simple, sin't it?:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
