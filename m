Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVCIV50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVCIV50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVCIV5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:57:25 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:56326 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261592AbVCIVzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:55:50 -0500
Date: Wed, 9 Mar 2005 22:55:59 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Chris Wright <chrisw@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Daniel Staaf <dst@bostream.nu>,
       LKML <linux-kernel@vger.kernel.org>,
       Andrei Mikhailovsky <andrei@arhont.com>,
       Ian Campbell <icampbell@arcom.com>,
       Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Gerd Knorr <kraxel@bytesex.org>, stable@kernel.org
Subject: Re: [PATCH 2.6] Fix i2c messsage flags in video drivers
Message-Id: <20050309225559.061058dd.khali@linux-fr.org>
In-Reply-To: <20050309184055.GX28536@shell0.pdx.osdl.net>
References: <1110024688.5494.2.camel@whale.core.arhont.com>
	<422A5473.7030306@osdl.org>
	<1110115990.5611.2.camel@whale.core.arhont.com>
	<422CCBF4.1060902@osdl.org>
	<20050308201504.6aee36d5.khali@linux-fr.org>
	<20050308202530.2fbfae9a.khali@linux-fr.org>
	<20050309184055.GX28536@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> > While working on the saa7110 driver I found a problem with the way
> > various video drivers (found on Zoran-based boards) prepare i2c
> > messages to be used by i2c_transfer. The drivers improperly copy the
> > i2c client flags as the message flags, while both sets are mostly
> > unrelated. The net effect in this case is to trigger an I2C block
> > read instead of the expected I2C block write. The fix is simply not
> > to pass any flag, because none are needed.
> > 
> > I think this patch qualifies hands down as a "critical bug fix" to
> > be included in whatever bug-fix-only trees exist these days. As far
> > as I can see, all Zoran-based boards are broken in 2.6.11 without
> > this patch.
> 
> Are people reporting this as a problem?

Not that I know. For adv7175 it couldn't be reported so far anyway
because people would hit the oops in saa7110 before (same board: DC10+,
oops fixed in a different patch).

It is possible that people are able to get their board to still work
without my patch, if the chips were properly configured in the first
place and they don't attempt to reconfigure them (like norm change). I
don't know the chips well enough to tell how probable this is.

Thanks,
-- 
Jean Delvare
