Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTKDG3P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 01:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTKDG3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 01:29:15 -0500
Received: from [217.30.254.34] ([217.30.254.34]:2176 "EHLO
	alpha.linuxassembly.org") by vger.kernel.org with ESMTP
	id S263760AbTKDG3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 01:29:14 -0500
Date: Tue, 4 Nov 2003 09:30:28 +0300 (MSK)
From: Konstantin Boldyshev <konst@linuxassembly.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: minix fs corruption fix for 2.4
In-Reply-To: <Pine.LNX.4.44.0311030851430.20373-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.43L.0311040919460.1136-100000@alpha.linuxassembly.org>
Organization: Linux Assembly [http://linuxassembly.org]
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003, Linus Torvalds wrote:

> > Enclosed is a simple patch to fix corruption of minix filesystem
> > when deleting character and block device nodes (special files).
> > From what I've found out the bug was introduced somehwere in 2.3
> > and is present in all 2.4 versions, and I guess also goes into 2.6.
>
> Oops, yes.
>
> The problem is that block and character devices put not a block
> number but a _device_ number in the place where other files put
> their block allocations.

Yes, it took some time to find out why particular blocks
are being freed when I delete particular device nodes.

> Your patch is wrong, though - you shouldn't test for APPEND
> and IMMUTABLE here. That should be done at higher layers.

Perhaps. I just added the same check as ext2 code does in ext2_truncate().

-- 
Regards,
Konstantin

