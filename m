Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUEYVry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUEYVry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUEYVrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:47:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:16622 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265119AbUEYVp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:45:56 -0400
Date: Tue, 25 May 2004 14:48:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
Message-Id: <20040525144836.1af59a96.akpm@osdl.org>
In-Reply-To: <20040525184732.GB26661@suse.de>
References: <20040525184732.GB26661@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> Any ideas why the location of the device node makes such a big
> difference? I always wondered why my firewire is so dog slow with 2.6.
> Now I know the reason: /dev is in tmpfs.
> I dont see that with IDE disks, only with SCSI.

This is truly bizarre.  Reading /dev/sda I get 24MB/sec at 700 context
switches/sec.  Reading /mnt/tmpfs/sda it's 14MB/sec, 7000 switches/sec. 
/mnt/ramfs/sda is slow too. /mnt/hda5/sda is fast.


I'd assumed that the kernel got the backing_dev_info's screwed up and the
tmpfs node isn't doing readahead but that appears to not be the case
(/dev/sda is still fast with zero readahead).


You really, really get the weird-bug-of-the-month award for this one.  I'll
poke at it some more later on.
