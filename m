Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRKVKSs>; Thu, 22 Nov 2001 05:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRKVKS2>; Thu, 22 Nov 2001 05:18:28 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:51139 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S276249AbRKVKSX>; Thu, 22 Nov 2001 05:18:23 -0500
Date: Thu, 22 Nov 2001 11:21:46 +0100
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: linux-kernel@vger.kernel.org
Subject: Re: File size limit exceeded with mkfs
Message-ID: <20011122112146.A1155@zodiak.ecademix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> This kind of differences (direct root login vs su) usualy are due to 
> different environment variable settings. 

Not in this case, it is because after 'su -' userland tries to
set the RLIMIT_FSIZE to unlimited with with the constant
0x7fffffff which is different from the one kernel uses internal
0xffffffff (see http://www.uwsg.indiana.edu/hypermail/linux/kernel/0111.1/0036.html and all next messages).

If this is more a gnulib or kernel mistake ? I don't know, but
the kernel uses sys_old_getrlimit and gives 0x7fffffff back to userland.

I think in this case the kernel should do the same in the other direction
(leafing a hole form 0x7fffffff to 0xffffffff where you could not set
the FSIZE).

Cheers,
 Peter

