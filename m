Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUATRIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265605AbUATRIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:08:50 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:35495 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S265603AbUATRIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:08:47 -0500
Date: Tue, 20 Jan 2004 18:08:44 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for ide-scsi crash
Message-ID: <Pine.LNX.4.44.0401201801190.1508-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Agree, it's a bug. Pascal, care to take a stab at fixing it? You're the
>> most avid ide-cd non-2kb block size user at the moment :)

> There's a lot of macros related to sector sizes in ide-cd.h. I suppose
> all that would need to be changed to depend on the real hardware sector
> size?

I've actually looked at the code now and it seems that it might be
quite easy to fix this, after all.

I have a question about cdrom_start_read_continuation:

Variables called nframes and frames are computed but never used. Only
nskip actually gets factored into the request:

	rq->current_nr_sectors += nskip;

The others are local vars and never get assigned to anything more
global. So I conclude they are meaningless? I ask because this
is one of the places that uses SECTORS_PER_FRAME and it doesn't make
sense to me.

Unrelated question:

Later on, the code decides to use DMA only for requests aligned
on a SECTORS_PER_FRAME boundary. Where does this limitation come from?
Does it come from the drive, so that alignment to 512 byte would be
enough on a drive with 512 byte sectors?

I've actually ordered some 512 byte sector MO discs today and will try
to get them working with ide-cd once they arrive here.

-- 
Ciao,
Pascal

