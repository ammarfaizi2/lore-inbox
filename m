Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUH2QEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUH2QEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUH2QEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:04:24 -0400
Received: from main.gmane.org ([80.91.224.249]:7817 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268053AbUH2QEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:04:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Marc_Str=E4mke?= <marcstraemke.work@gmx.net>
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the
   IDE bus)
Date: Sun, 29 Aug 2004 18:06:55 +0200
Message-ID: <cgsuq2$7cb$1@sea.gmane.org>
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95f8c6b.dip.t-dialin.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
In-Reply-To: <4131DC5D.8060408@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> Its been awhile, but the last time that I looked at the relevant code, 
> there was a table of drive vendor/device strings that were used to 
> identify CFA devices and differentiate them from regular ide devices.  
> If this particular device isn't a match in that table, it would be 
> mis-identified, and that could be leading to your above problem.
> Neil
> 

Thx for the suggestion. The only table i could find is in 
drive_is_flashcard, which is only checked if drive->removable is set, 
which is not the case with the newer card (but is with the old one).
Another thing which is weird is that the old card returns an id->config 
value of 0x848a which according to manuals from SanDisk is for a 
Compactflash card NOT running in True Ide mode, but instead in memory 
mapped IO mode (iam no expert for Compactflash, so i dont even know the 
exact difference), but as far as i can tell are both cards wired by the 
IDE adapter so that they should run in True IDE mode, and if i 
understand the Compactflash specification correctly, this is the only 
mode of operation which is electrically compatible with the IDE/ATA bus, 
isnt it?
I tried forcing both the drive->removable and drive->is_flash flags to 
the true, my dmesg output then shows me the card as a CFA DISK drive, 
but i still get the same errors when reading or writing from/to the device.

TIA for any further hints,
Marc

