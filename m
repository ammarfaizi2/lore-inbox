Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUHHEpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUHHEpx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 00:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUHHEpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 00:45:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16579 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265093AbUHHEpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 00:45:51 -0400
Date: Sun, 8 Aug 2004 00:45:23 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjanv@redhat.com>,
       <dwmw2@infradead.org>, <greg@kroah.com>, <chrisw@osdl.org>,
       <sfrench@samba.org>, <mike@halcrow.us>, <trond.myklebust@fys.uio.no>,
       <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management [try #2]
In-Reply-To: <5147.1091896414@redhat.com>
Message-ID: <Xine.LNX.4.44.0408080034560.27710-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, David Howells wrote:

> >   I guess the pure way to do it is to add 13 new syscalls....
> 
> I don't really want to add any syscalls, though I wouldn't be too upset to add
> just one:-/
> 
> What're other people's thoughts on this?

Implement a filesystem interface, e.g. /proc/<pid>/keys

>From here you can have:

  /create

  /<keyid>/update
          /revoke
          /chown
          /chmod
          ...

Rather than syscalls/prctls for each of these.

For keyrings, you could have:

  /proc/<pid>/keyring/thread
                     /session
                     /process
                     ...

Instead of having /proc/keys and associated locking/seqfile overhead in 
the kernel, a userspace library could instead traverse /proc to build a 
global list of keys.

In general, I think you may be able to move logic out of the kernel this 
way, e.g. userspace searching for keys.


- James
-- 
James Morris
<jmorris@redhat.com>


