Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUFCObV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUFCObV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbUFCObS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:31:18 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:26120 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S265148AbUFCOal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:30:41 -0400
Subject: Re: Process hangs on blk_congestion_wait copying large file to
	cifs filesystem
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1085760260.2422.11.camel@taz.graycell.biz>
References: <1085672706.4350.9.camel@taz.graycell.biz>
	 <1085753249.2219.13.camel@taz.graycell.biz>
	 <20040528142239.GK20657@suse.de>
	 <1085760260.2422.11.camel@taz.graycell.biz>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 03 Jun 2004 15:30:39 +0100
Message-Id: <1086273039.8873.1.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2004 14:25:44.0186 (UTC) FILETIME=[A7B545A0:01C44976]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sex, 2004-05-28 at 17:04 +0100, Nuno Ferreira wrote:
> OK, apparently now the cp never finishes and nothing gets written to
> disk, so i could not get the full output from sysrq-t.
> I wrote the call stack from the process, it that enough?
> The call stack from the cp process:
> __make_request
> schedule_timeout
> process_timeout
> io_schedule_timeout
> blk_congestion_wait
> autoremove_wake_function
> autoremove_wake_function
> get_dirty_limits
> balance_dirty_pages
> generic_file_aio_write_nolock
> __copy_to_user_ll
> file_read_actor
> __generic_file_aio_read
> file_read_actor
> generic_file_write_nolock
> do_sync_read
> do_IRQ
> common_interrupt
> generic_file_write
> cifs_write_wrapper
> do_sync_read
> vfs_write
> sys_write
> syscall_call
> 
> Also the call from a vi process that was called after the cp reached
> that state and was also blocked
> schedule_timeout
> ext3_mark_inode_dirty
> process_timeout
> io_schedule_timeout
> blk_congestion_wait
> autoremove_wake_function
> get_dirty_limits
> balance_dirty_pages
> generic_file_aio_write_nolock
> buffered_rmqueue
> __alloc_pages
> generic_file_aio_write
> ext2_file_write
> do_sync_write
> do_lookup
> path_release
> sys_access
> vfs_write
> sys_write
> syscall_call
> 
> If more detail is needed I can try to capture it but syslog not writing
> to disk I don't know how to capture the sysrq-t output

Hi, is the above information enough to try and find the problem or is
there a way that I can capture the full sysrq-t output?
-- 
Nuno Ferreira

