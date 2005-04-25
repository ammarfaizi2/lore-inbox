Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVDYPij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVDYPij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVDYPhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:37:53 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:37269 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262664AbVDYPSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:18:44 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH] private mounts
To: Jan Hudec <bulb@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Reply-To: 7eggert@gmx.de
Date: Mon, 25 Apr 2005 17:17:35 +0200
References: <3WVU1-2GE-7@gated-at.bofh.it> <3WWn1-2ZC-5@gated-at.bofh.it> <3WWn1-2ZC-3@gated-at.bofh.it> <3WWwR-3hT-35@gated-at.bofh.it> <3WWwU-3hT-49@gated-at.bofh.it> <3WWGj-3nm-3@gated-at.bofh.it> <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it> <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec <bulb@ucw.cz> wrote:
> On Mon, Apr 25, 2005 at 11:58:50 +0200, Miklos Szeredi wrote:

>> How do you bind mount it from a different namespace?  You _do_ need
>> bind mount, since a new mount might require password input, etc...
> 
> Yes, I would need one thing from kernel. That one thing would be to
> mount bind a directory handle, instead of path.
> 
> And if you wonder how I get the handle, that's what SCM_RIGHTS message
> of unix-domain sockets is for.

You'll need something to get the FD from. What will that be if the mount
was done from a subshell of the midnight commander run in a screen session?

What about X sessions? Open a xterm, do the mount and then do what to get
the mount working for the programs run from the window manager?
Relogin? The xterm with the mount will be gone.
Use a daemon to keep an additional reference to the namespace? That's UGLY.

With attachable namespaces, the whole thing should be as simple as
(pseudocode)
mknamespace -p users/$UID # (like mkdir -p)
setnamespace users/$UID   # (like cd)

Optionally, the namespaces and their private mounts might be scheduled to
be removed if the last user is gone, or they need to be persistent,
depending on the applicaton (e.g. ssh used as rexec or shared mounts).
-- 
Remember, a retreating enemy is probably just falling back and regrouping. 

