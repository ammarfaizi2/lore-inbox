Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVLCLeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVLCLeI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 06:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVLCLeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 06:34:08 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:48056 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750933AbVLCLeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 06:34:07 -0500
Subject: Re: [PATCH] fs: remove s_old_blocksize from struct super_block
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jeffm@suse.com,
       torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0512031058350.11664@hermes-1.csi.cam.ac.uk>
References: <1133558437.31065.6.camel@localhost>
	 <Pine.LNX.4.64.0512031058350.11664@hermes-1.csi.cam.ac.uk>
Date: Sat, 03 Dec 2005 13:34:04 +0200
Message-Id: <1133609645.7989.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Fri, 2 Dec 2005, Pekka Enberg wrote:
> > The s_old_blocksize field of struct super_block is only used as a temporary
> > variable in get_sb_bdev(). This patch changes the function to use a local
> > variable instead so we can kill the field from struct super_block.

On Sat, 2005-12-03 at 11:02 +0000, Anton Altaparmakov wrote:
> s_old_blocksize used to be used to restore the blocksize after the 
> filesystem had failed to mount or had unmounted.  Not restoring this leads 
> to all sorts of problems since the blocksize may be set for example to 4k 
> but some userspace app may need it to be set to 1k or whatever.  There 
> used to be applications that failed which is why s_old_blocksize was 
> introduced and it used to restore the blocksize.
> 
> I have no idea why/when the restoring has been removed but chances are the 
> removal was wrong.  Now every file system will need to restore the 
> blocksize itself (as it used to be before s_old_blocksize and blocksize 
> restoral was introduced).  Except whoever removed the restoration failed 
> to fix up all file systems.  )-:

It was removed in this commit, I think:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=294c42046966e927ef86c0d4ce71cff32d9b458c

			Pekka

