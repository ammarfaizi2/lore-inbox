Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUJKMTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUJKMTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268861AbUJKMTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:19:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63239 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268856AbUJKMTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:19:23 -0400
Date: Mon, 11 Oct 2004 13:19:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: MMC performance
Message-ID: <20041011131919.B19175@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <416A68E5.6080608@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <416A68E5.6080608@drzeus.cx>; from drzeus-list@drzeus.cx on Mon, Oct 11, 2004 at 01:05:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 01:05:09PM +0200, Pierre Ossman wrote:
> Writing, however, only sends a single sector at a time. The queue 
> process eats up half of the CPU time on my machine during a write. And 
> since MMC cards have to clear a whole bunch of sectors before a write 
> shouldn't you send as many sectors as possible to them?

Only if you can reliably know how many bytes you've tranferred when
an error occurs.  Without that, the only safe way to do a write is
sector by sector.

And there are MMC controllers which just don't give you that
information, namely those found in Intel chips...

Since I'm having to be compatible with existing drivers, we need to
do this for the time being.  It's a shame we can't tell the BIO layer
about this type of quirk though.  Not that BIO itself understands
"sector by sector" IO at the moment.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
