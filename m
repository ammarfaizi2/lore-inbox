Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267647AbTA3WEj>; Thu, 30 Jan 2003 17:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTA3WEi>; Thu, 30 Jan 2003 17:04:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:45240 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267647AbTA3WEi>;
	Thu, 30 Jan 2003 17:04:38 -0500
Message-ID: <3E39A3A2.7807FF00@digeo.com>
Date: Thu, 30 Jan 2003 14:13:54 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Report write errors to applications
References: <20030129060916.GA3186@waste.org> <20030128232929.4f2b69a6.akpm@digeo.com> <20030129162411.GB3186@waste.org> <20030129134205.3e128777.akpm@digeo.com> <20030130211212.GB4357@waste.org> <3E399B93.90B32D12@digeo.com> <20030130220011.GC4357@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jan 2003 22:13:55.0067 (UTC) FILETIME=[E0C40CB0:01C2C8AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> The comment suggests that we need to distinguish read errors from
> write errors and I tend to agree.

OK, well you could call set_buffer_write_io_error/set_buffer_read_io_error()
in the end_io handlers, and pick that up later on.

To avoid adding a couple of new clear_bits in submit_bh,
you could do:

	if (test_set_buffer_req(bh)) {
		clear_buffer_write_io_error(bh);
		clear_buffer_read_io_error(bh);
	}
