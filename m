Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVK2EQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVK2EQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVK2EQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:16:41 -0500
Received: from koto.vergenet.net ([210.128.90.7]:33734 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750717AbVK2EQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:16:40 -0500
Date: Tue, 29 Nov 2005 13:16:08 +0900
From: Horms <horms@verge.net.au>
To: Colin Leroy <colin@colino.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH] hfs, hfsplus: don't leak s_fs_info and fix an oops
Message-ID: <20051129041606.GA9575@verge.net.au>
Mail-Followup-To: Colin Leroy <colin@colino.net>,
	Roman Zippel <zippel@linux-m68k.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
References: <20051007043924.GA20827@verge.net.au> <20051007071008.CAC4E10334@paperstreet.colino.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007071008.CAC4E10334@paperstreet.colino.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 09:10:05AM +0200, Colin Leroy wrote:
> On 07 Oct 2005 at 13h10, Horms wrote:
> 
> Hi, 
> 
> > I took a look at making a backport, and it seems that
> > some of the problems are there, but without a deeper inspection
> > of the code its difficult to tell if the problems manifest or not.
> 
> That was easy to get the oops:
> 
> $ dd if=/dev/zero of=im_not_hfsplus count=10 #for example
> $ mkdir test_dir
> $ sudo mount -o loop -t hfsplus ./im_not_hfsplus ./testdir
> $ dmesg

After an extended delay I have been able to confirm that the above
commands do not cause 2.4 (Debian's 2.4.27) to do anything unusal.

Mount just reports:
  mount: wrong fs type, bad option, bad superblock on /dev/loop0,
       or too many mounted file systems

And there is nothing exciting in dmsg:
  loop: loaded (max 8 devices)
  HFS+-fs: unable to find HFS+ superblock
  HFS+-fs: unable to find HFS+ superblock
  HFS+-fs: unable to find HFS+ superblock

Thus it seems that 2.4 does not suffer from this bug.

-- 
Horms
