Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUHIBPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUHIBPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 21:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUHIBPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 21:15:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265776AbUHIBPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 21:15:19 -0400
Date: Sun, 8 Aug 2004 21:14:49 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: David Howells <dhowells@redhat.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjanv@redhat.com>,
       <dwmw2@infradead.org>, <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       <sfrench@samba.org>, <mike@halcrow.us>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management
In-Reply-To: <Pine.LNX.4.58.0408072221480.1793@ppc970.osdl.org>
Message-ID: <Xine.LNX.4.44.0408082041010.1123-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, Linus Torvalds wrote:

> On Sun, 8 Aug 2004, James Morris wrote:
> > 
> > I would suggest that the /sbin/request-key interface be done via Netlink
> > messaging instead.  

> I really disagree. 
> 
> If you want to use netlink, do so. But do it from the /sbin/request-key
> script or binary.
> 
> I've never seen a good binary deamon listening for things. It's a horrible 
> interface. It's undebuggable, it's inflexible, and it's just plain nasty. 
> 
> I'm just looking at how _well_ /sbin/hotplug has worked out. I believe 
> that it would have been a disaster done with a binary messaging setup.

I'm not disagreeing with the above, but what about performance?  Part of
the reason I suggested Netlink is that it's likely to be more efficient to
send messages over a socket than to exec a program for each key request
from the kernel.

It's difficult to know if performance will actually be an issue without
understanding the potential workload more.  What if many thousands of
clients are connected to a fileserver?  Would calling /sbin/request-key
for each key request be likely to cause performance problems?


- James
-- 
James Morris
<jmorris@redhat.com>


