Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752923AbWKCBea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbWKCBea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbWKCBea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:34:30 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:37526 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752923AbWKCBe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:34:29 -0500
Date: Fri, 3 Nov 2006 02:34:28 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.63.0611030022110.14187@alpha.polcom.net>
Message-ID: <Pine.LNX.4.64.0611030228470.7781@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net>
 <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.63.0611030022110.14187@alpha.polcom.net>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There was discussion about it here some times ago, and I think the result 
>> was that the IDE bus is reset prior to capacitors discharge and total loss 
>> of power and disk has enough time to finish a sector --- but if you have 
>> crap power supply (doesn't signal power loss), crap motherboard (doesn't 
>> reset bus) or crap disk (doesn't respond to reset), it can fail.
>
> Hmm, maybe. But I think I saw couple of such bad sectors that were only bad 
> because of power loss in the wild.
>
>
>> BTW. reiserfs and xfs depend on this feature too. ext3 is the only one that 
>> doesn't.
>
> Well, at least for XFS everybody tell that it should be used with UPS only if 
> you really care about your data. I think it has something to do with heavy 
> in-RAM caching this filesystem does.

System is allowed to cache anything unless sync/fsync is called. Someone 
told that XFS has some bugs that if crashed incorrectly, it can lose 
already synced data ... don't know. Plus it has that infamous feature (not 
a bug) that it commits size-increase but not data and you see zero-filed 
files.

> Anyway, it looks strange to list something very fragile and potentially not 
> existing in the requirements... :-)

Better to list it than quitly depend on it like ext2/fat/reiser/xfs/ 
(maybe jfs?) do.

> Could you explain where exactly do you depend on this requirement? And what 
> could happen if it is not true?

If you write a file in a directory and the sector is unwritable upon write 
& crash, you lose those few files near it. Just the similar way you would 
lose 4 files in inode table on ext2 in this case.

> Thanks,
>
> Grzegorz Kulewski
>
>
> PS. Do you have any benchmarks of your filesystem? Did you do any longer 
> automated tests to prove it is not going to loose data to easily?

I have, I may find them and post them. (but the university wants me to 
post them to some conference, so I should keep them secret :-/)

Mikulas

