Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271592AbRHUIRB>; Tue, 21 Aug 2001 04:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271593AbRHUIQu>; Tue, 21 Aug 2001 04:16:50 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:23812 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S271592AbRHUIQk>;
	Tue, 21 Aug 2001 04:16:40 -0400
Message-Id: <200108210816.f7L8Gm605286@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: linux-kernel@vger.kernel.org
Subject: i810 audio doesn't work with 2.4.9
Date: Tue, 21 Aug 2001 11:16:48 +0300
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i810 audio didn't work for me with kernel 2.4.9 (artsd from KDE goes into infinite loop, no sound). 

Reverting to kernel 2.4.7 or replacing in 2.4.9 drivers/sound/ac97_codec.c, drivers/sound/i810_audio.c, 
include/linux/ac97_codec.h from 2.4.8-ac8 fixed the problem for me

Andris

small fragment of strace output from artsd (not modified 2.4.9):

09:22:28.328650 select(9, [4 6], [8], [6 8], {0, 119135}) = 1 (out [8], left {0, 120000})
09:22:28.328935 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff5ec) = 0
09:22:28.328984 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 608) = 96
09:22:28.329071 gettimeofday({998374948, 329087}, NULL) = 0
09:22:28.329116 gettimeofday({998374948, 329132}, NULL) = 0
09:22:28.329161 select(9, [4 6], [8], [6 8], {0, 118624}) = 1 (out [8], left {0, 120000})
09:22:28.329401 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff5ec) = 0
09:22:28.329450 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 592) = 80
09:22:28.329537 gettimeofday({998374948, 329553}, NULL) = 0
09:22:28.329582 gettimeofday({998374948, 329599}, NULL) = 0
09:22:28.329628 select(9, [4 6], [8], [6 8], {0, 118157}) = 1 (out [8], left {0, 120000})
09:22:28.329912 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff5ec) = 0
09:22:28.329964 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 608) = 96
09:22:28.330051 gettimeofday({998374948, 330067}, NULL) = 0
09:22:28.330096 gettimeofday({998374948, 330113}, NULL) = 0
