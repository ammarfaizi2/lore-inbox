Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTLJBKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 20:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTLJBKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 20:10:00 -0500
Received: from blood.actrix.co.nz ([203.96.16.160]:36283 "EHLO
	blood.actrix.co.nz") by vger.kernel.org with ESMTP id S261569AbTLJBJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 20:09:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Charles Manning <manningc2@actrix.gen.nz>
Reply-To: manningc2@actrix.gen.nz
To: phillip@lougher.demon.co.uk, "David Woodhouse" <dwmw2@infradead.org>
Subject: [OT?]Re: partially encrypted filesystem
Date: Wed, 10 Dec 2003 14:16:46 +1300
X-Mailer: KMail [version 1.3.1]
Cc: joern@wohnheim.fh-wedel.de, kbiswas@neoscale.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <E1ATLgF-0003XX-0V@anchor-post-31.mail.demon.net>
In-Reply-To: <E1ATLgF-0003XX-0V@anchor-post-31.mail.demon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20031210010947.CA5875748@blood.actrix.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 02:44, phillip@lougher.demon.co.uk wrote:
> > JFFS2 was designed to avoid that inefficient extra layer, and work
> > directly on the flash. Since overwriting stuff in-place is so difficult,
> > or requires a whole new translation layer to map 'logical' addresses to
> > physical addresses, it was decided just to ditch the idea that physical
> > locality actually means _anything_.
>
> Maybe okay for a flash filesystem which is slow anyway, but many filesystem
> designers *are* concerned about physical locality of blocks, for example
> video filesystems.

Sure, just because JFFS2 choses to do something a certain way for a certain 
reason does not mean that others cannot choose to do something the different 
(or even the same) for a different reason.  The choices made in JFFS2 were 
done to work around the constraints of flash memory. When those are not 
present then 

Like JFFS2, YAFFS is also a log-structured flash file system that does not 
use a block device and does not assume physical data blocks can be updated in 
place. YAFFS uses a log structure for exactly the same reasons David 
presented (to get away from a physical location dependence - a killer for 
flash file systems). However, YAFFS uses fixed-size chucks as "log records" 
and is thus not really compression friendly. The differences between JFFS2 
and YAFFS are there for good reasons, beyond the scope of this discussion.

>
> > Given that design, compression just dropped into place; it was trivial.
>
> Or maybe 'not in(to)-place' :-) I don't think I was saying compression is
> difficult, it is not difficult if you've designed the filesystem correctly.

Effectively saying that a fs that can't easily support compression is badly 
designed is a dangerous over-simplfication/generalisation/slur. 

There are over 40 file systems for Linux - each is valid and exists because 
it does something that other fs don't do well or solve some particular 
problem.  Often, these fs jump through enough hoops of fire just to work 
effectively and adding compression could easily compromise the main goals of 
the fs.

As an example (that I'm familiar with :-)), I'd say that adding compression 
to YAFFS would at best compromise some of the YAFFS design goals and make it 
at best slower and at worst not be possible at all - without major upheaval. 
For those that simply *must* have compression on a YAFFS-based storage, I 
advise the use of a loop-mounted fs that provides compression (eg. cramfs) 
backed by a YAFFS file. This is being used in some products to great effect.  
It might seem that this adds extra overheads, but there is some saving 
because the whole file system does not have to carry the burden of 
compression etc.


-- CHarles
