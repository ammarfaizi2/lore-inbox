Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbTL1Dln (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTL1Dln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:41:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:54149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264963AbTL1Dll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:41:41 -0500
Date: Sat, 27 Dec 2003 19:41:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Calin Szonyi <caszonyi@rdslink.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management problem with 2.6.0
Message-Id: <20031227194144.54d052d1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0312271912350.511@grinch.ro>
References: <Pine.LNX.4.53.0312271912350.511@grinch.ro>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

caszonyi@rdslink.ro wrote:
>
> I have a small script:
>  #!/bin/sh
>  umount /mnt/cdrom
>  eject /dev/hdb
>  echo "Invalid system disk"
>  echo "Insert and press any key when ready"
>  read junk
>  eject -t /dev/hdb
>  sleep 1
>  mount /mnt/cdrom
>  /usr/sbin/hdparm -E 10 /dev/hdb
> 
>  It works all the time but today gave me this:
> 
>  sony@grinch -19:06:39- 0 jobs, ver 2.05b.0 1
>  /~ $ cdin
>  umount: /mnt/cdrom is not mounted (according to mtab)
>  eject: unable to find or open device for: `/dev/hdb'
>  Invalid system disk
>  Insert and press any key when ready
> 
>  eject: unable to find or open device for: `/dev/hdb'
>  mount: Cannot allocate memory
>  /dev/hdb: Cannot allocate memory
> 
>  The permissions on the device are
> 
>  sony@grinch -19:07:54- 0 jobs, ver 2.05b.0 1
>    /~ $ ls -l /dev/hdb
>    brw-rw----    1 root     disk       3,  64 iun  9  2002 /dev/hdb
> 
>  In the logs I had:
>  Dec 27 19:06:16 grinch kernel: eject: page allocation failure. order:4,
>  mode:0xd0

Please, try

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/cdrom-allocation-try-harder.patch

and let me know?
