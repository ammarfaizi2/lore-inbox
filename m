Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265390AbUFOJGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUFOJGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 05:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbUFOJGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 05:06:45 -0400
Received: from mail1.kontent.de ([81.88.34.36]:42455 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265383AbUFOJGf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 05:06:35 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Steve French <smfltc@us.ibm.com>
Subject: Re: upcalls from kernel code to user space daemons
Date: Tue, 15 Jun 2004 11:06:23 +0200
User-Agent: KMail/1.6.2
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
References: <1087236468.10367.27.camel@stevef95.austin.ibm.com> <200406142341.13340.oliver@neukum.org> <1087253679.10367.41.camel@stevef95.austin.ibm.com>
In-Reply-To: <1087253679.10367.41.camel@stevef95.austin.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406151106.31253.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 15. Juni 2004 00:54 schrieb Steve French:
> On Mon, 2004-06-14 at 16:40, Oliver Neukum wrote:
> > > > 1) getHostByName:  when the kernel cifs code detects a server crashes
> > > > and fails reconnecting the socket and the kernel code wants to see if
> > > > the hostname now has a new ip address.
> > 
> > Is that possible at all? It looks like that might deadlock in the page
> > out code path.
> > 
> 
> Yes - since an upcall (indirectly) to a different process while in write
> could cause writepage to write out memory to a mount - which could hang
> if on an already dead tcp session, this (reconnection - failover to new
> ip address if the server ip address changes after failure) may be too
> risky to do in the context of writepage, but there may be a way to keep
> refusing to do writepage while in the midst of this harder form of mount
> reconnection - which isn't likely to be any worse than not
> reconnecting.  Fortunately, most tcp reconnection cases are much
> simpler.

Well, unless you want to mlock() all libraries connected with name
resolution or code dns in kernel, you'll have to either fail the io, which
is bad, or use a fallback that is local. I suggest that you write the block
in question to a local disk (swap space?) and fire of a user space helper
asynchronously. That helper then could reestablish the connection.

	Regards
		Oliver
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzrwUbuJ1a+1Sn8oRAv2kAJ444nIrog/fnOPqlxTCAjAnaHtDUQCePe15
cGBjATSxNNRhCHGplhV703o=
=kjJe
-----END PGP SIGNATURE-----
