Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUHIOJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUHIOJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUHIOJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:09:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21430 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266596AbUHIOIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:08:43 -0400
Date: Mon, 9 Aug 2004 10:08:20 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjanv@redhat.com>,
       <dwmw2@infradead.org>, <greg@kroah.com>, <chrisw@osdl.org>,
       <sfrench@samba.org>, <mike@halcrow.us>, <trond.myklebust@fys.uio.no>,
       <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management [try #2]
In-Reply-To: <15907.1092044030@redhat.com>
Message-ID: <Xine.LNX.4.44.0408090953410.2947-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004, David Howells wrote:

> James Morris <jmorris@redhat.com> wrote:
> > Implement a filesystem interface, e.g. /proc/<pid>/keys
> > 
> > From here you can have:
> > 
> >   /create
> 
> How would this work? Remember you've got to get some data back, and you've got
> to simultaneously attach your key to a keyring, otherwise it'll just be erased
> immediately.

I figured you would write to the file (a keyring id?) and it would return 
a key id.

> > For keyrings, you could have:
> > 
> >   /proc/<pid>/keyring/thread
> >                      /session
> >                      /process
> >                      ...
> 
> What are these? Files containing keyring ID numbers? If so, better to just
> have one file from whence you can read all the IDs, and since /proc/pid/status
> has to grab the requisite lock anyway...

They would contain symlinks to keyring IDs.

> Besides, the search _has_ to be available in kernel space. A filesystem such
> as AFS or NFS would need to be able to call it during file->open(), and maybe
> at other times. Would you suggest that it should call out to userspace to do
> the keyring search?

No.  The reason for suggesting this was because with a filesystem API, the 
information is already available in userspace, and it would be quite 
simple to enumerate it.  As you said, it's not something that would happen 
all the time, so it's not performance critical.  But if you need a kernel 
API for the same thing, it's a moot point.

> Or would you, say, suggest a new open() syscall that takes a key ID in
> addition?

No, that would require changes to userspace code.


- James
-- 
James Morris
<jmorris@redhat.com>


