Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbTCMGBr>; Thu, 13 Mar 2003 01:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTCMGBr>; Thu, 13 Mar 2003 01:01:47 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:11027 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262178AbTCMGBq>; Thu, 13 Mar 2003 01:01:46 -0500
Date: Thu, 13 Mar 2003 01:11:44 -0500
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in firewire (2.4.21-pre5 with 2.4.21-pre4 firewire driver)
Message-ID: <20030313061144.GV563@phunnypharm.org>
References: <1047517628.1172.8.camel@rohan.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047517628.1172.8.camel@rohan.arnor.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 05:06:23PM -0800, Torrey Hoffman wrote:
> I heard that the firewire merge in 2.4.21-pre5 was messed up, so I
> replaced the -pre5 drivers/ieee1394 with the one from -pre4.

I'd suggest with trying the latest BK cset patch (which fixes -pre5 and
also fixes some things in general).

> I got an oops while loading the driver.  I will continue to experiment
> with recent kernels, and try to find a bitkeeper snapshot with the
> latest firewire fixes.  Any suggestions are welcome.

> >>EIP; c016e639 <__journal_remove_checkpoint+39/90>   <=====

This happened in the kjournald thread context. I'm not sure it is
ieee1394 related, but it is suspect that it happened in the middle of
handling an ieee1394 bus reset.

Is this reproducible when loading the ohci1394 driver? If so, does it
occur when you turn off hotplug (IOW, don't load sbp2 driver) or if the
sbp2 device is not attached?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
