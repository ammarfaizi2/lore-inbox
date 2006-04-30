Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWD3Xo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWD3Xo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 19:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWD3Xo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 19:44:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52161 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751240AbWD3Xo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 19:44:26 -0400
Date: Mon, 1 May 2006 08:04:27 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Greaves <david@dgreaves.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: Bad page state in process 'nfsd' with xfs
Message-ID: <20060501080427.H1771752@wobbly.melbourne.sgi.com>
References: <4452797F.70700@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4452797F.70700@dgreaves.com>; from david@dgreaves.com on Fri, Apr 28, 2006 at 09:22:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Fri, Apr 28, 2006 at 09:22:23PM +0100, David Greaves wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This was with 2.6.16.9
> 
> There's an nfs export from an xfs on an lvm on a raid5 on some
> libata/sata disks.
> (cc'ing xfs since I recall rumoured(?) badness in old nfs/xfs/md/lvm
> setups and xfs_sendfile is mentioned)

Really old (early 2.6) or previously with 4Kstacks this used to be
a problem, but should not be with your kernel version.

> Bad page state in process 'nfsd'
> page:b1602060 flags:0x80000008 mapping:00000000 mapcount:0 count:16777216
> Trying to fix it up, but a reboot is needed
> Backtrace:
>  [<b013bda2>] bad_page+0x62/0x90
>  [<b013c1c8>] prep_new_page+0x78/0x80
>  [<b013c6b6>] buffered_rmqueue+0xf6/0x1f0
>  [<b013c8e2>] get_page_from_freelist+0x92/0xb0

Hmm... so, your page flags field there (0x80000008) has the 33rd and
4th bits set - 4 is pageuptodate, which is fine, but 33 seems odd
(perhaps some arch-specific bit?  or a single bit error...).

But, the warning is triggered by the page count (16777216 above), and
that is 0x1000000 -- which is a huge, improbable count; that looks to
me like it could very well be the result of a single bit error too.

You may have a hardware problem - try running memtest I guess.

cheers.

-- 
Nathan
