Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWAZSMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWAZSMy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAZSMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:12:54 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:50111 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932359AbWAZSMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:12:53 -0500
Date: Thu, 26 Jan 2006 13:12:42 -0500 (EST)
From: Ariel <askernel2615@dsgml.com>
To: Jamie Heilman <jamie@audible.transient.net>
cc: Chase Venters <chase.venters@clientec.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
In-Reply-To: <20060123072556.GC15490@fifty-fifty.audible.transient.net>
Message-ID: <Pine.LNX.4.62.0601261312160.1174@pureeloreel.qftzy.pbz>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
 <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz>
 <1137997104.2977.7.camel@laptopd505.fenrus.org> <200601230029.12674.chase.venters@clientec.com>
 <Pine.LNX.4.62.0601230136080.22979@pureeloreel.qftzy.pbz>
 <20060123072556.GC15490@fifty-fifty.audible.transient.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Jan 2006, Jamie Heilman wrote:

> Ariel wrote:

>> ata_piix seems like it's in common for all, but this is not a lot of

> Hmm.  I just moved my sata_sil stuff out of the way and rebooted:

> $ uptime; grep scsi_cmd_cache /proc/slabinfo
> 23:22:16 up 4 min,  1 user,  load average: 0.00, 0.03, 0.00
> scsi_cmd_cache      1200   1200    384   10    1 : tunables   54   27 
8 : slabdata    120    120    $

Is this good or bad? I'm guessing it means it's still leaking. So it's
really starting to look like ata_piix is the problem. But we need someone
who has the leak to remove that and see if it helps. I can't, since my
drives are connected to it.

And developers:

Can anyone PLEASE take a look at this? We've got 4 confirmed reports of
it, and it's nothing to do with a tainted module. Take a look at this
slabtop output:

    OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
1230120 1230120 100%   0.38K 123012      10    492048K scsi_cmd_cache

I have a 492MB leak! And notice how objects never become unused - that
looks like the problem.

         -Ariel


