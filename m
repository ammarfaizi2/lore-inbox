Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263785AbSJ3ERB>; Tue, 29 Oct 2002 23:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263958AbSJ3ERB>; Tue, 29 Oct 2002 23:17:01 -0500
Received: from 208-135-136-018.customer.apci.net ([208.135.136.18]:9479 "EHLO
	blessed") by vger.kernel.org with ESMTP id <S263785AbSJ3EQ7>;
	Tue, 29 Oct 2002 23:16:59 -0500
Date: Tue, 29 Oct 2002 22:23:15 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
X-X-Sender: jbm@blessed
To: tiwai@suse.de, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound/pci/via82xx.c "sleeping function called..."
Message-ID: <Pine.LNX.4.44.0210292218370.15699-200000@blessed>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1042570846-1035951795=:15699"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1042570846-1035951795=:15699
Content-Type: TEXT/PLAIN; charset=US-ASCII

Attached is a patch which seems to cure these, but no promises that it's
Correct (!):

(To: l-k so the Gurus can tell me i'm wrong more efficiently =)

Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c0114d41>] __might_sleep+0x55/0x64
 [<c012f44a>] kmalloc+0x56/0x1e4
 [<c4049098>] build_via_table+0x38/0x184 [snd-via82xx]
 [<c40490bb>] build_via_table+0x5b/0x184 [snd-via82xx]
 [<c01b8567>] __delay+0x13/0x28
 [<c404955a>] snd_via82xx_setup_periods+0x2e/0x128 [snd-via82xx]
 [<c4049864>] snd_via82xx_playback_prepare+0x80/0x8c [snd-via82xx]
 [<c4037e80>] snd_pcm_prepare+0xac/0x18c [snd-pcm]
 [<c40397e6>] snd_pcm_common_ioctl1+0x1d6/0x2a8 [snd-pcm]
 [<c4039c1e>] snd_pcm_playback_ioctl1+0x366/0x374 [snd-pcm]
 [<c4039fbf>] snd_pcm_kernel_playback_ioctl_R7d246e95+0x27/0x30 [snd-pcm]
 [<c403a01b>] snd_pcm_kernel_ioctl_Ra45ade40+0x23/0x40 [snd-pcm]
 [<c4052c81>] snd_pcm_oss_prepare+0x15/0x34 [snd-pcm-oss]
 [<c4052cd2>] snd_pcm_oss_make_ready+0x32/0x40 [snd-pcm-oss]
 [<c4053060>] snd_pcm_oss_write1+0x3c/0x148 [snd-pcm-oss]
 [<c4054f6a>] snd_pcm_oss_write+0x32/0x68 [snd-pcm-oss]
 [<c013d351>] vfs_write+0xc1/0x160
 [<c013d456>] sys_write+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

It's creepy to look over at the TV and see what looks like an Oops trace
but the music is still going... =)
--
/jbm, but you can call me Josh. Really, you can!
 "What's a metaphor?" "For sheep to graze in"
7958 1C1C 306A CDF8 4468  3EDE 1F93 F49D 5FA1 49C4


--8323328-1042570846-1035951795=:15699
Content-Type: TEXT/plain; name="via82xx_GFP_ATOMIC.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0210292223150.15699@blessed>
Content-Description: 
Content-Disposition: attachment; filename="via82xx_GFP_ATOMIC.diff"

LS0tIGxpbnV4LTIuNS40NC9zb3VuZC9wY2kvdmlhODJ4eC5jCTIwMDItMTAt
MTkgMDA6MDE6MTkuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi41LjQ0
LWpibS9zb3VuZC9wY2kvdmlhODJ4eC5jCTIwMDItMTAtMjkgMjM6MTI6MjYu
MDAwMDAwMDAwIC0wNTAwDQpAQCAtMjE3LDcgKzIxNyw3IEBADQogCQkJcmV0
dXJuIC1FTk9NRU07DQogCX0NCiAJaWYgKCEgZGV2LT5pZHhfdGFibGUpIHsN
Ci0JCWRldi0+aWR4X3RhYmxlID0ga21hbGxvYyhzaXplb2YoKmRldi0+aWR4
X3RhYmxlKSAqIFZJQV9UQUJMRV9TSVpFLCBHRlBfS0VSTkVMKTsNCisJCWRl
di0+aWR4X3RhYmxlID0ga21hbGxvYyhzaXplb2YoKmRldi0+aWR4X3RhYmxl
KSAqIFZJQV9UQUJMRV9TSVpFLCBHRlBfQVRPTUlDKTsNCiAJCWlmICghIGRl
di0+aWR4X3RhYmxlKQ0KIAkJCXJldHVybiAtRU5PTUVNOw0KIAl9DQo=
--8323328-1042570846-1035951795=:15699--
