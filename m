Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319044AbSH2BeF>; Wed, 28 Aug 2002 21:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319052AbSH2BeF>; Wed, 28 Aug 2002 21:34:05 -0400
Received: from sun0.mpimf-heidelberg.mpg.de ([149.217.50.120]:49656 "EHLO
	sun0.mpimf-heidelberg.mpg.de") by vger.kernel.org with ESMTP
	id <S319044AbSH2BeE>; Wed, 28 Aug 2002 21:34:04 -0400
Subject: [PATCH 2.4.20-pre4-ac2] fix broken i810_audio DMA (?)
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jim Radford <radford@robotics.caltech.edu>,
       Andris Pavenis <pavenis@latnet.lv>, Doug Ledford <dledford@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 03:39:28 +0200
Message-Id: <1030585168.2548.18.camel@volans>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
-remove dma reset in stop_{dac,adc}
 (from ICH4 manual: contents of all Bus master related registers to be
  reset; so, probably some registers are not re-initilized properly on
  consecutive re-opening of /dev/dsp ???)
-remove writes to OFF_CIV, instead set LVI relative to CIV

and some stuff that was already in the last diff I send to the list:
-implement a codec ID <-> IO register offset mapping
-in i810_ioctl, case SNDCTL_DSP_CHANNELS: only touch bits 20:21
 off GLOB_CNT (multichannel capabilities)
-AMD 8111 has 6 hw channels so I must have mmio (but I don't have
 any docs to verify this)
-minor fixes

-- 
Juergen "George" Sawinski
Max-Planck Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-308
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 858
Mobile: +49-171-532 5302


