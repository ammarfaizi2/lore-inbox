Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbUKRSgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbUKRSgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbUKRSfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:35:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:59831 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262845AbUKRSbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:31:36 -0500
Date: Thu, 18 Nov 2004 10:31:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Miklos Szeredi wrote:
> 
> Well, killing the fuse process _will_ make the system come back to
> life, since then all the dirty pages belonging to the filesystem will
> be discarded. 

They will? Why? They're still mapped into other processes, still dirty. 
How do they go away?

> > I really do believe that user-space filesystems have problems. There's a 
> > reason we tend to do them in kernel space. 
> 
> Well, NFS with a network failure has the same problem.  It's not the
> userspace that's the problem, it's the non-reliability.

No, it _is_ the userspace.

Yes, NFS is unreliable too, but it doesn't have the behaviour that when 
the client locks up, the server locks up too. The two aren't "linked", and 
they are protected from each other using up too much memory.

In contrast, a fuse process that needs to do IO is _not_ protected from 
the clients having eaten up all the memory it needs to do the IO.

Btw, this is not a new issue. This is the _exact_ same issue that "run the 
NFS server on the same machine as the client" has. And yes, it did have 
problems. People still did it, because it allowed for user-space 
filesystem demos.

> Currently shared writable mappings aren't allowed for non-root by
> default in FUSE.

Yes, that's a valid approach.

			Linus
