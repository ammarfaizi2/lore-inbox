Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbTE0R5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTE0R4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:56:37 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:6407 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264060AbTE0Rz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:55:56 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527171605.GL845@suse.de>
References: <1053972773.2298.177.camel@mulgrave>
	<20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave>
	<20030526190707.GM845@suse.de> <1053976644.2298.194.camel@mulgrave>
	<20030526193327.GN845@suse.de> <20030527123901.GJ845@suse.de>
	<1054045594.1769.24.camel@mulgrave>  <20030527171605.GL845@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 May 2003 14:09:05 -0400
Message-Id: <1054058946.1769.223.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 13:16, Jens Axboe wrote:
> If you increase it again, the maps are resized. Is that a problem? Seems
> ok to me.

What I mean is that you allocate memory whenever the depth increases. 
Even if you have an array large enough to accommodate the increase
(because you don't release when you decrease the tag depth).

On further examination, there's also an invalid tag race:  If a device
is throttling, it might want to do a big decrease followed fairly
quickly by a small increase.  When it does the increase, you potentially
still have outstanding tags above the new depth, which will now run off
the end of your newly allocated tag array.

James



