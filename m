Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUFPN0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUFPN0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUFPN0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:26:15 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:26547 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263893AbUFPN0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:26:13 -0400
Date: Wed, 16 Jun 2004 14:25:41 +0100
From: Dave Jones <davej@redhat.com>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ov511 [2.6.7-rc3] does something odd
Message-ID: <20040616132541.GA438@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Ford <david+challenge-response@blue-labs.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <40CF8846.7020309@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CF8846.7020309@blue-labs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:37:42PM -0400, David Ford wrote:

 > RIP: 0010:[<ffffffff803a9906>] <ffffffff803a9906>{ov51x_v4l1_ioctl+38}
 >...
 > Call Trace:<ffffffff801ad8bd>{sys_ioctl+685} 
 > <ffffffff8011221a>{system_call+126}
 > 
 > Code: ff 8d a8 00 00 00 0f 88 8a 2c 00 00 31 c0 85 c0 41 b8 fc ff
 > RIP <ffffffff803a9906>{ov51x_v4l1_ioctl+38} RSP <000001003c4edf18>

Interesting. I broke it in what looks like the same way on x86
last week..

Unable to handle kernel paging request at virtual address 6b6b6bff
 printing eip:
6306ba4d
*pde = 00000000
Oops: 0002 [#1]
SMP
Modules linked in: ov511 videodev floppy uhci_hcd snd_pcm_oss loop snd_mixer_oss snd_emu10k1 snd_rawmidi snd_pcm snd_timer sndCPU:    3
EIP:    0060:[<6306ba4d>]    Not tainted
EFLAGS: 00010246   (2.6.6-1.381smp)
EIP is at ov51x_v4l1_ioctl+0x2c/0x75 [ov511]
eax: 00000000   ebx: 6b6b6bff   ecx: 6b6b6bff   edx: 00000091
esi: 6b6b6b6b   edi: 367490f4   ebp: 40047612   esp: 05612f78
ds: 007b   es: 007b   ss: 0068
Process xawtv (pid: 14706, threadinfo=05612000 task=1f2eb3c0)
Stack: 43c6030c 63073820 40047612 367490f4 ffffffe7 0216dc88 08ade2d0 43c6030c
       05612000 0212ab53 00000000 00000000 00000000 00000000 05612fc4 08ade038
       08ade2d0 05612000 fffeb200 00000004 40047612 08ade2d0 08ade038 08ade2d0
Call Trace:
 [<0216dc88>] sys_ioctl+0x23d/0x2a0
 [<0212ab53>] sys_alarm+0x30/0x4e
                                                                                                                              
Code: f0 ff 8e 94 00 00 00 0f 88 18 21 00 00 31 c0 85 c0 ba fc ff

I started to look into it, but video_usercopy() gave me the creeps.
OV511 could use a going over with sparse too. I'm not convinced about
its handling of userspace pointers in its ioctl.

		Dave

