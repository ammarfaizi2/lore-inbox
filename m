Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVIZX6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVIZX6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVIZX6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:58:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:26312 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750814AbVIZX6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:58:53 -0400
Message-Id: <200509262358.j8QNwM8N012009@death.nxdomain.ibm.com>
To: Florin Malita <fmalita@gmail.com>
cc: "Jason R. Martin" <nsxfreddy@gmail.com>, akpm@osdl.org,
       davem@davemloft.net, ctindel@users.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       bonding-devel@lists.sourceforge.net
Subject: Re: [PATCH] channel bonding: add support for device-indexed parameters 
In-Reply-To: Message from Florin Malita <fmalita@gmail.com> 
   of "Thu, 22 Sep 2005 09:16:08 EDT." <20050922091608.5ec2724c.fmalita@gmail.com> 
X-Mailer: MH-E 7.83; nmh 1.0.4; GNU Emacs 21.4.2
Date: Mon, 26 Sep 2005 16:58:22 -0700
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Malita <fmalita@gmail.com> wrote:

>On Wed, 21 Sep 2005 23:03:53 -0700
>"Jason R. Martin" <nsxfreddy@gmail.com> wrote:
>> Personally I think working to get the sysfs support finished in
>> bonding and stop relying on module parameters to configure bonds would
>> be better
[...]
>Agreed - that would be a better configuration interface, but I don't see
>why we couldn't support module parameter arrays too. Especially since
>the changes are minimal and don't break the ABI/ifenslave
>compatibility/etc.
>
>IMHO the "primary" semantics are completely broken right now and this
>is a possible fix for it.

	The distro provided network init scripts are, as far as I know,
really the main user of the bonding module parameters.  Right now, the
init scripts will generally load the bonding module multiple times when
creating multiple bonds with differing parameters.  This works tolerably
well, although I recall that some users have run afoul of Fedora Core
kernels that could or would not load any module multiple times.  I don't
know if that's still the case today.

	In any event, your patch does not provide enough flexibility to
allow the distro scripts to switch to it (it omits arp_ip_target), so
the init scripts will be unable to switch.  Given that, I'm not sure I
see the real value.

	Additionally, as Jason mentions, the sysfs API is looming, and
I'd frankly rather have the init scripts switch to sysfs as it provide
greater flexibility (in particular, it removes the dependency on bonding
being compiled as a module).

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
