Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWG0R25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWG0R25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWG0R24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:28:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:63970 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751873AbWG0R24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:28:56 -0400
X-Authenticated: #428038
Date: Thu, 27 Jul 2006 19:28:52 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060727172852.GA11321@merlin.emma.line.org>
Mail-Followup-To: Grzegorz Kulewski <kangur@polcom.net>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org> <44C4813E.2030907@namesys.com> <20060726131709.GB5270@ucw.cz> <Pine.LNX.4.63.0607271732010.8976@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607271732010.8976@alpha.polcom.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Grzegorz Kulewski wrote:

> Sorry for my stupid question, but could you tell me why starting to make 
> incompatible changes to reiserfs3 now (when reiserfs3 "technology" is 
> rather old) and making reiserfs3 unstable (again), possibly for several 
> months or even years is better than fixing big issues with reiser4 (if 
> there are any really big left) merging it and trying to stabilize it?
> 
> For end user both ways will result in mkfs so...

ext2fs and ext3fs, without "plugins", added dir_index as a compatible
upgrade, with an e2fsck option (that implies optional) to build indices
for directories without them.

ext3fs is a compatible upgrade from ext2fs, it's as simple as unmount,
tune2fs -j, mount.

reiserfs 3.6 could deal with 3.5 file systems, and "mount -o conv" with
a 3.6 driver would convert a 3.5 file system to 3.6 level
(ISTR it had to do with large file support and perhaps NFS
exportability, but don't quote me on that).

I wonder what makes the hash overflow issue so complicated (other than
differing business plans, that is) that upgrading in place isn't
possible. Changes introduce instability, but namesys were proud of their
regression testing - so how sustainable is their internal test suite?

Instead, we're told reiser4 would fix this (quite likely) and we should
wait until it's ready (OK, we shouldn't be using experimental stuff for
production but rather for /tmp, but the file system will take many
months to mature after integration) and it will be "mkfs" time - so
reiser4 better be mature before we go that way if there's no way back
short of "amrecover", "restore" or "tar -x".

Smashing out most of the Cc:s in order not to bore people.

-- 
Matthias Andree
