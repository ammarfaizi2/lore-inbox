Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWKELOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWKELOg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 06:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWKELOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 06:14:36 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:40464 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S932637AbWKELOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 06:14:35 -0500
Message-ID: <454DC799.9000401@superbug.co.uk>
Date: Sun, 05 Nov 2006 11:14:33 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.7 (X11/20061020)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <1162691856.21654.61.camel@localhost.localdomain>
In-Reply-To: <1162691856.21654.61.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
<snip>
> 
> Not seen that, although they do move stuff aorund in their internal
> block management of bad blocks. I've also seen hardware errors that lead
> to data being messed up silently. 
 >
 > Alan
 >

I have seen this too. I think that when IDE drive relocates the sector 
due to hard errors, one would silently loose the information that was 
stored in that sector.
How can one detect this? Of course it would be nice if the IDE drive 
told us that sector X had just gone bad but I don't think they do. They 
just silently relocate it because in some cases the sector has only gone 
a "bit" bad, so the IDE drive relocates it before it totally fails.

I suppose a work around is to provide a fs level error check. This could 
take the form of the fs adding a checksum to any file. To avoid recheck 
summing the entire file each time it changes, maybe break the file up 
into blocks and checksum those. This would slow things down due to CPU 
use for the checksum, but at least we could tell us as soon as a file 
became corrupted, as the verification could be done on reading the file.

Another possible solution could be using a few bytes from each sector to 
place a fs level checksum in. Then, if the IDE drive silently relocates 
the sector, the fs level checksum will fail. A saw a feature like this 
on some old filesystem, but I don't remember which. It placed a 
checksum, forwards chain link, and possibly backwards chain link. So, if 
the filesystem became really badly corrupted, one could pick any sector 
on the disk and recover the entire file associated with it.
I seem to remember that OS/2 used a 32bit forwards chain, but not the 
checksum.

James




