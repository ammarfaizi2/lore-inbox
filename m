Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUDRU0B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 16:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbUDRU0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 16:26:01 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:49719 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264174AbUDRUZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 16:25:59 -0400
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
Organization: adaptive planet
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm4 :  problems with sis 648 and AGPv3
Date: Sun, 18 Apr 2004 22:25:58 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404182225.58057.wim.delvaux@adaptiveplanet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I checked the archive and noticed that for some reason the sis 648 cards with 
a minor level < 5 do not do agpv3 well.  Using v2 the aperture size IS 
detected on v3 isn't

I wonder why because my cards SAYS it supports agp3 and my graphics cards says 
it too (about the cards and the agp -> according to xfree log)

So I checked source and added some printk statements to see what was going on.

In regular v2 level (using sis-... functions) the card returns in 
sis_get_driver a temp_size for 0x40.  This means that the code in the 
sis_get_driver that checks for apeture size the & ~0x03  comparison makes the 
test match. and selects the proper aperture of 64.

When 'forcing' the code to agp3 (because the bridge says it supports agp3) and 
hence using the generic_... functions from generic.c temp_size is 0xff09 and 
no entry in the aperture table matches.

So what might be wrong with the card/code/table or whatever to make a card 
that claims to be agv3 not being detected ?  Sure would like to find out and 
help finding out ...

W
