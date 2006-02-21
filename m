Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161339AbWBUFHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWBUFHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWBUFHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:07:45 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:6878 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1161339AbWBUFHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:07:44 -0500
Date: Mon, 20 Feb 2006 22:07:40 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ext3 involved in kernel panic in 2.6.13?
Message-ID: <20060221050740.GB13382@schatzie.adilger.int>
Mail-Followup-To: Maurice Volaski <mvolaski@aecom.yu.edu>,
	ext3-users@redhat.com, linux-kernel@vger.kernel.org
References: <a06230908c01e6d2b77b3@[129.98.90.227]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06230908c01e6d2b77b3@[129.98.90.227]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 19, 2006  14:09 -0500, Maurice Volaski wrote:
> A panic occurred, which contains references to ext3 code.
> 
> I'm not sure how others manage to get these typed out,

Normally a serial console is best, and if you have at least 2 machines
you can cross-connect the serial ports with a NULL-modem cable and run
a terminal emulator (e.g. minicom) to log it to disk on the other system.
Having netdump is also a good choice, though maybe not quite as reliable
as a real serial console.

> but I'm manually typing it from what's on the monitor:
> 
> Call Trace: <IRQ> <ffffffff802820df>{i8042_interrupt+111} 
> <ffffffff80200080>{commit_timeout+0}
> <ffffffff8013f143>{run_timer_softirq+387} 
> <ffffffff8013b111>{__do_softirq+113}
> <ffffffff8010ee63>{call_softirq+31} <ffffffff80110a55>{do_softirq+53}
> <ffffffff8010e5c8>{apic_timer_interrupt+132} <EOI> 

At this point (and above) the process is in an IRQ handler, so it is likely
that the problem exists somewhere at that level.  However, the critical
part of the oops is missing - what actually went wrong?  It could be a BUG,
which is a kernel assertion, or it could be a bad pointer dereference, or
anything really.  There is nothing here which indicates what the problem is.

> <ffffffff801fb8a6>{do_get_write_access+118}
> <ffffffff801fb88e>{do_get_write_access+94} <ffffffff80185d1f>{__getblk+47}
> <ffffffff80195170>{filldir+0} 
> <ffffffff801fbf69>{journal_get_write_access+41}
> <ffffffff801ec41c>{ext3_reserve_inode+write+76} 
> <ffffffff80195170>{filldir+0}
> <ffffffff801ec4d8>{ext3_mark_inode_dirty+56} 
> <ffffffff801fa9e5>{journal_start_229}
> <ffffffff801ee571>{ext3_dirty_inode+113} 
> <ffffffff801a5604>{__mark_inode_dirty+52}
> <ffffffff8019bd2b>{update_atime+123} <ffffffff80195016>{vfs_readdir+166}
> <ffffffff801952e2>{syst_getdents+130} <ffffffff8019465e>{sys_fcntl+830}
> <ffffffff8010dc46>{system_call+126}

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

