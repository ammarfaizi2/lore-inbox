Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVABVII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVABVII (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 16:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVABVIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 16:08:07 -0500
Received: from zeus.kernel.org ([204.152.189.113]:54161 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261306AbVABVHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 16:07:46 -0500
Date: Sun, 2 Jan 2005 22:05:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Oliver Neukum <oliver@neukum.org>, luto@myrealbox.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20050102210536.GF4183@stusta.de>
References: <20050102193724.GA18136@elf.ucw.cz> <20050102201147.GB4183@stusta.de> <200501022134.16338.oliver@neukum.org> <20050102205151.GE4183@stusta.de> <20050102205650.GG18136@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102205650.GG18136@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 09:56:50PM +0100, Pavel Machek wrote:
> 
> Okay, so the right solution is probably something more like
> 
> while umount /mnt; do
> 	fuser -km -TERM /mnt
> 	sleep 1
> 	fuser -km /mnt
> done
> 
> Not sure how many command line users can do this... Perhaps including
> fumount script doing this is good idea?

A command line user only needs to know about fuser, and in the unlikely 
case if the race condition Oliver thought of occurs he'll note since 
umount will give an error message.

I'd even say the more common case is to use fuser to get the PIDs of the 
processes and manually check which they are - e.g. you might not want to 
kill your OpenOffice with many open documents only because you'd 
forgotten that it still has one document open on the file system you are 
trying to remove.

> 								Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

