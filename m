Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWBAL2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWBAL2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWBAL2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:28:37 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:59866 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932426AbWBAL2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:28:35 -0500
Date: Wed, 1 Feb 2006 12:27:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Akinobu Mita <mita@miraclelinux.com>
cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
       linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [patch 15/44] generic ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
In-Reply-To: <20060201090326.139510000@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602011214270.12293@scrub.home>
References: <20060201090224.536581000@localhost.localdomain>
 <20060201090326.139510000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 1 Feb 2006, Akinobu Mita wrote:

> +static __inline__ int generic_test_le_bit(unsigned long nr,
> +				  __const__ unsigned long *addr)
> +{
> +	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
> +	return (tmp[nr >> 3] >> (nr & 7)) & 1;
> +}

The underscores are not needed.

For the inline version I would prefer this version:

{
	const unsigned char *tmp = (const unsigned char *)addr;
	return (tmp[nr >> 3] & (unsigned char)(1 << (nr & 7))) != 0;
}

Although this would be a good alternative as well:

{
	return (addr[nr >> 5] & (1 << ((nr ^ 24) & 31))) != 0;
}

bye, Roman
