Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVBJAIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVBJAIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVBJAIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:08:40 -0500
Received: from naig.caltech.edu ([131.215.49.17]:18145 "EHLO naig.caltech.edu")
	by vger.kernel.org with ESMTP id S261979AbVBJAIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:08:34 -0500
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: not-for-mail
From: Jan Lindheim <lindheim@cacr.caltech.edu>
Newsgroups: mlist.linux.kernel
Subject: Re: 3TB disk hassles
Date: Wed, 09 Feb 2005 16:06:04 -0800
Organization: Caltech
Message-ID: <pan.2005.02.10.00.05.59.752221@cacr.caltech.edu>
References: <linux.kernel.20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
NNTP-Posting-Host: opal.cacr.caltech.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: naig.caltech.edu 1107994112 1465 131.215.146.3 (10 Feb 2005 00:08:32 GMT)
X-Complaints-To: abuse@caltech.edu
NNTP-Posting-Date: Thu, 10 Feb 2005 00:08:32 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004 14:52:29 +0000, Neil Conway wrote:

> Howdy...
> 
> After much banging of heads on walls, I am throwing in the towel and
> asking the experts ;-) ... To cut a long story short:
> 
> Is it possible to make a 3TB disk work properly in Linux?
> 
> Our "disk" is 12x300GB in RAID5 (with 1 hot-spare) on a 3ware 9500-S12,
> so it's actually 2.7TiB ish.  It's also /dev/sda - i.e., the one and
> only disk in the system.
> 
> Problems are arising due to the 32-bit-ness of normal partition tables.
>  I can use parted to make a 2.7TB partition (sda4), and
> /proc/partitions looks fine until a reboot, whereupon the top bits are
> lost and the big partition looks like a 700GB partition instead of a
> 2.7TB one; this is a bad thing ;-)
> 
> I've had my hopes raised by GPT, but after more reading it appears this
> doesn't work on vanilla x86 PCs.
> 
> Tips gratefully received.
> 
> Neil
> 
> PS: not on-list; I'll be reading the real-time archivers, but CCs of
> any replies would be appreciated.
> 
> 
> 	
> 	
> 		
> ___________________________________________________________ 
> ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Neil,
I just set up a new file server a couple of weeks ago, which
holds two RAIDs, making up 4.1 TB each.  I'm not aware of any
distributions that will do the partitioning for you.  I was
able to get the system configured by booting Knoppix and using
parted for the partitioning.  Fedora refused to install on this
system after checking the GPT partition table.  The latest
Mandrake Linux warned me about the partitions, but at least
it accepted going on with the install anyway. lilo is used as
the bootloader and has no problem existing on the MBR of the RAID.
My system is a dual 3.2 GHz Xeon system with 8GB RAM, two
3Ware 9500S RAID controllers, 12 400GB disks pr. RAID controller.
Here's a df from the system:

[root@asaphome ~]# df
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda1             7.9G  1.1G  6.8G  14% /
/dev/sda3              14G  3.4G   11G  25% /usr
/dev/sda4             4.0T  232G  3.8T   6% /home
/dev/sdb1             4.1T   24G  4.0T   1% /archive

Good Luck!

Regards Jan Lindheim
