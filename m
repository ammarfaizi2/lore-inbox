Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319716AbSINJtI>; Sat, 14 Sep 2002 05:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319771AbSINJtI>; Sat, 14 Sep 2002 05:49:08 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:8971 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S319716AbSINJtH>; Sat, 14 Sep 2002 05:49:07 -0400
Date: Sat, 14 Sep 2002 11:53:56 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
Message-ID: <20020914095356.GA28271@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020914010101.75725.qmail@web40502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020914010101.75725.qmail@web40502.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Alex Davis wrote:

> The cleanup() function in ide-disk.c will flush the write cache. Also, would
> someone please point me to some documentation that states the cache is flushed
> when the disk is put in standby: when I called Maxtor about this, they said that

How about this: The FLUSH CACHE command has only recently become a
mandatory command for non-PACKET devices, so there may be drives that do
implement a write cache, but do NOT implement the FLUSH CACHE -- and
still adhere to some older edition of the ATA standard.

> the cache is NOT flushed. BTW, if your disk is so broken as to require being put
> in standby mode to flush its write cache, then you are at great risk for data
> corruption.

See above. Disable Write Cache would also do with recent drives.

IBM specified for the DeskStar 40GV and 75GXP drives (DTLA, I use this
manual as I have that handy) that Soft Reset, Standby (Immediate) and
Flush Cache commands would only be executed after the completion of
writing to media (see the OEM manual, section 10.10 write cache
function, p.91 in my edition), and goes on "It is recommended that the
host system verify the completion of the write cache operation by
issuing Soft reset, the Standby (Immediate) command, or the Flush Cache
command to the device before power off."

I think I recall that some notebook drives would need the standby
immediate to flush the cache to work around firmware bugs with other
methods.


If I recall correctly, Windows' shutdown procedure was at some time in
the past changed to wait a couple of seconds before switching the ATX
computers off, to allow the drives to flush their caches. I can't quote
on a KB article though.

-- 
Matthias Andree
