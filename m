Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWETTth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWETTth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 15:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWETTth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 15:49:37 -0400
Received: from mx2.rowland.org ([192.131.102.7]:31493 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751439AbWETTtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 15:49:36 -0400
Date: Sat, 20 May 2006 15:49:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Jens Axboe <axboe@suse.de>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Efficient media-not-present detection
Message-ID: <Pine.LNX.4.44L0.0605201534000.29313-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The block layer detects missing media during open() via a two-step
process.  First it invokes the media_changed() method, and if that returns
a positive result it invokes the revalidate_disk() method, which will
realize that no media is present.

This ends up doing twice as much work as needed.  Often the
media_changed() method is capable of detecting whether media is present;  
if it isn't there's no reason to call revalidate_disk().  Applications
like hald that poll drives to see when media is present therefore end up
generating twice the necessary overhead.

To remedy this would require altering the meaning of the return value from
media_changed().  Something like: 0 for no change, -ENOMEDIUM for media
definitely not present, anything else for media changed or possibly not
present.

This would be a fairly big change since there a lot of block device
drivers.  Is there any reason to think it shouldn't be done?

Alan Stern

