Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVG1IgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVG1IgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVG1IgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:36:05 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:53522 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261335AbVG1IfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:35:13 -0400
To: linuxram@us.ibm.com
CC: mathurav@us.ibm.com, mike@waychison.com, janak@us.ibm.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <1122496239.5037.104.camel@localhost> (message from Ram Pai on
	Wed, 27 Jul 2005 13:30:39 -0700)
Subject: Re: [PATCH 3/7] shared subtree
References: <20050725224417.501066000@localhost>
	 <20050725225908.031752000@localhost>
	 <E1DxrL8-0001kG-00@dorka.pomaz.szeredi.hu> <1122496239.5037.104.camel@localhost>
Message-Id: <E1Dy3qc-0002kp-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Jul 2005 10:34:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes we agreed on returning EINVAL when a directory is attempted to made
> shared/private/slave/unclonnable.   But this is a different case.
> 
> lets say  /mnt is a mountpoint having a vfsmount (say A). 
> now if you run 
> 	mount --bind /mnt/a  /tmp
> this operation succeeds currently. 
> 
> now lets say /mnt is a mountpoint having a vfsmount which is shared.
> now if you run
> 	mount --bind /mnt/a /tmp
> 
> we now have a mount at /tmp which gets propogation from mounts under
> /mnt/a. right?

Yes.

> but /mnt/a is not a mountpoint at all.  if we need to track and
> propogate mounts/unmounts under /tmp or /mnt/a we need to have a mount
> at /mnt/a.

I don't think we do.  You can just check at propagation time if the
propagated mountpoint is visible in the destination mount or not.
Just like --rbind checks whether children mounts are below or above
the to-be-bound directory.

Miklos
