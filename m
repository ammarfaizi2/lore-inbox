Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVA1TJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVA1TJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVA1TEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:04:39 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:3777 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261515AbVA1TA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:00:57 -0500
Date: Fri, 28 Jan 2005 20:00:52 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Message-ID: <20050128190052.GA4885@suse.de>
References: <20050128132202.GA27323@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050128132202.GA27323@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jan 28, Olaf Hering wrote:

> 
> My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():
> 
> Calling initcall 0xc03c272c: atkbd_init+0x0/0x38()
> ps2_init(224) swapper(1):c0,j4294680939 enter
> atkbd_connect(793) swapper(1):c0,j4294680993 type 1000000
> serio_open(606) swapper(1):c0,j4294681061 enter
> serio_set_drv(594) swapper(1):c0,j4294681117 enter
> serio_set_drv(600) swapper(1):c0,j4294681176 leave
> i8042_write_command(69) swapper(1):c0,j4294681236 enter
> i8042_write_data(62) swapper(1):c0,j4294681236 enter
> serio_open(614) swapper(1):c0,j4294681363 leave0
> atkbd_probe(497) swapper(1):c0,j4294681421 enter
> ps2_command(91) swapper(1):c0,j4294681478 enter
> ps2_sendbyte(57) swapper(1):c0,j4294681534 enter
> serio_write(95) swapper(1):c0,j4294681591 write c01b65ac
> i8042_aux_write(253) swapper(1):c0,j4294681658 enter
> i8042_write_command(69) swapper(1):c0,j4294681720 enter
> i8042_write_data(62) swapper(1):c0,j4294681720 enter

If I remove this patch from 2.6.10-bk12, it works again. 
No drivers were changed, I see lots of "mm" which is scary.
Any takers?

http://penguinppc.org/~olaf/bk12.diff.gz
.config contains just enough to get to the atkbd_init() function.

