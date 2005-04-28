Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVD1PAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVD1PAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVD1PAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:00:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:35535 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262086AbVD1PAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:00:00 -0400
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mike.miller@hp.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, brace@hp.com
In-Reply-To: <20050427184022.GA16129@beardog.cca.cpqcorp.net>
References: <20050427184022.GA16129@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114700283.24687.193.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 15:58:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-04-27 at 19:40, mike.miller@hp.com wrote:
> It looks like the OS/filesystem (ext2/3 and reiserfs) does not wait for for a successful completion. Is this assumption correct?

Of course it doesn't. At 250 ops/second for a decent disk no OS waits
for completions, all batch and asynchronously queue I/O. See man fsync
and also O_DIRECT if you need specific "to disk" support. If you do that
be aware that you must also turn write caching off on the IDE disk. I've
repeatedly asked the "maintainer" of the IDE layer to do this
automatically but gave up bothering long ago. Without that setting users
are playing with fire quite honestly.

The alternative with latest 2.6 stuff is to turn on Jens Axboe's barrier
work which seems to give better performance on a drive new enough to
have cache flush operations.

Alan

