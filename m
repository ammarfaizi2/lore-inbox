Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVHQNcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVHQNcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 09:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVHQNcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 09:32:23 -0400
Received: from static-151-204-232-50.bos.east.verizon.net ([151.204.232.50]:24701
	"EHLO mail2.sicortex.com") by vger.kernel.org with ESMTP
	id S1751054AbVHQNcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 09:32:22 -0400
From: Joshua Wise <Joshua.Wise@sicortex.com>
Organization: SiCortex
To: linux-kernel@vger.kernel.org
Subject: NAPI poll routine happens in interrupt context?
Date: Wed, 17 Aug 2005 09:32:10 -0400
User-Agent: KMail/1.8.1
Cc: Aaron Brooks <aaron.brooks@sicortex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508170932.10441.Joshua.Wise@sicortex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML,

I have recently been working on a network driver for an emulated ultra-simple 
network card, and I've run into a few snags with the NAPI. My current issue 
is that it seems to me that my poll routine is being called from an atomic 
context, so when poll calls rx, and rx calls netif_receive_skb, I end up with 
lots of __might_sleep warnings in the various network layers.

This is not so good. I need every cycle I can get, as this emulator is 
incredibly slow, so burning cycles by printing out the reported badness is 
not really acceptible. Conceivably the badness itself is also an issue.

Before posting here, I did search Google for "lkml napi poll interrupt", 
although I did not find anything relevant to my issue.

If interested, the code is available at http://joshuawise.com/lanlan.c . Some 
notes:

The virtual lan-lan is a very very simple device. It consists of an ioreg that 
maintains state of the device, as described by the ioreg bit defines. It also 
has an ioctlreg that can pass through ioctls to the Linux kernel tap device 
that it's sitting on top of. (This goes with the ifreq seen in the struct.) 
One must always write and read in word-aligned chunks to and from it, for 
simplicity's sake.

Feel free to suggest any modifications that this device might need to make it 
more fully functional. Hopefully we can bring this driver to such a state 
where it will be usable as a replacement skeleton driver for the NAPI.

Please cc: Aaron and myself, as neither of us are subscribed to lkml.

Thanks in advance,
joshua
