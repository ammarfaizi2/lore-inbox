Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbUALLWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 06:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUALLWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 06:22:41 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:1098 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S266154AbUALLWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 06:22:40 -0500
Message-ID: <4002836A.8050908@samwel.tk>
Date: Mon, 12 Jan 2004 12:22:18 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org, Dax Kelson <dax@gurulabs.com>,
       Kiko Piris <kernel@pirispons.net>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
References: <3FFFD61C.7070706@samwel.tk> <200401121212.44902.lkml@kcore.org>
In-Reply-To: <200401121212.44902.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
> Patch applied, kernel built, laptop_mode activated, but my disk just doesn't 
> want to spin down... 
[...]
> But the disk never spins down. Not that I can tell, hdparm -C /dev/hda always 
> tells me active/idle, and the sdsl tool also reports 100% disk spinning...
> 
> anything else I have to activate/check?

Two things to try:

1. Check your HD with hdparm -I /dev/hdX, and see what it says at the 
"Standby timer values:" entry. Mine says:

Standby timer values: spec'd by Standard, with device specific minimum

In fact, when I set my HD to spin down in 20 seconds, it never spins 
down -- it's below the minimum. Try a higher value, or use my 
smart_spindown script instead (I posted this a while ago, with one of 
the laptop_mode patches).

2. Stop klogd, do "echo 1 > /proc/sys/vm/block_dump" and see which 
process keeps your disk spun up using dmesg.

Let me know if this helps.

-- Bart
