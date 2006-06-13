Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWFMJOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWFMJOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 05:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWFMJOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 05:14:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:42425 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750813AbWFMJOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 05:14:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EDV8hQBwNjBOLpacSbsNWl3ctxZMfz9eueDf51+nPH8gDrpgNE2ZsSl9C+3bhiAZcJjXt2NIXNy5+KbQLLWyUsLY12IBCdDBcbahy1M2rrLgCDCGdvo+ZfdMU59fdZeKELzrpsM29pA6tihkGhRX7SX2x5KHg7pWoqoxEXoxxqY=
Message-ID: <9d2cd630606130214w393491bcxb7416cef8a3cbe48@mail.gmail.com>
Date: Tue, 13 Jun 2006 11:14:32 +0200
From: "Gregor Jasny" <gjasny@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.17-rc6] Oops in UDF
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while reading from a DVD-RW I've got the following oops:

UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'K3b data
project', timestamp 2006/06/13 10:11 (1078)
udf: udf_read_inode(ino 264) failed !bh
BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000011
 printing eip:
f93c86bb
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: udf radeon drm thermal fan button processor ac
battery nfs lockd nfs_acl sunrpc usbhid hw_random ide_cd snd_usb_audio
tuner snd_usb_lib snd_rawmidi snd_seq_device tvaudio snd_hwdep bttv
video_buf firmware_class ir_common compat_ioctl32 i2c_algo_bit
snd_hda_intel snd_hda_codec v4l2_common btcx_risc tveeprom i2c_core
piix snd_bt87x snd_pcm snd_timer snd soundcore snd_page_alloc uhci_hcd
videodev ide_core evdev ehci_hcd usbcore rtc pcspkr
CPU:    0
EIP:    0060:[<f93c86bb>]    Not tainted VLI
EFLAGS: 00210283   (2.6.17-rc6 #5)
EIP is at udf_get_fileshortad+0x30/0x44 [udf]
eax: 00000011   ebx: 00000011   ecx: e892dd08   edx: 000000c9
esi: e892dd08   edi: e8b06044   ebp: e892dcf0   esp: e892dc60
ds: 007b   es: 007b   ss: 0068
Process mc (pid: 2600, threadinfo=e892c000 task=e8bf9a10)
Stack: e892dc8c f93bd8ea 00000011 0810f0f9 e892dd08 00000001 e892dcf8 e892dd00
       e892dcf0 e8b0607c f93bda1f e8b0607c e892dcf8 e892dd08 e892dcf0 e892dd04
       e892dd00 00000001 ffffffff e8b061b4 e8b06044 e8bb6cdc f93c7b68 e8b0607c
Call Trace:
 <f93bd8ea> udf_current_aext+0xc1/0x151 [udf]  <f93bda1f>
udf_next_aext+0xa5/0xb8 [udf]
 <f93c7b68> udf_discard_prealloc+0x199/0x2d9 [udf]  <f93c1672>
udf_clear_inode+0x21/0x3e [udf]
 <c01636d8> clear_inode+0x8b/0xbb  <c0163923> generic_drop_inode+0x13a/0x150
 <c016327e> iput+0x49/0x79  <f93bf0ac> udf_iget+0x98/0xa2 [udf]
 <f93c3485> udf_lookup+0x7d/0xb4 [udf]  <c0159525> do_lookup+0xbe/0x15f
 <c015af16> __link_path_walk+0x821/0xcdf  <c0165c61> mntput_no_expire+0x1c/0x6b
 <c015b429> link_path_walk+0x55/0xd4  <c011d36a> current_fs_time+0x53/0x61
 <c016c01f> __mark_inode_dirty+0xe8/0x167  <c015b7da> do_path_lookup+0x1eb/0x207
 <c015a531> getname+0x68/0xa6  <c015c046> __user_walk_fd+0x30/0x4c
 <c01559c2> vfs_lstat_fd+0x1b/0x4f  <c011d36a> current_fs_time+0x53/0x61
 <c016c01f> __mark_inode_dirty+0xe8/0x167  <c0155a49> vfs_lstat+0x1f/0x23
 <c0155a65> sys_lstat64+0x18/0x2c  <c015d7d4> filldir64+0x0/0xd0
 <c015da6e> sys_getdents64+0xa6/0xb0  <c015d7d4> filldir64+0x0/0xd0
 <c01029f3> sysenter_past_esp+0x54/0x75
Code: 24 08 8b 4c 24 10 85 c0 74 04 85 c9 75 0e c7 04 24 a4 a7 3c f9
e8 c8 0f d5 c6 eb 1f 8b 11 85 d2 78 19 83 c2 08 3b 54 24 0c 77 10 <83>
38 00 74 0b 83 7c 24 14 00 74 06 89 11 eb 02 31 c0 5a c3 55
EIP: [<f93c86bb>] udf_get_fileshortad+0x30/0x44 [udf] SS:ESP 0068:e892dc60

The Kernel is a git snapshot fom 9th June.

Gregor
