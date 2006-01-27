Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWA0Slp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWA0Slp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWA0Slp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:41:45 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:37826 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932175AbWA0Slo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:41:44 -0500
Date: Fri, 27 Jan 2006 13:41:31 -0500 (EST)
From: Ariel <askernel2615@dsgml.com>
To: Chase Venters <chase.venters@clientec.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, axboe@suse.de, jamie@audible.transient.net,
       neilb@suse.de, arjan@infradead.org
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
In-Reply-To: <200601270410.06762.chase.venters@clientec.com>
Message-ID: <Pine.LNX.4.62.0601271335470.8977@pureeloreel.qftzy.pbz>
References: <200601270410.06762.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Jan 2006, Chase Venters wrote:

> 	After dealing with this leak for a while, I decided to do some dancing around
> with git bisect. I've landed on a possible point of regression:
>
> commit: a9701a30470856408d08657eb1bd7ae29a146190
> [PATCH] md: support BIO_RW_BARRIER for md/raid1

I can confirm that it only leaks with raid!

I rebooted with my raid5 root, read only, and it didn't leak. As soon as I 
remount,rw it started leaking. Go back to ro and it stopped (although it 
didn't clean up the old leaks). Tried my raid1 /boot and same thing - rw 
leaks, ro doesn't. But, it only leaks on activity.

I then tried a regular lvm mount (with root ro), and no leaks!

What's interesting is that the mount was ro NOT the md (which can be set 
ro independently). So it looks like it only leaks if you write to the md 
device, and that's why setting the mount ro stopped the leaks.

 	-Ariel
