Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265961AbUFDT4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUFDT4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUFDT4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:56:12 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:3803 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265961AbUFDTzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:55:44 -0400
Date: Fri, 4 Jun 2004 13:58:09 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: mattia <mattia@nixlab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
Message-ID: <20040604195809.GB15249@bounceswoosh.org>
Mail-Followup-To: mattia <mattia@nixlab.net>, linux-kernel@vger.kernel.org
References: <E1BWBjw-0003QZ-1h@andromeda.hostvector.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <E1BWBjw-0003QZ-1h@andromeda.hostvector.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: status=0x51 {
>DriveReady SeekComplete Error }
>Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: error=0x04 {
>DriveStatusError }
>Jun  4 08:05:43 blink kernel: hdd: Write Cache FAILED Flushing!

That is a known issue in older driver versions that should be resolved
now.  It only affects our latest generation of drives that are <=
120GB, it will not affect the larger drives (>= 160GB), and it won't
affect any drives of the next product generation because I fixed the
root cause in the drive as well as helping identify a driver
workaround/fix.

error=0x04 is an "abort" and not a critical error

The original note had error=0x40, which is an Uncorrectable ECC
error... that is bad, and you should probably RMA the drive.

You can also try to see if you can "fix" it by writing to that LBA
(obviously backup your data first) and see if the error goes
away... if that is the case, the ECC could have been due to a write
splice at power failure or some other transient event (extreme shock
or heat or something)

If there are a lot of ECC errors (you have them in about 2 places)
which could be a sign of bad things in progress, just RMA the drive.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

