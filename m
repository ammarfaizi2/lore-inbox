Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWCDSbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWCDSbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 13:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWCDSbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 13:31:15 -0500
Received: from pv105234.reshsg.uci.edu ([128.195.105.234]:32981 "HELO
	pv105234.reshsg.uci.edu") by vger.kernel.org with SMTP
	id S1750860AbWCDSbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 13:31:15 -0500
Message-ID: <4409DCED.8010901@feise.com>
Date: Sat, 04 Mar 2006 10:31:09 -0800
From: Joe Feise <jfeise@feise.com>
Reply-To: jfeise@feise.com
Organization: feise.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Kernel oops: 2.6.16-rc5-mm2 (was: Re: Kernel oops: 2.6.16-rc3-mm1
 dvd mount)
References: <43F4A5FE.3080601@feise.com> <43F96743.9050103@gmail.com>
In-Reply-To: <43F96743.9050103@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote on 02/19/06 22:52:

> Joe Feise wrote:
>> [Note: please cc me on answers since I'm not subscribed to the kernel list]
>>
>> Trying to mount a DVD drive connected to an Adaptec 29160 SCSI controller
>> (through an IDE-to-SCSI bridge), I get a crash in the kernel.
>> The mount command:
>> $: mount /dev/sr1 /dvd
>> The log:
>> BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000c
>>  printing eip:
>> c0274f77
>> *pde = 00000000
>> Oops: 0000 [#1]
>> PREEMPT
>> last sysfs file: /class/net/eth2/ifindex
>> Modules linked in: pl2303 usbserial softdog snd_pcm_oss snd_mixer_oss snd_cs46xx
>> gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm
>> snd_timer snd soundcore snd_page_alloc zoran i2c_algo_bit videodev saa7
>> 111 i2c_core pegasus arc4 ppp_mppe ppp_deflate ppp_generic slhc usblp
>> CPU:    0
>> EIP:    0060:[<c0274f77>]    Not tainted VLI
>> EFLAGS: 00010096   (2.6.16-rc3-mm1 #2)
>> EIP is at elv_may_queue+0xc/0x2b
>> eax: 00000000   ebx: d8712000   ecx: 00000000   edx: 00000000
>> esi: 00000000   edi: 00000000   ebp: 00000010   esp: d8713ccc
>> ds: 007b   es: 007b   ss: 0068
>> Process mount (pid: 3328, threadinfo=d8712000 task=e2bfa560)
>> Stack: <0>d8712000 00000000 c027762b e2bfa560 c0111f3e 00000000 00000000 00000000
>>        00000082 d8712000 00000000 c17f1400 00000000 c02778d9 00000010 00000000
>>        e978c82a 00000000 d8713d98 00000000 e978c82a 00000000 c0277e11 00000001
>> Call Trace:
>>  <c027762b> get_request+0x27/0x2b8   <c0111f3e> default_wake_function+0x0/0xc
>>  <c02778d9> get_request_wait+0x1d/0x12b   <c0277e11> blk_execute_rq+0x96/0xcf
>>  <c0278000> blk_end_sync_rq+0x0/0x1d   <c02778d9> get_request_wait+0x1d/0x12b
>>  <c0136cd3> mempool_free+0x48/0x9b   <c0277a0f> blk_get_request+0x28/0x65
>>  <c03582ad> scsi_execute+0x2c/0xde   <c0136cd3> mempool_free+0x48/0x9b
>>  <c03a678e> sr_do_ioctl+0x82/0x22a   <c013d6c7> kzalloc+0x1b/0x50
>>  <c03a6466> sr_read_tochdr+0x6a/0x89   <c03ad52f> cdrom_count_tracks+0x66/0x171
>>  <c03acb91> open_for_data+0xb6/0x331   <c02827d0> kobject_get+0xf/0x13
>>  <c027abc6> get_disk+0x62/0xbd   <c03aca28> cdrom_open+0x41/0xf4
>>  <c02827d0> kobject_get+0xf/0x13   <c03a5b1d> sr_block_open+0x69/0x9d
>>  <c0157a39> do_open+0xd8/0x2f2   <c015755e> bdget+0xed/0xfc
>>  <c0157469> bdev_set+0x0/0x8   <c0157d16> blkdev_open+0x25/0x5c
>>  <c0157cf1> blkdev_open+0x0/0x5c   <c014f5a8> __dentry_open+0xd8/0x20a
>>  <c014f7e6> nameidata_to_filp+0x28/0x3b   <c014f725> do_filp_open+0x4b/0x4d
>>  <c0467e5b> do_page_fault+0x162/0x5b2   <c014fa02> do_sys_open+0x42/0xbb
>>  <c0102985> syscall_call+0x7/0xb
>> Code: 24 89 f0 ff 53 2c eb e6 53 89 c3 8b 40 0c 8b 00 8b 48 30 85 c9 75 02 5b c3
>> 89 d8 ff d1 eb f8 83 ec 08 89 7
>> 4 24 04 89 1c 24 89 c6 <8b> 40 0c 8b 00 8b 58 34 31 c0 85 db 75 0b 8b 1c 24 8b
>> 74 24 04
>>  <6>note: mount[3328] exited with preempt_count 1
>>
> 
> Hello, all.
> 
> This oops happened because get_request() was invoked with NULL @q.  It 
> seems like SCSI midlayer refcounting mixup.  I'll dig deeper and report 
> again as soon as I can find something concrete.
> 


Hello all,

while this problem was gone with 2.6.16-rc4-mm2, it has come back in -rc5-mm2:
BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c0277e07
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
last sysfs file: /class/net/eth2/ifindex
Modules linked in: pl2303 usbserial softdog snd_pcm_oss snd_mixer_oss snd_cs46xx
gameport snd_rawmidi snd_seq_device sn
d_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc zoran
i2c_algo_bit videodev saa7111 i2c_core p
egasus arc4 ppp_mppe ppp_deflate ppp_generic slhc usblp
CPU:    0
EIP:    0060:[<c0277e07>]    Not tainted VLI
EFLAGS: 00210096   (2.6.16-rc5-mm2 #7)
EIP is at elv_may_queue+0xc/0x2b
eax: 00000000   ebx: d6318000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000010   esp: d6319b18
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 3488, threadinfo=d6318000 task=d5e8eab0)
Stack: <0>d6318000 00000000 c027a4b0 d5e8eab0 c011202a 00000000 00000000 00000000
       00000082 d6318000 00000000 f7c1f400 00000000 c027a75e 00000010 00000000
       dcf39782 00000000 d6319be4 00000000 dcf39782 00000000 c027ac96 00000001
Call Trace:
 <c027a4b0> get_request+0x27/0x2b8   <c011202a> default_wake_function+0x0/0xc
 <c027a75e> get_request_wait+0x1d/0x12b   <c027ac96> blk_execute_rq+0x96/0xcf
 <c027ae85> blk_end_sync_rq+0x0/0x1d   <c027a75e> get_request_wait+0x1d/0x12b
 <c01379f7> mempool_free+0x48/0x9b   <c027a894> blk_get_request+0x28/0x65
 <c0357749> scsi_execute+0x2c/0xde   <c01379f7> mempool_free+0x48/0x9b
 <c03a42d6> sr_do_ioctl+0x82/0x22a   <c013e577> kzalloc+0x1b/0x50
 <c03a3fae> sr_read_tochdr+0x6a/0x89   <c03aaf5b> cdrom_count_tracks+0x66/0x171
 <c03aa5bd> open_for_data+0xb6/0x331   <c0285553> kobject_get+0xf/0x13
 <c027da4e> get_disk+0x62/0xbd   <c03aa454> cdrom_open+0x41/0xf4
 <c0285553> kobject_get+0xf/0x13   <c03a3665> sr_block_open+0x69/0x9d
 <c0159067> do_open+0xd8/0x2f2   <c01592fc> blkdev_get+0x7b/0x9e
 <c0159640> open_bdev_excl+0x40/0x87   <c0157fc1> get_sb_bdev+0x1c/0x129
 <c0138fcb> __alloc_pages+0x4a/0x29c   <c02286a1> isofs_get_sb+0x23/0x2e
 <c0227568> isofs_fill_super+0x0/0x698   <c015830b> do_kern_mount+0x8e/0x171
 <c016d2aa> do_new_mount+0x6f/0xbd   <c016d917> do_mount+0x1a9/0x1f1
 <c0138fcb> __alloc_pages+0x4a/0x29c   <c016d716> copy_mount_options+0x59/0xb1
 <c016dc43> sys_mount+0x7f/0xc1   <c0102997> syscall_call+0x7/0xb
Code: 24 89 f0 ff 53 2c eb e6 53 89 c3 8b 40 0c 8b 00 8b 48 30 85 c9 75 02 5b c3
89 d8 ff d1 eb f8 83 ec 08 89 74 24 04
 89 1c 24 89 c6 <8b> 40 0c 8b 00 8b 58 34 31 c0 85 db 75 0b 8b 1c 24 8b 74 24 04
 <6>note: mount[3488] exited with preempt_count 1
