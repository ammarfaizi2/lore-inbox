Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWA0SxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWA0SxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWA0SxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:53:15 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:32246 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751541AbWA0SxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:53:13 -0500
Date: Fri, 27 Jan 2006 13:53:06 -0500 (EST)
From: Ariel <askernel2615@dsgml.com>
To: Chase Venters <chase.venters@clientec.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, axboe@suse.de, jamie@audible.transient.net,
       neilb@suse.de, arjan@infradead.org
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
In-Reply-To: <200601270410.06762.chase.venters@clientec.com>
Message-ID: <Pine.LNX.4.62.0601271342000.8977@pureeloreel.qftzy.pbz>
References: <200601270410.06762.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found a patch called: slab-leak-detector.patch and applied it (manually 
since it's for a slightly older kernel).

Here are the results: (after leaking about 1MB)

c03741ba <__scsi_get_command+0x29/0x73>

Is the leaker with 294 of them, vs 4 of:

c03743fd <scsi_setup_command_freelist+0xb0/0x101>

and 21:
fffffffe <0xfffffffe>

I'm not sure how helpful that result is though, since I guess we already 
knew it was scsi, and from the other email, that's it's also some 
interaction with md.

 	-Ariel
