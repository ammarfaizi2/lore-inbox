Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTKMNSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 08:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTKMNSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 08:18:10 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:61355 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S264119AbTKMNSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 08:18:08 -0500
Date: Thu, 13 Nov 2003 14:17:45 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.3.96.1031113064731.23748A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0311131413000.947-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Bill Davidsen wrote:

> For a read-only access, I think the size is what's written, while for
> writing it's the physical size, I think. Does it need to be as complex as
> having the order depend on the access mode? It seems that a size of zero
> is correct for a read access to an unwritten media.

Well, there is only one capacity and we cannot tell at the time we
fetch the capacity from the drive whether the user will use the disk
read-only or read-write.

In any case, cdrom_read_capacity() is the only thing that works on my
MO drive, the other methods all fail. So my patch from yesterday changes 
the order of things so that read_capacity is used first to get the 
capacity, and the other methods are allowed to override it's findings
later on.

-- 
Ciao,
Pascal


