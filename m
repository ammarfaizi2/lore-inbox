Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbULMVhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbULMVhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbULMVhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:37:11 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:2116 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261171AbULMVhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:37:00 -0500
Date: Mon, 13 Dec 2004 23:37:54 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: how to detect a 32 bit process on 64 bit kernel
Message-ID: <20041213213754.GA21464@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20041212215110.GA11451@mellanox.co.il> <20041212222309.GA11045@infradead.org> <20041213195011.GA24053@mellanox.co.il> <41BE0A75.3070206@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BE0A75.3070206@didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Brian Gerst (bgerst@didntduck.org) "Re: how to detect a 32 bit process on 64 bit kernel":
> Michael S. Tsirkin wrote:
> 
> >Hello!
> >Quoting r. Christoph Hellwig (hch@infradead.org) "Re: how to detect a 32 
> >bit process on 64 bit kernel":
> >
> >>>If no - would not it make a sence to add e.g. a flag in the
> >>>task struct, to make it possible?
> >>
> >>The kernel code shouldn't know.  If your driver needs this information
> >>something is seriously wrong with it. 
> >
> >
> >A character driver I am working on gets passed a structure
> >from user space by implementing a write file operation.
> >The structure includes a pointer and so the format varies
> >between a 32 and 64 bit processes.
> 
> The most portable way to do this is to have the first member of the 
> structure be a 32-bit value containing the size of the structure.  This 
> can then be used to identify what the structure format is.  This also 
> has the advantage of future-proofing the interface (add a field?  no 
> problem, the new size can be checked for).  Just be very careful that 
> the size from userspace is not trusted (ie. only allow known sizes).
> 
> --
> 				Brian Gerst

The size wont be sufficient here since its variable size
(ends with an array).

Sure, I could also just ask everyone to pass pointers in a
packed long long, but either way it will break the applications.

Why wouldnt it make sence for struct task to have a bit that tells
me its a compat system?

MST
