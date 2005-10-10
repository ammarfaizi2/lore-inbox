Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVJJVgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVJJVgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJJVgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:36:04 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:5796 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1751263AbVJJVgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:36:02 -0400
Date: Mon, 10 Oct 2005 18:46:05 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: glommer@br.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, hch@infradead.org, viro@zeniv.linux.org.uk,
       mikulas@artax.karlin.mff.cuni.cz, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051010214605.GA11427@br.ibm.com>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 10:20:07PM +0100, Anton Altaparmakov wrote:
> Hi,
> 
> On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:
> > I've just noticed that the use of sb_getblk differs between locations
> > inside the kernel. To be precise, in some locations there are tests
> > against its return value, and in some places there are not.
> > 
> > According to the comments in __getblk definition, the tests are not
> > necessary, as the function always return a buffer_head (maybe a wrong
> > one),
> 
> If you had read the source code rather than just the comments you would 
> have seen that this is not true.  It can return NULL (see 
> fs/buffer.c::__getblk_slow()).  Certainly I would prefer to keep the 
> checks in NTFS, please.  They may only be good for catching bugs but I 
> like catching bugs rather than segfaulting due to a NULL dereference.

I did. But I did not see this specifically, for sure. What takes us to
the opposite problem: A lot of places do not check for the return value
of getblk (Almost half of them, I'd say), and may thus lead to a 
dereferencing  of a NULL pointer.

Does anyone else have any comments on that?

> Best regards,
Thanks,
> 	Anton
Glauber

> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
> Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
> 

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================
