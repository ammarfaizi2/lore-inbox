Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTKQPsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 10:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTKQPsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 10:48:13 -0500
Received: from [68.14.236.254] ([68.14.236.254]:36574 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263580AbTKQPsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 10:48:06 -0500
Message-ID: <3FB8ED91.3050305@backtobasicsmgmt.com>
Date: Mon, 17 Nov 2003 08:47:29 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Andrey Borzenkov <arvidjaar@mail.ru>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB8EBC2.1080800@nortelnetworks.com>
In-Reply-To: <3FB8EBC2.1080800@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Absolutely, the memory should be reclaimed.  I would have thought that 
> you could just unmount it--if the pivot_root is done properly there 
> shouldn't be any references left to the initramfs.

There is no pivot_root happening here; the kernel creates a ramfs and 
mounts it on / (as rootfs), then unpacks the initramfs cpio archive into 
it. After doing a few more steps, it overmounts the real root onto /, 
making the rootfs filesystem invisible. It is not freed in the current 
kernels.

I suspect that if you wanted to modify init/do_mounts.c, you could use 
the initrd technique of doing the pivot_root yourself (instead of 
letting the kernel automount the "real" root filesystem), at which point 
it maybe be possible to umount and free the rootfs.

