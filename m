Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263391AbTEMJev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 05:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTEMJev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 05:34:51 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:2570 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263391AbTEMJeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 05:34:50 -0400
Date: Tue, 13 May 2003 11:47:33 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/devices for block devices
Message-ID: <20030513094733.GA28743@win.tue.nl>
References: <20030513083959.A20052@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513083959.A20052@lst.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote [on /proc/devices]:

> We could either
> 
>  (a) nuke it completly - if you need to find out the dev_t for your
>      block driver with dynamic dev_t allocation you can look at
>      /proc/partitions (portable to older kernels) or sysfs instead.
>  (b) add some cludges

A grep on a random source tree shows:

A number of programs search /proc/devices for their favourite string,
find the device number and do mknod on it. Thus apmd for "apm_bios"
and IMonLinux for "imon" and hwcrypto for "paep" and "cryptonet".

Apart from for finding out dev_t, /proc/devices is used for
just checking that a certain driver exists in a certain kernel.

There are FAQs that tell people to check for "lp" or "sg"
or "sound" or "pcmcia" in /proc/devices.

The program anaconda checks /proc/devices for "fd" and for "pcmcia".
Various initscripts check for "usb", "sound", "sparcaudio".
SANE checks for "sg". Setserial checks for "ttyS".
Lomount and mount check for "loop".

LVM programs go the other way and use /proc/devices to find out
whether the device with given device number is of type "ide", "sd",
"nbd", "loop" etc.

Andries

