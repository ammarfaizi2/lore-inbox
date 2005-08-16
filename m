Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVHPQ16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVHPQ16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVHPQ15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:27:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:42645 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030222AbVHPQ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:27:57 -0400
Date: Tue, 16 Aug 2005 18:27:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Flash erase groups and filesystems
Message-ID: <20050816162735.GB21462@wohnheim.fh-wedel.de>
References: <4300F963.5040905@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4300F963.5040905@drzeus.cx>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 August 2005 22:21:55 +0200, Pierre Ossman wrote:
> 
> To minimise the number of erases the MMC protocol supports pre-erasing
> blocks before you actually write to them. Now what I'm unclear on is how
> this will interact with filesystems and the assumptions they make.
> 
> If the controller gets a request to write 128 sectors and this fails
> after 20 sectors, the remaining 108 sectors will still have lost their
> data because of the pre-erase. Will this break assumptions made in the
> VFS layer? I.e. does it assume that only the failed sector has unknown data?
> 
> I'm writing a patch that gives this functionality to the MMC layer and
> since I'm no VFS expert I need some input into any side effects.

Question came up before, albeit with a different phrasing.  One
possible approach to benefit from this ability would be to create a
"forget" operation.  When a filesystem already knows that some data is
unneeded (after a truncate or erase operation), it will ask the device
to forget previously occupied blocks.

The device then has the _option_ of handling the forget operation.
Further reads on these blocks may return random data.

And since noone stepped up to implement this yet, you can still get
all the fame and glory yourself! ;)

Jörn

-- 
All art is but imitation of nature.
-- Lucius Annaeus Seneca
