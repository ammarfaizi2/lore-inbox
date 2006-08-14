Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752058AbWHNSjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbWHNSjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWHNSjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:39:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:32926 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752052AbWHNSju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:39:50 -0400
Message-ID: <44E0C373.6060008@garzik.org>
Date: Mon, 14 Aug 2006 14:39:47 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Getting 'sync' to flush disk cache?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So...  has anybody given any thought to enabling fsync(2), fdatasync(2), 
and sync_file_range(2) issuing a [FLUSH|SYNCHRONIZE] CACHE command?

This has bugged me for _years_, that Linux does not do this.  Looking at 
forums on the web, it bugs a lot of other people too.

My suggestion would be to add a FLUSH op alongside the existing READ and 
WRITE[_SYNC] ops, rather than passing down WRITE_SYNC.  Why?  Doing so 
maintains a 1-1 translation between requests and disk commands, and it 
would allow MD and DM more flexibility in handling this operation.

But that's just a guess.  I'm open to suggestions.

	Jeff


