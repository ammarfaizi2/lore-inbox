Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVCKTbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVCKTbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVCKTaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:30:55 -0500
Received: from mail.murom.net ([213.177.124.17]:19587 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261402AbVCKT1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:27:54 -0500
Date: Fri, 11 Mar 2005 22:27:01 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: Patrick McHardy <kaber@trash.net>, netdev@oss.sgi.com,
       dtor_core@ameritech.net, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: Last night Linus bk - netfilter busted?
Message-Id: <20050311222701.216aba43.vsu@altlinux.ru>
In-Reply-To: <20050311105136.2a5e4ddc.davem@davemloft.net>
References: <200503110223.34461.dtor_core@ameritech.net>
	<4231A498.4020101@trash.net>
	<20050311105136.2a5e4ddc.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__11_Mar_2005_22_27_01_+0300_lu/w9Mn=IHAiPcq/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__11_Mar_2005_22_27_01_+0300_lu/w9Mn=IHAiPcq/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 11 Mar 2005 10:51:36 -0800 David S. Miller wrote:

> On Fri, 11 Mar 2005 15:00:56 +0100
> Patrick McHardy <kaber@trash.net> wrote:
> 
> > Works fine here. You could try if reverting one of these two patches
> > helps (second one only if its a SMP box).
> > 
> > ChangeSet@1.2010, 2005-03-09 20:28:17-08:00, bdschuym@pandora.be
> >    [NETFILTER]: Reduce call chain length in netfilter (take 2)
> 
> It's this change, I know it is, because Linus sees the same problem
> on his workstation.
> 
> You wouldn't happen to be seeing this problem on a PPC box would
> you?  Since Linus's machine is a PPC machine too, that would support
> my theory that this could be a compiler issue on that platform.
> 
> Damn, wait, Patrick, I think I know what's happening.  The iptables
> IPT_* verdicts are dependant upon the NF_* values, and they don't
> cope with Bart's changes I bet.  Can you figure out what the exact
> error would be?  This kind of issue would explain the looping inside
> of ipt_do_table(), wouldn't it?

This is not just some buggy code - that patch also breaks interfaces:

include/linux/netfilter_ipv4/ip_tables.h:
#define IPT_RETURN (-NF_MAX_VERDICT - 1)

And this value is visible in userspace.  Therefore we cannot modify
NF_MAX_VERDICT without breaking all existing iptables binaries.

--Signature=_Fri__11_Mar_2005_22_27_01_+0300_lu/w9Mn=IHAiPcq/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCMfEIW82GfkQfsqIRAlL4AJ40CH8yoWTNI8F/+isZHwf4CGqq4ACeOQWL
xiFAh8jgzFt1YDmzWnc8Oc8=
=RHYq
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Mar_2005_22_27_01_+0300_lu/w9Mn=IHAiPcq/--
