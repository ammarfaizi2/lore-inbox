Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130097AbRBAE6w>; Wed, 31 Jan 2001 23:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130099AbRBAE6m>; Wed, 31 Jan 2001 23:58:42 -0500
Received: from mnh-1-14.mv.com ([207.22.10.46]:12816 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S130097AbRBAE61>;
	Wed, 31 Jan 2001 23:58:27 -0500
Message-Id: <200102010608.BAA05591@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Brian Ristuccia <brian@ristuccia.com>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        Alex Pennace <alex@osiris.978.org>,
        Dennis Ristuccia <dennis@osiris.978.org>
Subject: Re: [uml-devel] usermode linux hoses 2.2.18-SMP host machine when run 
 from regular user account
In-Reply-To: Your message of "Wed, 31 Jan 2001 23:29:44 EST."
             <20010131232944.J16908@osiris.978.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Feb 2001 01:08:35 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

brian@ristuccia.com said:
> When run from a normal user account with its current working directory
> on a NFS filesystem, usermode linux causes the host machine's kernel
> to enter a hosed state. No processes (including UML) seem to respond,
> and the machine becomes unusable. 

Just to clarify what I think UML is doing that's causing the trouble: it is an 
extensive user of mmap.  It creates several files (one 16 meg by default, but 
possibly much larger) in $PWD, and mmaps them into all of its threads.  The 
"physical memory" file also has individual pages mapped twice (or more) into 
various threads.

I've seen this confuse an old version of reiserfs and NFS, although not so 
much that the machine hung.  UML would just see stale data, get horribly 
confused by it, and crash.

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
