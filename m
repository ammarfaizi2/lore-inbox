Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTKCRTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTKCRTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:19:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11150 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263178AbTKCRT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:19:28 -0500
Date: Mon, 3 Nov 2003 17:19:25 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Konstantin Boldyshev <konst@linuxassembly.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcelo.tosatti@cyclades.com
Subject: Re: minix fs corruption fix for 2.4
Message-ID: <20031103171925.GH7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.43L.0311031557480.1077-200000@alpha.linuxassembly.org> <Pine.LNX.4.44.0311030851430.20373-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311030851430.20373-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 08:55:42AM -0800, Linus Torvalds wrote:
> I'd also prefer to do the test the other way around: test for CHRDEV and 
> BLKDEV in inode.c the same way the other functions do. Something like the 
> appended..
> 
> Al, can you verify? I think this crept in when you did the block lookup 
> cleanups. I also worry whether anybody else got the bug?
> 
> 		Linus

Hmm...  I would rather check for regular|directory|symlink explicitly -
note that FIFO and socket can have junk in i_data.

Looks like that fsckup had happened only in fs/minix - fs/sysv/itree.c
does it right.
