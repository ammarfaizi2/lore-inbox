Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUGBFiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUGBFiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 01:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266489AbUGBFiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 01:38:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:6786 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266484AbUGBFiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 01:38:20 -0400
Date: Thu, 1 Jul 2004 22:36:25 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-ID: <20040702053625.GC30548@kroah.com>
References: <20040629191046.Q21634@forte.austin.ibm.com> <16610.39955.554139.858593@cargo.ozlabs.ibm.com> <20040701160614.I21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701160614.I21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 04:06:14PM -0500, linas@austin.ibm.com wrote:
> How else could we do this?  I have never had to architect a kernel-to-user
> data communications interface, so I don't know what the alternatives
> are.  We could queue them up to some file in /proc, which user-space
> reads. 

No.

> Or maybe /sys instead ??

No.

> Maybe a stunt with sockets?

Yes, use netlink.

> Some new device in /dev/ that can be opened, read, closed?

No.

> How should the user space daemon indicate that its picked up the
> message and doesn't need it any more?

The kernel doesn't care.

> Write a msg number to a /proc file?

No way.

> Maybe each individual message should go in its own file, and user
> space just rm's that file after its fetched/saved the message.

Hm, that's a neat idea I don't think I've seen before.  But no :)

> I dunno, I think any one of these could be whipped up in a jiffy.
> Convincing the user-space to use the interface might be harder.

In summary, use syslog or netlink like the whole rest of the kernel
does.  Don't reinvent the wheel again, please.

thanks,

greg k-h
