Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267191AbUBSBqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267441AbUBSBqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:46:47 -0500
Received: from dp.samba.org ([66.70.73.150]:5060 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267191AbUBSBqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:46:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16436.5487.319115.918117@samba.org>
Date: Thu, 19 Feb 2004 12:46:23 +1100
To: <hzhong@cisco.com>
Cc: "'Pascal Schmidt'" <der.eremit@email.de>, <linux-kernel@vger.kernel.org>
Subject: RE: UTF-8 and case-insensitivity
In-Reply-To: <011d01c3f684$d74539a0$613a47ab@amer.cisco.com>
References: <16436.2817.900018.285167@samba.org>
	<011d01c3f684$d74539a0$613a47ab@amer.cisco.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua,

 > Do you also require NFSD or other file daemons to do the same
 > case-insensitivity check?

no. That's the point of the per-process check. Only Samba needs to pay
the price.

 > Say you create a foo, how do you prevent NFSD from creating FOO?
 > What could you do about that?

You don't need to do anything in particular about it. I did explain
this earlier in this thread, but here goes again:

 * samba always tries the name exactly as given by the client. If that
   succeeds then we are done. 

 * if it doesn't find an exact match then it does a directory scan. It
   uses the first case-insensitive matching name it finds, or if it
   reaches the end of the directory then it concludes that the file
   doesn't exist.

So if FOO and foo both exist in the filesystem, and someone asks for
FoO then its pretty much random which one they get (ok, not exactly
random, but close enough for this argument). The thing is that just
making an arbitrary choice is a perfectly fine set of semantics. You
can't deal with this situation any more sanely, so don't even try.

well, actually, there is something you could do that we don't do. We
could have some special marker that distinguishes files created by
windows clients and files created by unix clients, and preferentially
return the one created by windows clients, I just don't think this is
worth doing. Nobody has even complained (within earshot of me anyway)
of the current "pick one" method.

Cheers, Tridge
