Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWKERSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWKERSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161383AbWKERSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:18:13 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:41431 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161382AbWKERSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:18:08 -0500
Date: Sun, 5 Nov 2006 18:18:07 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <1162691856.21654.61.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611051813440.1513@artax.karlin.mff.cuni.cz>
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
 <1162691856.21654.61.camel@localhost.localdomain>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> And possibly some broken drives may also return you something that
>>> they think is good data but really is not (shouldn't happen since
>>> both disks and cables should be protected by checksums, but hey...
>>> you can never be absolutely sure especially on very big storages).
>
> It happens because
> -	There is limited if any protection on the PCI bus generally
> -	Many PC systems don't have ECC memory, ECC cache
> -	PATA does not CRC protect the command block so if you do enough PATA
> I/O (eg you are a US national lab ..) you *will* eventually get a bit
> flip that gives you the wrong sector with no error data. SATA fixes that
> one.
> -	Murphy is out to get you..

Should IDE driver read back parameters after writing them before issuing 
the command? That should fix this problem. (except when command is written 
badly)

> Not seen that, although they do move stuff aorund in their internal
> block management of bad blocks. I've also seen hardware errors that lead
> to data being messed up silently.

I have seen one WD drive bought in 2003 having error in its firmware in 
cache-coherency code --- if you read and write 256 sectors to the same 
places with some pattern repeatedly (with direct IO), it will discard a 
write. It happens only with 256-sector writes, maybe some part of firmware 
treats 256 as 0. Maybe I create testcase sometimes.

Mikulas

> Alan
>
