Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVDYQY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVDYQY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDYQXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:23:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:20187 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262661AbVDYQSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:18:48 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: 7eggert@gmx.de
Cc: Jan Hudec <bulb@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
References: <3WVU1-2GE-7@gated-at.bofh.it> <3WWn1-2ZC-5@gated-at.bofh.it>
	 <3WWn1-2ZC-3@gated-at.bofh.it> <3WWwR-3hT-35@gated-at.bofh.it>
	 <3WWwU-3hT-49@gated-at.bofh.it> <3WWGj-3nm-3@gated-at.bofh.it>
	 <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it>
	 <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it>
	 <3Xagd-5Wb-1@gated-at.bofh.it>  <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114445923.4480.94.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Apr 2005 09:18:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-25 at 08:17, Bodo Eggert  wrote:
> Jan Hudec <bulb@ucw.cz> wrote:
> > On Mon, Apr 25, 2005 at 11:58:50 +0200, Miklos Szeredi wrote:
> 
> >> How do you bind mount it from a different namespace?  You _do_ need
> >> bind mount, since a new mount might require password input, etc...
> > 
> > Yes, I would need one thing from kernel. That one thing would be to
> > mount bind a directory handle, instead of path.
> > 
> > And if you wonder how I get the handle, that's what SCM_RIGHTS message
> > of unix-domain sockets is for.
> 
> You'll need something to get the FD from. What will that be if the mount
> was done from a subshell of the midnight commander run in a screen session?
> 
> What about X sessions? Open a xterm, do the mount and then do what to get
> the mount working for the programs run from the window manager?
> Relogin? The xterm with the mount will be gone.
> Use a daemon to keep an additional reference to the namespace? That's UGLY.
> 
> With attachable namespaces, the whole thing should be as simple as
> (pseudocode)
> mknamespace -p users/$UID # (like mkdir -p)
> setnamespace users/$UID   # (like cd)
> 
> Optionally, the namespaces and their private mounts might be scheduled to
> be removed if the last user is gone, or they need to be persistent,
> depending on the applicaton (e.g. ssh used as rexec or shared mounts).

Agreed.

I guess for this thread to make any progress, we need a set of coherent
requirements from FUSE team.

RP


