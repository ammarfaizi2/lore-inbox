Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264953AbSJ3UMP>; Wed, 30 Oct 2002 15:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSJ3UMP>; Wed, 30 Oct 2002 15:12:15 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:51204 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264949AbSJ3UMM>; Wed, 30 Oct 2002 15:12:12 -0500
Date: Wed, 30 Oct 2002 20:18:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steven Dake <sdake@mvista.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SCSI and FibreChannel Hotswap for linux 2.5.44-bk2
Message-ID: <20021030201834.A4815@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Dake <sdake@mvista.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <3DC02AF7.6020209@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC02AF7.6020209@mvista.com>; from sdake@mvista.com on Wed, Oct 30, 2002 at 11:54:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm, stop.

Scsi midlayer patches don't go directly to Linus, but through the linux-scsi
list and James into the linux-scsi bk repository first.

The patch still has a bunch of problem not solved, and contains two things
that should be independant patches.

The first patch should be the host_queue locking you added, this one currently
has the following issues:

* you call spin_lock on a semaphore once!
* you take semaphores inside spinlocks and with interrupts disabled
* the coding style needs some imnprovements (you adds lots of empty lines,
  and there's a space before the opening brakes of function calls).

the actual driver still has other issues:

* you still duplicated lots of code from scsi.c
* your header is still in include/linux instead of include/scsi,
  but imho it should be merged into scsi.h anyway
* you still havent explain why wwn -> host id translation can't
  be done in userspace
* you still have useage information in the driverfs files.

