Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUDJBvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 21:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUDJBvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 21:51:17 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:51717 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261786AbUDJBvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 21:51:15 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Ivica Ico Bukvic <ico@fuse.net>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- First good news
Date: Sat, 10 Apr 2004 03:47:56 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404100347.56786.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you can get the same output with
	hexdump -v /proc/bus/pci/BUS/DEVICE
where BUS/DEVICE is the CB controller. eg. 00/09.0

about the bits:
- at 81h, from D0 to 90: this is part of the system control register. the bit
  that changed is "Memory read burst enable upstream"
- at c9h, from 04 to 06: this is an undocumented test register. TI just says
  reserved, EnE says test register, for the bit that changed it adds the 
  comment TLTEnable (default to 1). no idea what it is. it _could_ have
  something to do with the cardbus latency timer...you can try to play a bit
  with the latency setting after resume when this bit is set. try writing to
  offset 1Bh, put in at least 40h

to change the bits under linux, use setpci (also good for reading)

about the memory read burst upstream: 2.6 kernels enable it for most of
the TI chips and since 2.6.5 also for some TI clones from EnE (incl. EnE1410).

rgds
-daniel

