Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWCUTMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWCUTMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWCUTMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:12:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8415 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965048AbWCUTMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:12:06 -0500
Date: Tue, 21 Mar 2006 20:11:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Phillip Lougher <phillip@lougher.org.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060321191144.GB3929@elf.ucw.cz>
References: <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44204F25.4090403@lougher.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 21-03-06 19:08:21, Phillip Lougher wrote:
> Al Viro wrote:
> 
> >On Tue, Mar 21, 2006 at 04:01:51PM +0000, Phillip Lougher wrote:
> > 
> >
> >>Perhaps, but almost all the byteswap is performed on the metadata side, 
> >>reading directories and inodes, where nearly every byte will need to be 
> >>swapped.  As inodes are compacted and compressed in 8 KB blocks, and are 
> >>on average 15 bytes in size, for each 8 KB decompress you're potentially 
> >>doing 8192/15 inode byteswaps.  This is probably sufficent to affect 
> >>directory search and lookup on a slow processor.
> >>   
> >>
> >
> >Oh, please...  Conversion from known endianness to host-endian is 
> >considerably
> >faster than checking flag + branch + two variants, not to mention being
> >smaller.
> > 
> >
> It's one flag check, and one set of swap code actually.  The point that 
> was being made is it is better to avoid byte swapping if possible.

Al is right. Unconditional swap is probably faster than
branch. Avoiding swaps is nice, but avoiding branches is probably more
important.

Can you try to benchmark it? I believe it is going to be lost in
noise, slow cpus or not.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
