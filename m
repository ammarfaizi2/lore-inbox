Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUALMT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUALMT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:19:59 -0500
Received: from 31.Red-80-59-88.pooles.rima-tde.net ([80.59.88.31]:30415 "EHLO
	jabato.portsdebalears.com") by vger.kernel.org with ESMTP
	id S266156AbUALMT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:19:58 -0500
Date: Mon, 12 Jan 2004 13:19:56 +0100
From: Kiko Piris <kernel@pirispons.net>
To: Jan De Luyck <lkml@kcore.org>
Cc: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org,
       Dax Kelson <dax@gurulabs.com>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Message-ID: <20040112121956.GA8226@portsdebalears.com>
Mail-Followup-To: Jan De Luyck <lkml@kcore.org>,
	Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org,
	Dax Kelson <dax@gurulabs.com>, Bartek Kania <mrbk@gnarf.org>,
	Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk> <200401121212.44902.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401121212.44902.lkml@kcore.org>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2004 at 12:12, Jan De Luyck wrote:

> Patch applied, kernel built, laptop_mode activated, but my disk just doesn't 
> want to spin down... 
[...]
> But the disk never spins down. Not that I can tell, hdparm -C /dev/hda always 
> tells me active/idle, and the sdsl tool also reports 100% disk spinning...
> 
> anything else I have to activate/check?

As you don't say if you have checked it, here goes my suggestion:

First of all, you should assure there's no process doing reads [*] that
cause a cache miss (eg. daemons like postfix that check the queue every
few seconds). You can tell this running vmstat 1 and see that bi and bo
[**] stay at 0.

For example, I've observed that fetchmail (using imaps protocol, with
exim as mta) triggers a disk read that spins up the disk _always_
(regardless of what's in the cache). However, I must confess I have'nt
tracked it down (or even looked at any source code).

[*] Processes making disk writes are supposed to be "harmless", because
laptop-mode will delay those writes to disk (that's what it's supposed
to do! ;).

[**] And that's why vmstat's bo is supposed to stay at 0.

-- 
Kiko
