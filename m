Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTFWXZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFWXZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:25:07 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:42257 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262294AbTFWXZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:25:03 -0400
Date: Tue, 24 Jun 2003 01:39:08 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Luis Miguel Garcia <ktech@wanadoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel & BIOS return differing head/sector geometries
Message-ID: <20030624013908.B1133@pclin040.win.tue.nl>
References: <20030624010906.08ad32f3.ktech@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030624010906.08ad32f3.ktech@wanadoo.es>; from ktech@wanadoo.es on Tue, Jun 24, 2003 at 01:09:06AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 01:09:06AM +0200, Luis Miguel Garcia wrote:

> I'm getting this while running lilo from kernel 2.5.72mm2. What does it means?
> bash-2.05b# lilo
> Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
>     Kernel: 13424 cylinders, 15 heads, 63 sectors
>       BIOS: 788 cylinders, 255 heads, 63 sectors

It means that Kernel and BIOS each invent a fake geometry for your disk,
and they did not invent the same fake geometry.

> Could it be dangerous?

No.

Linux does not use the BIOS, and does not use CHS either, so geometry is
totally and completely irrelevant to Linux.

Depending on the precise LILO version, and on whether you give options
like "linear" and "lba32", LILO might or might not be confused.
Test whether you can boot. If booting works all is well. If not
make sure you set at least one of "linear" and "lba32".

If you also have DOS on the same disk the story is more complicated.
All systems on a disk must agree as to where the partitions are,
or corruption will be the result.

