Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269037AbUHaT0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269037AbUHaT0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268990AbUHaTYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:24:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47112 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268988AbUHaTQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:16:00 -0400
Date: Tue, 31 Aug 2004 20:15:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MMC block major dev
Message-ID: <20040831201556.B11053@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <4134CDF0.7070600@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4134CDF0.7070600@drzeus.cx>; from drzeus-list@drzeus.cx on Tue, Aug 31, 2004 at 09:13:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 09:13:52PM +0200, Pierre Ossman wrote:
> It seems that the MMC block layer hasn't been assigned a major number. 
> The code registers the block dev with a uninitialized variable. It then 
> proceeds to create a mmc dir under devfs. Since I'm not using devfs this 
> then poses a problem.

First, "uninitialised variables" is a misdescription here.  Variables
declared outside the scope of functions are _always_ initialised even
though there is no apparant assignment.

They're placed in the BSS, or "zero initialised" section.  They have
a well defined value.  Zero.

Registering with the block layer with a major number of zero means
"find me a free major number and assign that to me."  This is nothing
new.  If devfs can't cope with that, devfs is buggy.  Use udev instead.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
