Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUCXUH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUCXUFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:05:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261179AbUCXUEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:04:46 -0500
Date: Wed, 24 Mar 2004 20:04:44 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: rudi@lambda-computing.de, linux-kernel@vger.kernel.org,
       jamie@shareable.org, tridge@samba.org, torvalds@osdl.org,
       alexl@redhat.com, rml@ximian.com
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
Message-ID: <20040324200443.GS31500@parcelfarce.linux.theplanet.co.uk>
References: <4061986E.6020208@gamemakers.de> <1080142815.8108.90.camel@localhost.localdomain> <1080146269.23224.5.camel@vertex> <4061BD2E.2060900@gamemakers.de> <1080158032.30769.13.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080158032.30769.13.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 02:53:52PM -0500, John McCutchan wrote:
> - When user passes fd to kernel to watch, the kernel takes over this
>   fd, making it invalid in user space ( I know this is a terrible hack)
>   then when a volume is unmounted, the kernel can walk the list of 
>   open fd's using for notifacation and close them, before attempting to
>   unmount.

And if umount fails?  BTW, _which_ umount?  The sucker can be present
in more than one place in more than one namespace.
 
> - The user passes a path to the kernel, the kernel does some work so
>   that it can track anything to do with that path, and again when
>   an unmount is called the kernel cleans up anything used for
>   notification. 

Ditto.

> Both of these ideas are similar, does anyone have a better idea?

"Doctor, It Hurts When I Do It"

Seriously, dnotify sucks in a lot of ways, starting with the basic
premise - that userland can do notification-based maintainig of directory
tree image.  It's racy by definition, so any attempts to use it for
"security improvements" are scam.  Which leaves us with file manglers
and their ilk.

Note that any attempts to trace "aliases" in userland are hopelessly racy;
that mounting/unmounting doesn't even show on the radar; that different
users can see different parts of tree or, while we are at it, completely
different trees; that this crap is a DDoS on a server that exports any
sort of network filesystem to many clients - *especially* if you want
notifications on the entire tree.

IOW, idea is fundamentally flawed and IMO the real fix is to try and figure
out a decent UI that would provide what file managers are really used for.
