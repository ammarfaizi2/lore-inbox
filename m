Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbUKEV7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUKEV7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 16:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUKEV7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 16:59:47 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:15263 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261217AbUKEV7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 16:59:43 -0500
Date: Fri, 5 Nov 2004 22:59:35 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, Andries Brouwer <aebr@win.tue.nl>,
       Adam Heath <doogie@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041105195045.GA16766@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel does do more these days than it did in '95. But 6 times more? I
> dunno..

Can't we remove ramfs for a good start? Everyone should use tmpfs instead 
and some stupid distributions (I will not tell their names) try to mount 
ramfs on /dev (udev) and that leads to very stupid panic if you will 
write for example:

dd if=/dev/evms/sda5 of=/dev/sda17 bs=1024

instead of "of=/dev/evms/sda17".

Explanation (if anybody needs one):
Kernel can't create more partition devices than 15 for SCSI and SATA disks 
because of lack of minor numbers. So I am using evms to create these 
devices. So I should use /dev/evms/sda* for these partitions. And if I 
will not remember to do so then I will get oom panic very shortly because 
ramfs is not limited (in contrary to tmpfs).

And this kind of stupid mistake can happen. It happened to me 3 times in a 
row before I started to debug what is wrong with this kernel.

[BTW. Does somebody know how to tell the kernel that I do not want 
/dev/sda[0-9]* files (but I do want /dev/hda files) created == I do not 
want kernel partition driver to touch this particular device?]

And using ramfs for anything else can easily lead to similar problems. So 
I think we do not need ramfs. Am I wrong? [I understand that removing it 
will not remove much code.]


Thanks,

Grzegorz Kulewski

