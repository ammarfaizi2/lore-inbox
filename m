Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbUAYSM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUAYSM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:12:26 -0500
Received: from colino.net ([62.212.100.143]:27386 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S265078AbUAYSK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:10:57 -0500
Date: Sun, 25 Jan 2004 19:08:32 +0100
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugang <hugang@soulinfo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-Id: <20040125190832.619e3225@jack.colino.net>
In-Reply-To: <1074988008.1262.125.camel@gaston>
References: <20040119105237.62a43f65@localhost>
	<1074483354.10595.5.camel@gaston>
	<1074489645.2111.8.camel@laptop-linux>
	<1074490463.10595.16.camel@gaston>
	<1074534964.2505.6.camel@laptop-linux>
	<1074549790.10595.55.camel@gaston>
	<20040122211746.3ec1018c@localhost>
	<1074841973.974.217.camel@gaston>
	<20040123183030.02fd16d6@localhost>
	<1074912854.834.61.camel@gaston>
	<20040124172800.43495cf3@jack.colino.net>
	<1074988008.1262.125.camel@gaston>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2004 at 10h01, Benjamin Herrenschmidt wrote:

Hi, 

> > Didn't you forget to include include/asm-ppc/suspend.h ? ;-)
> 
> Yes, but you could have re-created it easily: 

Thanks - I wasn't sure about it.
The kernel now builds. However, after doing
	echo disk > /sys/power/state
or "hda14" or "/dev/hda14" (which is my swap partition) instead of "disk", 
nothing happens (and nothing gets logged). 
The only things different from your patch is that I added PMAC_MB_CAN_SLEEP 
to my iBook's entry in pmac_feature.c, and added 
	return -EBUSY; 
after your 
        if (state != 2 && state != 3)
                return 0;
in radeon_pm.c (to avoid pmud putting the iBook to sleep by mistake).

relevant .config part:
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION="/dev/hda14"

Any pointer ? (did I miss something obvious?)

Thanks,
-- 
Colin
