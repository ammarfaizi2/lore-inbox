Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUIJLEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUIJLEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 07:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUIJLEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 07:04:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:2736 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267361AbUIJLEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 07:04:40 -0400
Subject: Re: question on fs/read_write.c modification from 2.6.7 to 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: manjunathg.kondaiah@wipro.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <93AC2F9171509C4C9CFC01009A820FA00177D7D9@blr-ec-msg05.wipro.com>
References: <93AC2F9171509C4C9CFC01009A820FA00177D7D9@blr-ec-msg05.wipro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094810550.17094.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 11:02:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 11:45, manjunathg.kondaiah@wipro.com wrote:
> and In the implementation, the driver would be interested in checking
> the sanity of pointers by doing a check like if (ppos !=  &(file->fpos)
> { printk( KERN_ERR "Pointers not matching\n");return -EPERM;}

It now has nonseekable_open() to call.

> 1.  "so that the VFS layer is responsible for updating that offset
> rather than individual drivers." By not passing ppos as file->fops, the
> drivers should not try and do a (*ppos)++ anymore. Well the determined
> rogue driver can still do a file->fpos++ coz the file structure is still
> being exposed by the kernel to the driver (verified with printks). So
> this option does not sound logical!

This is the reason - plus better enforcement of pread/pwrite return
values. Any code touching file->f_pos in a driver is generally broken
anyway. It doesn't prevent such use but it makes the default behaviour
for a driver correct so makes it easier to write drivers correctly

