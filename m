Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbTFLWih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTFLWig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:38:36 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:48894 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265029AbTFLWif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:38:35 -0400
Date: Thu, 12 Jun 2003 15:48:24 -0700
From: Andrew Morton <akpm@digeo.com>
To: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changes made by fdisk not being written to disk (2.5-bk)
Message-Id: <20030612154824.5af9bfde.akpm@digeo.com>
In-Reply-To: <20030612224153.GY4639@duckman.distro.conectiva>
References: <20030612224153.GY4639@duckman.distro.conectiva>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 22:52:21.0651 (UTC) FILETIME=[48899630:01C33135]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduardo Pereira Habkost <ehabkost@conectiva.com.br> wrote:
>
> Today I changed the partition table of the disk, using fdisk, and
> noticed, after reboot, that the new partition table was not written to
> the disk. Before rebooting, 'fdisk -l /dev/hda' shows the new partition
> table, as if it were written.
> 
> I've made a few more tests, and even if I sync() a dozen of times
> before rebooting (using /bin/sync and sysrq), the data is not written.
> Even when I've waited about 20 minutes after changing the partition table,
> before rebooting, the problem persisted.
> 
> Although, after changing fdisk to call fsync() before closing the device,
> everything worked, the changes were written, and the new partition table
> were on the disk, after rebooting.

argh, is this a plot?

It is some interaction between sync() and the presence of dirty data against
the ramdisk driver.  You can work around it by not using the ramdisk driver,
by using `blockdev --flushbufs /dev/hdXX' or by using fsync, as you have
done.

