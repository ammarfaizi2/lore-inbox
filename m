Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbTEGGOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTEGGOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:14:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44525 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262890AbTEGGOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:14:03 -0400
Date: Tue, 06 May 2003 22:19:00 -0700 (PDT)
Message-Id: <20030506.221900.38693097.davem@redhat.com>
To: hch@infradead.org
Cc: dwmw2@infradead.org, thomas@horsten.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507072002.A7424@infradead.org>
References: <20030507062613.A5318@infradead.org>
	<20030506.220714.35679546.davem@redhat.com>
	<20030507072002.A7424@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Wed, 7 May 2003 07:20:02 +0100

   On Tue, May 06, 2003 at 10:07:14PM -0700, David S. Miller wrote:
   > For example, I just changed the values of a few SADB_EALG_* values in
   > pfkeyv2.h.  Now ipsec-tools is effectively broken.  Oops, when will
   > the copy in ipsec-tools get updated?
   
   You just broke the userland ABI which must not happen.  at all.  That's
   why userland having older headers is fine.
   
Wrong, the ABI in the 2.5.x IPSEC stuff is not cast in
stone yet.

What about if I extend stuff without breaking the ABI?
How do apps get at the new features?

   That's why we want the glibc-kernheader package.  Or even better
   a package of headers that can be used by the kernel and userland,
   but this would require people to properly sort out kernel header
   functionality like internal structures and prototypes/inlines from
   the actual ABI-relevant contents.  The networking headers currently
   are very bad on this.
   
Yes, this is one way to deal with it.

Actually, if you look, things like include/linux/xfrm.h are excellent
examples of userland compatible kernel headers :-)
