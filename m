Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946056AbWJ0A2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946056AbWJ0A2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 20:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946060AbWJ0A2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 20:28:53 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:19355 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1946056AbWJ0A2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 20:28:52 -0400
Date: Fri, 27 Oct 2006 10:28:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
       paulus@samba.org, ak@suse.de, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
Message-Id: <20061027102834.5db261af.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
	<20061026133305.b0db54e6.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.3.0beta3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__27_Oct_2006_10_28_34_+1000_=/0fdBc0o0p1Ku9J"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__27_Oct_2006_10_28_34_+1000_=/0fdBc0o0p1Ku9J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2006 12:00:30 -0700 (PDT) Christoph Lameter <clameter@sgi.com> wrote:
>
> On Thu, 26 Oct 2006, Stephen Rothwell wrote:
>
> > This is needed on bigendian 64bit architectures. The obvious way to do
> > this (taking the other compat_ routines in this file as examples) is to
> > use compat_alloc_user_space and copy the bitmasks back there, however you
> > cannot call compat_alloc_user_space twice for a single system call and
> > this method saves two copies of the bitmasks.
>
> Well this means also that sys_mbind and sys_set_mempolicy are also
> broken because these functions also use get_nodes().

No they aren't because they have compat routines that convert the bitmaps
before calling the "normal" syscall.  They, importantly, only use
compat_alloc_user_space once each.

> Fixing get_nodes() to do the proper thing would fix all of these
> without having to touch sys_migrate_pages or creating a compat_ function
> (which usually is placed in kernel/compat.c)

You need the compat_ version of the syscalls to know if you were called
from a 32bit application in order to know if you may need to fixup the
bitmaps that are passed from/to user mode.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Oct_2006_10_28_34_+1000_=/0fdBc0o0p1Ku9J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFQVK3FdBgD/zoJvwRApyiAJ9bErnB/elH+cfVrgRfzDqE8JqcsQCfbE3K
kO4zt/MP8zf3yO2rBQ/L1Eg=
=gkUC
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Oct_2006_10_28_34_+1000_=/0fdBc0o0p1Ku9J--
