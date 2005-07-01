Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263241AbVGAGky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbVGAGky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 02:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbVGAGky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 02:40:54 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:2062 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263241AbVGAGks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 02:40:48 -0400
To: akpm@osdl.org
CC: aia21@cam.ac.uk, arjan@infradead.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050630130027.2ea25dfa.akpm@osdl.org> (message from Andrew
	Morton on Thu, 30 Jun 2005 13:00:27 -0700)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	<20050630124622.7c041c0b.akpm@osdl.org> <20050630130027.2ea25dfa.akpm@osdl.org>
Message-Id: <E1DoFCD-0002LZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 08:40:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  - I don't recall seeing an exhaustive investigation of how an
> >    unprivileged user could use a FUSE mount to implement DoS attacks against
> >    other users or against root.
> 
> You say
> 
>   "If a sysadmin trusts the users enough, or can ensure through other
>    measures, that system processes will never enter non-privileged mounts,
>    it can relax the last limitation with a "user_allow_other" config
>    option.  If this config option is set, the mounting user can add the
>    "allow_other" mount option which disables the check for other users'
>    processes."
> 
> What config option, where?

Currently that's a userspace issue.  There's a /etc/fuse.conf file,
with two options:

  max_mounts=X
  user_allow_other

The fusermount helper reads this file, and decides if passing the
'allow_other' mount option to the kernel is OK or not.

If we want unprivileged sys_mount() these will have to be checked in
kernel (set via sysfs, etc).

Miklos
