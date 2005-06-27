Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVF0Uvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVF0Uvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVF0UvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:51:01 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:61363 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261689AbVF0UrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:47:25 -0400
Message-ID: <42C065D5.30805@namesys.com>
Date: Mon, 27 Jun 2005 13:47:17 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Steve Lord <lord@xfs.org>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>, vitaly@thebsh.namesys.com,
       Chris Mason <mason@suse.com>
Subject: Re: reiser4 plugins
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <42C05F16.5000804@xfs.org> <20050627202841.GA27805@thunk.org>
In-Reply-To: <20050627202841.GA27805@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Mon, Jun 27, 2005 at 03:18:30PM -0500, Steve Lord wrote:
>  
>
>>I presume Ted is referring to problems guaranteeing the integrity of
>>the journal at recovery time. I am coming into this without all the
>>available context, so I may be barking up the wrong tree.... In
>>particular, I am not sure how journaling whole blocks protects
>>you from this.
>>    
>>
>
>Actually, I was talking about the problem what happens when power
>fails while DMA'ing to the disk, and memory, which is more sensitive
>to voltage drops than the rest of the system, starts sending garbage
>to the bus, which the disk then faithfully writes to the inode table.
>
>As I recall, you were the one who told me about this problem, and how
>it was fixed in Irix by using a powerfail interrupt to abort DMA
>transfers, as well as giving me a program which tests for this
>condition (basically it writes known test pattern to the disk, and
>then you do an unclean shutdown, and you look to see if garbage is
>written to the disk instead of one of the known test patterns).  If it
>wasn't you, it must have been Jim Mostek --- but I could have sworn it
>was you.....
>
>						- Ted
>
>
>  
>
Maybe a more positive approach would be to say, hey, I got this program
from the XFS guys that tests for DMA problems on power failure, maybe
all the Linux filesystem developers should give it a try?

Shall we try that style of interaction?

Ted, if this corruption hits an ext3 directory structure, and that
corrupted directory structure commits, what happens?  With ReiserFS
(Chris please comment here) it would have to corrupt the directory in
the journal, return successful IO, then after that point not corrupt the
commit block and have enough power to write the commit block.  How is
that different for XFS or ext3?

Hans
