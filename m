Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSGVBJQ>; Sun, 21 Jul 2002 21:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSGVBJQ>; Sun, 21 Jul 2002 21:09:16 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:18540 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315454AbSGVBJP>; Sun, 21 Jul 2002 21:09:15 -0400
Date: Sun, 21 Jul 2002 19:12:20 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <Pine.LNX.4.30.0207211705220.701-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.44.0207211908320.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 21 Jul 2002, Szakacsits Szabolcs wrote:
> What about the many hundred counter-examples

These cases are different.

> (e.g. umount gives EBUSY,

Simply because you _will_ lose data if you umount a device that's being 
scribbled on.

> kill can't kill processes in uninterruptible sleep

Because the uninterruptible sleep means the process is waiting for data. 
If you destroy the process and kill an interrupt handler, you _will_ 
crash.

> , etc, etc)? Why the system knows better then admin in these cases? Why
> just don't destroy the data, crash the system as you suggest in your
> case?

This case is different. If you swapoff /dev/scsi/path/to/dead/disk, your 
system will likely live on. Possibly you'll have some tasks killed, but 
we're well up.

Alan was referring to cases where it's unlikely that we die of it, you're 
referring to cases where it's clear that the system won't get through.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

