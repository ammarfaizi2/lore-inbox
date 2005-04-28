Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVD1WZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVD1WZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVD1WZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:25:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:26833 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262293AbVD1WZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:25:21 -0400
Subject: Re: IDE problems with rmmod ide-cd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050428172541.GN1876@suse.de>
References: <1114706653.18330.212.camel@localhost.localdomain>
	 <20050428172541.GN1876@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114727044.18330.232.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 23:24:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-28 at 18:25, Jens Axboe wrote:
> The problem you are thinking of was also an ATAPI cache flush command,
> so I'm not so sure I would call it harmless... I haven't changed
> anything in there recently, Bart?

Eeep - I must admit to being somewhat baffled where it is coming from
too. Its occurring between the rmmod starting and the userspace
notifiers from the syslog ordering but I don't see anything that would
queue flushes on the IDE side. The power management does check and
issues WIN_FLUSH_CACHE* stuff. The cd layer only seems to issue it in
the dvd rw close path and that checks media written and mmc3 bits or in
places like cdrom_mrw_exit.

One possibility might be that the specific drive is incorrectly
reporting capabilities and register_cdrom is setting cdi->exit as a
result. Will try and work out what is going on there tomorrow.
