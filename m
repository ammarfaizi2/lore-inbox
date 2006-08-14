Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751969AbWHNJhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWHNJhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWHNJhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:37:34 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:61671
	"EHLO schlidder.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S1751969AbWHNJhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:37:33 -0400
Date: Mon, 14 Aug 2006 11:37:18 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: v4l-dvb-maintainer@linuxtv.org, linux-dvb@linuxtv.org
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VBI OOPS 2.6.17.8
Message-ID: <20060814093718.GA11078@titan.lahn.de>
Mail-Followup-To: v4l-dvb-maintainer@linuxtv.org,
	linux-dvb@linuxtv.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux-DVB, lkml!

Starting "kdetv" by accident on my Siemens DVB-C 1.x produced the
following OOPS, because kdetv did open "/dev/vbi0". The OOPS is
100% reproduceable.


Creating vbi proxy client, rev.
$Id: proxy-client.c,v 1.12 2006/05/31 03:54:28 mschimek Exp $
proxy_msg: connect: error 2, No such file or directory
kdetv: WARNING: VBIDecoder: vbi_capture_proxy_new error: Connection via socket failed, server not running.
Try to open V4L2 0.20 VBI device, libzvbi interface rev.
  $Id: io-v4l2.c,v 1.33 2006/05/22 09:00:47 mschimek Exp $
Opened /dev/vbi0
libzvbi:capture_v4l2k_new: Try to open V4L2 2.6 VBI device, libzvbi interface rev.
  $Id: io-v4l2k.c,v 1.41 2006/05/31 03:54:00 mschimek Exp $.
libzvbi:capture_v4l2k_new: Opened /dev/vbi0.
libzvbi:capture_v4l2k_new: /dev/vbi0 (dvb) is a v4l2 vbi device,
driver saa7146 v4l2, version 0x00000500.
libzvbi:capture_v4l2k_new: Using streaming interface.
libzvbi:v4l2_get_videostd: Current scanning system is 625.
libzvbi:v4l2_update_services: Querying current vbi parameters...
libzvbi:v4l2_update_services: ...success.
libzvbi:print_vfmt: VBI capture parameters supported: format 59455247 [GREY], 27000000 Hz, 1440 bpl, offs 248, F1 5...20, F2 312...327, flags 00000000.
libzvbi:print_vfmt: VBI capture parameters granted: format 59455247 [GREY], 27000000 Hz, 1440 bpl, offs 248, F1 5...20, F2 312...327, flags 00000000.
libzvbi:vbi3_raw_decoder_add_services: No services to add.
libzvbi:v4l2_update_services: Nyquist check passed.
libzvbi:v4l2_update_services: Request decoding of services 0x60000c7f, strict level -1.
libzvbi:_vbi_sampling_par_permit_service: Sampling ends too early at 0H + 62.518519 us for service 0x00000001 (Teletext System B 625 Level 1.5) which ends at 62.691892 us
libzvbi:_vbi_sampling_par_permit_service: Sampling ends too early at 0H + 62.518519 us for service 0x00000003 (Teletext System B, 625) which ends at 62.691892 us
libzvbi:_vbi_sampling_par_permit_service: Sampling ends too early at 0H + 62.518519 us for service 0x00000001 (Teletext System B 625 Level 1.5) which ends at 62.691892 us
libzvbi:_vbi_sampling_par_permit_service: Sampling ends too early at 0H + 62.518519 us for service 0x00000003 (Teletext System B, 625) which ends at 62.691892 us
libzvbi:_vbi_sampling_par_permit_service: Service 0x00000020 (Closed Caption 525, field 1) requires videostd_set 0x2, have 0x0.
libzvbi:_vbi_sampling_par_permit_service: Service 0x00000040 (Closed Caption 525, field 2) requires videostd_set 0x2, have 0x0.
libzvbi:v4l2_update_services: Will capture services 0x0000041c, added 0x41c commit=1.
libzvbi:v4l2_stream_alloc: Requesting 16 streaming i/o buffers.
libzvbi:v4l2_stream_alloc: Mapping 2 streaming i/o buffers.
libzvbi:capture_v4l2k_new: Successfully opened /dev/vbi0 (dvb).

------------[ cut here ]------------
kernel BUG at drivers/media/common/saa7146_video.c:741!
invalid opcode: 0000 [#1]
PREEMPT SMP
CPU:    1
EIP is at video_begin+0x136/0x1e7 [saa7146_vv]
eax: 00000000   ebx: d408027c   ecx: 00000000   edx: e090a164
esi: dfeec480   edi: d4080000   ebp: d6070e54   esp: d6070e44
ds: 007b   es: 007b   ss: 0068
Process kdetv (pid: 6392, threadinfo=d6070000 task=c14bbab0)
Stack: df4ac280 d408027c 40045612 d4080000 d6070e88 e0904621 c14dc5a0 df7746c8
df4ac280 dfeec480 d408027c d6070eac 081fd628 d6070e8c 40045612 00000004
00000001 d6070f38 e08c635d d6070eac c14dc5a0 df7746c8 00000001 00000000
Call Trace:
<c010397e> show_stack_log_lvl+0x85/0x8f
<c0103b12> show_registers+0x152/0x1c6
<c0103cfe> die+0x178/0x28b
<c0103e8d> do_trap+0x7c/0x96
<c0104628> do_invalid_op+0x89/0x93
<c0103427> error_code+0x4f/0x54
<e0904621> saa7146_video_do_ioctl+0x102a/0x1245 [saa7146_vv]
<e08c635d> video_usercopy+0x139/0x1c6 [videodev]
<e09014e4> fops_ioctl+0x10/0x12 [saa7146_vv]
<c016092a> do_ioctl+0x4e/0x67
<c0160b9b> vfs_ioctl+0x258/0x26b
<c0160bf5> sys_ioctl+0x47/0x62
<c01028bf> sysenter_past_esp+0x54/0x75
Code: 74 90 e0 68 bd 74 90 e0 e8 1a 57 81 df 68 af 78 90 e0 e8 10 57 81 df eb 89 8b 97 64 02 00 00 8b 45 f0 e8 90 ef ff ff 85 c0 75 08 <0f> 0b e5 02 18 78 90 e0 0f b6 40 0d 83 e0 02 83 f8 01 89 f8 19 
EIP: [<e0903419>] video_begin+0x136/0x1e7 [saa7146_vv] SS:ESP 0068:d6070e44

kdetv: WARNING: V4L2Dev: VIDIOC_S_FMT failed: Invalid argument
kdetv: WARNING: V4L2Dev::setInputProperties(): failed

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
