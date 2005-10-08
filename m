Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVJHWU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVJHWU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 18:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVJHWU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 18:20:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:36319 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751165AbVJHWU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 18:20:57 -0400
Subject: Re: IDE issues with "choose_drive"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <58cb370e0510080129i80710c7gc2178b9330a1ee19@mail.gmail.com>
References: <1128559019.22073.19.camel@gaston>
	 <1128560569.22073.25.camel@gaston> <1128734104.17365.73.camel@gaston>
	 <58cb370e0510080129i80710c7gc2178b9330a1ee19@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 09 Oct 2005 08:18:33 +1000
Message-Id: <1128809913.17365.78.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It seems we need internal ide_dev_do_request(ide_drive_t *, int)
> which will explicitly state which device we want to service as I see
> no sane way to fix the problem in choose_drive().

Not only that, but if you read my blurb, I wonder how even the
non-targetted case can work properly if we ever hit a couple of the code
path in there that either early exit because the elevator returned no
request or the case where we "sleep" a drive to give more time to the
other... I have the feeling that we may "miss" an opportunity to servive
a drive, and thus this drive will stick around with a pending request
not beeing serviced... I reckon those are corner cases, but I feel the
whole thing need some serious revisiting.

> Your workaround is OK for 2.6.14 given that you will document it
> now and later fix it properly for 2.6.15.

Ok. Well, I'm not sure what is the right fix at the moment given the
other issues I described above, but I'm definitely up to doign a proper
fix for 2.6.15 with your help ;)

Ben.


