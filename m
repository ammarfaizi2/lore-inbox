Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932738AbWKEQWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWKEQWX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWKEQWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:22:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:53917 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932738AbWKEQWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:22:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P2WIKG4dS4tquEGzli2wx1k462NUPNTLqCGIpCupgN3VcAL+0CmlhQmIeqSf4ZULaEABMwT1K5GCK/czsb897TYNhbPSiRAkImdgxN+RtwCLPk6sotGD4Mn3qjOz4UZTNBuzZA+x25D3fpuFOpjjFC5UpvMBACzniqgatW5cNyk=
Message-ID: <787b0d920611050822p624401cj763397c0558c373d@mail.gmail.com>
Date: Sun, 5 Nov 2006 11:22:20 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "James Courtier-Dutton" <James@superbug.co.uk>
Subject: Re: New filesystem for Linux
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, kangur@polcom.net,
       mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <454DC799.9000401@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
	 <1162691856.21654.61.camel@localhost.localdomain>
	 <454DC799.9000401@superbug.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/06, James Courtier-Dutton <James@superbug.co.uk> wrote:

> I have seen this too. I think that when IDE drive relocates the sector
> due to hard errors, one would silently loose the information that was
> stored in that sector.

I didn't just mean hidden relocation of bad blocks.

I really meant that sectors can trade places. This is probably
what happens when the bad-block remapping is itself corrupt.

Inodes 16,17,18,19 trade places with inodes 40,41,42,43.
An indirect block for your database trades places with an
indirect block for an outgoing email. A chunk of /etc/shadow
trades places with a chunk of a user's ~/.bash_logout file.

> I suppose a work around is to provide a fs level error check. This could
> take the form of the fs adding a checksum to any file. To avoid recheck
> summing the entire file each time it changes, maybe break the file up
> into blocks and checksum those. This would slow things down due to CPU
> use for the checksum, but at least we could tell us as soon as a file
> became corrupted, as the verification could be done on reading the file.

Yes indeed. This is what ZFS does. You can choose between
regular and crypto checksums. You can cause the filesystem
to replicate blocks over multiple devices. Unlike RAID, this lets
you recover from silent corruption.

> Another possible solution could be using a few bytes from each sector to
> place a fs level checksum in. Then, if the IDE drive silently relocates
> the sector, the fs level checksum will fail. A saw a feature like this
> on some old filesystem, but I don't remember which. It placed a
> checksum, forwards chain link, and possibly backwards chain link. So, if
> the filesystem became really badly corrupted, one could pick any sector
> on the disk and recover the entire file associated with it.

Both OS/400 and AmigaOS had this feature. AmigaOS used regular
512-byte sectors, making the data portion oddly sized. OS/400 made
the sectors bigger, by another 8 or 16 bytes if I remember right.
