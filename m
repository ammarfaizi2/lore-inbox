Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263240AbVGAGgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbVGAGgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 02:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbVGAGgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 02:36:41 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:782 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263240AbVGAGgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 02:36:39 -0400
To: akpm@osdl.org
CC: aia21@cam.ac.uk, arjan@infradead.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050630124622.7c041c0b.akpm@osdl.org> (message from Andrew
	Morton on Thu, 30 Jun 2005 12:46:22 -0700)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org>
Message-Id: <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 08:36:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, a few things:
> 
> - is there anything in the current implementation of the permission stuff
>   which might tie our hands if it is later reimplemented?  IOW: does the
>   current FUSE user interface in any way lock us into the current FUSE
>   implementation (fuse_allow_task())?

No.  This thing is above the userspace interface and completely
independent.  Either a task is allowed, and then the request goes
through to the interface.  Or if it's not, the request is stopped
right there, and never reaches the userspace interface.

> - the fuse mount options don't seem to be documented

True.  I'll send a patch (they are documented in the README of the
fuse distribution).

> - aren't we going to remove the nfs semi-server feature?

I leave the decision to you ;)  It's a separate independent patch
already (fuse-nfs-export.patch).

> - Frank points out that a user can send a sigstop to his own setuid(0)
>   task and he intimates that this could cause DoS problems with FUSE.  More
>   details needed please?

Will follow up in Franks answer.

> - I don't recall seeing an exhaustive investigation of how an
>   unprivileged user could use a FUSE mount to implement DoS attacks against
>   other users or against root.

Here's a description of a theoretical DoS scenario:

  http://marc.theaimsgroup.com/?l=linux-fsdevel&m=111522019516694&w=2

Miklos

