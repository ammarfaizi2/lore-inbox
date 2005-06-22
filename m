Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVFVPlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVFVPlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVFVPfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:35:42 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:39948 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261526AbVFVPen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:34:43 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>, gregkh@suse.de, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from
 being built
References: <20050621222419.GA23896@kroah.com>
	<20050621.155919.85409752.davem@davemloft.net>
	<20050622082253.GA4594@infradead.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: resistance is futile; you will be assimilated and byte-compiled.
Date: Wed, 22 Jun 2005 16:34:06 +0100
In-Reply-To: <20050622082253.GA4594@infradead.org> (Christoph Hellwig's
 message of "22 Jun 2005 09:42:20 +0100")
Message-ID: <87zmtiwglt.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jun 2005, Christoph Hellwig wrote:
> On Tue, Jun 21, 2005 at 03:59:19PM -0700, David S. Miller wrote:
>> I know the rational behind this.
>> 
>> However, this does mean I do need to reinstall a couple
>> debian boxes here to something newer before I can continue
>> doing kernel work in 2.6.x on them.
> 
> I have half a dozend debian sarge,etch and sid boxes on various architectures
> and they work just fine without devfs.

Everything works until you put your root filesystem on LVM (or RAID,
perhaps, but I've never used that so can't be sure).

The Debian initrd-tools rely on devfs to populate block devices
corresponding to physical disks. If you explictlly name your root
filesystem, you're safe even without devfs, because the initrd's
/sbin/init script also explicitly mknods your root device --- but if
your root filesystem is on LVM, well, vgscan needs to search your
physical disks, which means that they have to exist *before* vgscan
runs, for which it uses devfs and only devfs.

Debian users in this situation can always build their own initrds --- I
did --- but it's, er, not something I'd expect users to be able to do.


Of course, killing off devfs now might prod the Debian maintainers into
populating physical devices using udev instead ;)

(There is a Debian bug for this, #312871. It's marked as wishlist, which
strikes me as much too low.)

-- 
`It's as bizarre an intrusion as, I don't know, the hobbits coming home
 to find that the Shire has been taken over by gangsta rappers.'
