Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSE3AKG>; Wed, 29 May 2002 20:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSE3AKF>; Wed, 29 May 2002 20:10:05 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37321 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315758AbSE3AKE>;
	Wed, 29 May 2002 20:10:04 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 30 May 2002 02:09:53 +0200 (MEST)
Message-Id: <UTC200205300009.g4U09ri18210.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, mathieu@newview.com
Subject: Re: 2.4.19-pre9, IDE on Sparc, Big Disks
Cc: andre@linux-ide.org, dalecki@evision-ventures.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I just pulled a copy of Marcello's tree from bk and compiled it on my sparc
    (that's a sun ultra 5). Everything went well but the IDE.
    I have a large ide disk connected to this guy (around 120GB if memory
    serves) and it used to work properly in the 2.4.17 era.
    Now when I boot, I got this:

    hdc: -612473816857182208 sectors

Well, clearly your bug is here.
This number is F7800E4F00000000 hex.
On the other hand, your disk has 240121728 sectors, which is 0E4FF780 hex.

So, someone assumed somewhere that the world is little-endian
with long the same size as int.

Precisely what happened is easiest to trace with the identify data in hand.
For example, maybe the sparc code still has to be extended to fix the
order of lba_capacity48 or so (in ide_fix_driveid).

Andries


[So, if you cannot find the culprit yourself, please give the identify data.
On some old kernel, the real, clean, identify data, as read directly from
the disk; not the stuff modified by the kernel. Maybe "cat /proc/ide/hdc/identify"
or so works.]

BTW, this fixing in-place of the driveid is a very bad idea.
Nobody should ever touch driveid. It is a read-only variable.
