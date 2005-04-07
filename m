Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVDGDgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVDGDgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 23:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVDGDgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 23:36:25 -0400
Received: from [61.185.204.103] ([61.185.204.103]:3488 "EHLO
	dns.angelltech.com") by vger.kernel.org with ESMTP id S261239AbVDGDf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 23:35:59 -0400
Message-ID: <4254AB72.8070704@angelltech.com>
Date: Thu, 07 Apr 2005 11:39:30 +0800
From: rjy <rjy@angelltech.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: init process freezed after run_init_process
References: <424B7A87.2070100@angelltech.com> <Pine.LNX.4.61.0503311113550.17113@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503311113550.17113@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for kindly reply, :)

Jan Engelhardt wrote:
>>This is my grub config:
>>-----------------------------
>>root (hd0,0)
>>kernel /bzImage.via.386 root=/dev/ram0 rw ramdisk=49152
>>initrd /initrd.gz
>>-----------------------------
> 
> 
> Does it work if you add "  ramdisk=65536 init=/linuxrc " ?

No. I got the same problem without linuxrc.
As I mount ram0 as root, linuxrc is not necessary. Right?

> 
> 
>>returned OK: initrd decompressed properly and open_exec
>>returned non-zero.
> 
> 
> If you use k[g]db, you should be able to find out where the kernel actually 
> hangs.

After some digging, I found that the starting process of the VIA platform
and the intel platform is exactly the same:

1) checking if image is initramfs...it isn't (no cpio magic); looks like 
an initrd
    Freeing initrd memory: 9553k freed
2) loading drivers ...
3) RAMDISK: Compressed image found at block 0
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS on ram0, internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    VFS: Mounted root (ext3 filesystem).
    Freeing unused kernel memory: 128k freed

If I put the same hard disk into a intel platform without any change, it
can start properly, loading the same initrd as rootfs.

And also, if I remote the initrd config in VIA platform and mount my 
hard disk as rootfs, it also works properly.

I missed some driver for VIA platform?  Why it can work without initrd?
My initrd has an invalid format? Why it can work on intel platform?
I am really confused...

After the starting process, the /sbin/init is loaded: I found that in
a breakpoint of do_schedule. It keeps scheduling init and pdflush.
I am still finding the way to debug the init process...

> 
> 
> 
> Jan Engelhardt


