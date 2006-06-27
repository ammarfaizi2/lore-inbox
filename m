Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWF0NEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWF0NEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWF0NEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:04:41 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:65231 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932268AbWF0NEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:04:40 -0400
Date: Tue, 27 Jun 2006 15:04:40 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060627150440.0aaf07e1@localhost>
In-Reply-To: <20060627122457.2cabc4d7@localhost>
References: <20060625093534.1700e8b6@localhost>
	<20060625102837.GC20702@suse.de>
	<20060625152325.605faf1f@localhost>
	<20060625174358.GA21513@suse.de>
	<20060627112105.0b15bfa1@localhost>
	<20060627095443.GQ22071@suse.de>
	<20060627122457.2cabc4d7@localhost>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 12:24:57 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> So I suppose that it's already fixed.
> 
> :)

Oppss... even with your GIT tree it doesn't work :(

But this time I think I've found the problem:

--- fs/ext3/super.c ---

ext3_remount()
{
...
	unsigned long fcache_devnum = 0;
...
	if (!parse_options(data, sb, NULL, NULL, &fcache_devnum, &n_blocks_count, 1))
...
        if (fcache_devnum) {
                ext3_close_fcache(sb);
                ext3_open_fcache(sb, fcache_devnum);
        }
...
}

---------------------


If I understand correctly I have to pass the "fdev=..." option not only
when remounting "rw" but even when remounting "ro" before shutdown or
reboot.

Cannot the code figure out this himself al let "mount -o remount,ro"
work?

-- 
	Paolo Ornati
	Linux 2.6.17-gd2581eb4 on x86_64
