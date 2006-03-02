Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWCBIMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWCBIMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWCBIMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:12:18 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:22459 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751303AbWCBIMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:12:18 -0500
Date: Thu, 2 Mar 2006 09:07:28 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Dean Roe <roe@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at mm/slab.c:2564 - 2.6.16-rc5-g7b14e3b5
Message-ID: <20060302090728.2fee8f3c@localhost>
In-Reply-To: <20060301173636.GA20861@sgi.com>
References: <20060301160656.370e1ee0@localhost>
	<20060301173636.GA20861@sgi.com>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006 11:36:36 -0600
Dean Roe <roe@sgi.com> wrote:

> I might have hit something similar about a month ago running 2.6.16-rc1.
> At the time I had written this off as a hardware problem since I was using
> a questionable system, but maybe there is a hard-to-hit bug in the anon_vma
> or slab code?

Something is happened again here!


Slab corruption: start=ffff81000d0ffb30, len=104
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8015caac>](end_bio_bh_io_sync+0x35/0x39)
000: 6b 6b 6b 2b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=ffff81000d0ffab0, len=104
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<ffffffff80141b05>](mempool_alloc+0x44/0xdf)
000: 3e db d8 05 00 00 00 00 00 00 00 00 00 00 00 00
010: 58 a6 f1 1f 00 81 ff ff 09 00 00 00 00 00 00 00
Next obj: start=ffff81000d0ffbb0, len=104
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8015caac>](end_bio_bh_io_sync+0x35/0x39)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=ffff81000d0ffb30, len=104
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8015caac>](end_bio_bh_io_sync+0x35/0x39)
000: 6b 6b 6b 2b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=ffff81000d0ffab0, len=104
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8015caac>](end_bio_bh_io_sync+0x35/0x39)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff81000d0ffbb0, len=104
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8015caac>](end_bio_bh_io_sync+0x35/0x39)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b


Mmmm... I'm going to disable CPU freq scaling, it's the only thing I've
recently enabled, maybe it's causing some kind of instability ?!

-- 
	Paolo Ornati
	Linux 2.6.16-rc5-g800d1142 on x86_64
