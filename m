Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTBCBK2>; Sun, 2 Feb 2003 20:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbTBCBK2>; Sun, 2 Feb 2003 20:10:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:19103 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265211AbTBCBK0>;
	Sun, 2 Feb 2003 20:10:26 -0500
Date: Sun, 2 Feb 2003 17:20:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-Id: <20030202172005.25758831.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302030210460.26710-100000@artax.karlin.mff.cuni.cz>
References: <20030202160007.554be43d.akpm@digeo.com>
	<Pine.LNX.4.44.0302030210460.26710-100000@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2003 01:19:51.0007 (UTC) FILETIME=[5976A6F0:01C2CB22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
>
> > void wait_and_rw_block(...)
> > {
> > 	wait_on_buffer(bh);
> > 	ll_rw_block(...);
> > }
> 
> It would fail if other CPU submits IO with ll_rw_block after
> wait_on_buffer but before ll_rw_block.

In that case, the caller's data gets written anyway, and the caller will wait
upon the I/O which the other CPU started.  So the ll_rw_block() behaviour is
appropriate.
