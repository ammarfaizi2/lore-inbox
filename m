Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUJXLyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUJXLyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUJXLyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:54:13 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22477 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261451AbUJXLyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:54:08 -0400
Date: Sun, 24 Oct 2004 13:53:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: XFS strangeness, xfs_db out of memory
In-Reply-To: <200410240857.31893.robin.rosenberg.lists@dewire.com>
Message-ID: <Pine.LNX.4.53.0410241349270.23661@yvahk01.tjqt.qr>
References: <200410240857.31893.robin.rosenberg.lists@dewire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I was testing a tiny script on top of xfs_fsr to show fragmentation and the
>resultss of defragmentation.  As a result of fine tuning the output I ran the
>script repeatedly and suddenly got error from find (unknown error 999 if my
>memory serves me. It scrolled off the screen).
>
>The logs show this.
>Oct 24 08:06:50 xine kernel: hda: dma_timer_expiry: dma status == 0x21
>Oct 24 08:07:00 xine kernel: hda: DMA timeout error
>Oct 24 08:07:00 xine kernel: hda: dma timeout error: status=0xd0 { Busy }
>Oct 24 08:07:00 xine kernel:
>Oct 24 08:07:00 xine kernel: hda: DMA disabled
>Oct 24 08:07:00 xine kernel: ide0: reset: success

Hi,

That looks to me like your HD is going to die sometime in the future...

>How bad is that for XFS?... The error isn't permanent it seems.

Usually nothing. Expect <any fs> to struggle when such IO/DMA errors happen.

>After that xfs_db -r /dev-with-home -c "frag -v" gives me an out-of-memory
>error after a while, consistently.

XFS has probably picked up a malicious value due to the disk error, and as such
allocates that much. Probably more than you got.

>I ran the script repeatedly and suddenly got error from find (unknown error
>999 if my

If you reboot, and restart this repeated test, does it always error out at the
same time and spot (and with the same error 0x21/0x90), e.g. the 100'th
instance of xfs_db?

Please also try a badblocks -vv /dev/hdXY (or appropriate) repeatedly. If it
finds something there after a lot of runs (at least as much as you needed to
find out the fragmentation), there's definitely something wrong with the HD,
not XFS.




Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
