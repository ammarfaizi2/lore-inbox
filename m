Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbUABKvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUABKvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:51:45 -0500
Received: from smtp5.hy.skanova.net ([195.67.199.134]:33007 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S265507AbUABKvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:51:43 -0500
To: arjanv@redhat.com
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, packet-writing@suse.com,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
	<20040101162427.4c6c020b.akpm@osdl.org> <m2llorkuhn.fsf@telia.com>
	<1073034412.4429.1.camel@laptop.fenrus.com>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jan 2004 11:51:24 +0100
In-Reply-To: <1073034412.4429.1.camel@laptop.fenrus.com>
Message-ID: <m2k74a8vyr.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Fri, 2004-01-02 at 02:30, Peter Osterlund wrote:
> 
> > The packet writing code has the restriction that a bio must not span a
> > packet boundary. (A packet is 32*2048 bytes.) If the page when mapped
> > to disk starts 2kb before a packet boundary, merge_bvec_fn therefore
> > returns 2048, which is less than len, which is 4096 if the whole page
> > is mapped, so the bio_add_page() call fails.
> 
> devicemapper has similar restrictions for raid0 format; in that case
> it's device-mappers job to split the page/bio. Just as it is UDF's task
> to do the same I suspect...

Old versions of the packet writing code did just that, but Jens told
me that bio splitting was evil, so when the merge_bvec_fn
functionality was added to the kernel, I started to use it.

        http://lists.suse.com/archive/packet-writing/2002-Aug/0044.html

If merge_bvec_fn is not supposed to be able to handle the need of the
packet writing code, I can certainly resurrect my bio splitting code.

Btw, for some reason, this bug is not triggered when using the UDF
filesystem on a CDRW. I've only seen it with the ext2 filesystem.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
