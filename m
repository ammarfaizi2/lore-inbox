Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbULALgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbULALgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 06:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbULALgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 06:36:46 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:951 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261372AbULALgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 06:36:44 -0500
Date: Wed, 1 Dec 2004 12:36:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <20041129224404.GP26051@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0412011227470.793@scrub.home>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <20041129224404.GP26051@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Nov 2004, Al Viro wrote:

> That leaves affs_fs.h containing only AFFS_SUPER_MAGIC declaration and
> amigaffs.h also seriously cleaned up; it still has a bunch of defines that
> are almost certainly never used in userland (they refer to ->b_data and
> in-core affs superblock), but these might in theory be useful (similar
> stuff for ext2 *is* used by userland code).
> 
> If Roman is OK with their removal, AFFS_DATA and friends should also get
> moved to fs/affs/affs.h.

Looks good. Thanks.
I wouldn't mind moving it all to fs/affs, I don't think there is any 
userspace dependency here. I have a simple mkaffs tool, but that uses a 
copy of it.

> +#if 0
> +	s32	 i_original;			/* if != 0, this is the key of the original */
> +	u32	 i_data[AFFS_MAX_PREALLOC];	/* preallocated blocks */
> +	int	 i_cache_users;			/* Cache cannot be freed while > 0 */
> +	unsigned char i_hlink;			/* This is a fake */
> +	unsigned char i_pad;
> +	s32	 i_parent;			/* parent ino */
> +#endif

That can be killed.

bye, Roman
