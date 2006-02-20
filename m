Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWBTGwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWBTGwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 01:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWBTGwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 01:52:55 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:16476 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932670AbWBTGwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 01:52:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iy3eHUvOulJeuukzCd5W7L45KPtrI1tuG90cwlbrWzgrkwNDfWLAIQ5u/OM7YnCrrfg6CyWilY4gC7OOXWaPl780u9i546IpaaHKUtSPQksjjwhN7k1MdpkN6wxcpsGmkGr1JCYzNnbp7PzqEKzHEI3X+FURWcVo0iD6XMPMdVo=
Message-ID: <43F96743.9050103@gmail.com>
Date: Mon, 20 Feb 2006 15:52:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jfeise@feise.com
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Kernel oops: 2.6.16-rc3-mm1 dvd mount
References: <43F4A5FE.3080601@feise.com>
In-Reply-To: <43F4A5FE.3080601@feise.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Feise wrote:
> [Note: please cc me on answers since I'm not subscribed to the kernel list]
> 
> Trying to mount a DVD drive connected to an Adaptec 29160 SCSI controller
> (through an IDE-to-SCSI bridge), I get a crash in the kernel.
> The mount command:
> $: mount /dev/sr1 /dvd
> The log:
> BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000c
>  printing eip:
> c0274f77
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> last sysfs file: /class/net/eth2/ifindex
> Modules linked in: pl2303 usbserial softdog snd_pcm_oss snd_mixer_oss snd_cs46xx
> gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm
> snd_timer snd soundcore snd_page_alloc zoran i2c_algo_bit videodev saa7
> 111 i2c_core pegasus arc4 ppp_mppe ppp_deflate ppp_generic slhc usblp
> CPU:    0
> EIP:    0060:[<c0274f77>]    Not tainted VLI
> EFLAGS: 00010096   (2.6.16-rc3-mm1 #2)
> EIP is at elv_may_queue+0xc/0x2b
> eax: 00000000   ebx: d8712000   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: 00000000   ebp: 00000010   esp: d8713ccc
> ds: 007b   es: 007b   ss: 0068
> Process mount (pid: 3328, threadinfo=d8712000 task=e2bfa560)
> Stack: <0>d8712000 00000000 c027762b e2bfa560 c0111f3e 00000000 00000000 00000000
>        00000082 d8712000 00000000 c17f1400 00000000 c02778d9 00000010 00000000
>        e978c82a 00000000 d8713d98 00000000 e978c82a 00000000 c0277e11 00000001
> Call Trace:
>  <c027762b> get_request+0x27/0x2b8   <c0111f3e> default_wake_function+0x0/0xc
>  <c02778d9> get_request_wait+0x1d/0x12b   <c0277e11> blk_execute_rq+0x96/0xcf
>  <c0278000> blk_end_sync_rq+0x0/0x1d   <c02778d9> get_request_wait+0x1d/0x12b
>  <c0136cd3> mempool_free+0x48/0x9b   <c0277a0f> blk_get_request+0x28/0x65
>  <c03582ad> scsi_execute+0x2c/0xde   <c0136cd3> mempool_free+0x48/0x9b
>  <c03a678e> sr_do_ioctl+0x82/0x22a   <c013d6c7> kzalloc+0x1b/0x50
>  <c03a6466> sr_read_tochdr+0x6a/0x89   <c03ad52f> cdrom_count_tracks+0x66/0x171
>  <c03acb91> open_for_data+0xb6/0x331   <c02827d0> kobject_get+0xf/0x13
>  <c027abc6> get_disk+0x62/0xbd   <c03aca28> cdrom_open+0x41/0xf4
>  <c02827d0> kobject_get+0xf/0x13   <c03a5b1d> sr_block_open+0x69/0x9d
>  <c0157a39> do_open+0xd8/0x2f2   <c015755e> bdget+0xed/0xfc
>  <c0157469> bdev_set+0x0/0x8   <c0157d16> blkdev_open+0x25/0x5c
>  <c0157cf1> blkdev_open+0x0/0x5c   <c014f5a8> __dentry_open+0xd8/0x20a
>  <c014f7e6> nameidata_to_filp+0x28/0x3b   <c014f725> do_filp_open+0x4b/0x4d
>  <c0467e5b> do_page_fault+0x162/0x5b2   <c014fa02> do_sys_open+0x42/0xbb
>  <c0102985> syscall_call+0x7/0xb
> Code: 24 89 f0 ff 53 2c eb e6 53 89 c3 8b 40 0c 8b 00 8b 48 30 85 c9 75 02 5b c3
> 89 d8 ff d1 eb f8 83 ec 08 89 7
> 4 24 04 89 1c 24 89 c6 <8b> 40 0c 8b 00 8b 58 34 31 c0 85 db 75 0b 8b 1c 24 8b
> 74 24 04
>  <6>note: mount[3328] exited with preempt_count 1
> 

Hello, all.

This oops happened because get_request() was invoked with NULL @q.  It 
seems like SCSI midlayer refcounting mixup.  I'll dig deeper and report 
again as soon as I can find something concrete.

-- 
tejun
