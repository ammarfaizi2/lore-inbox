Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTEGGCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTEGGCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:02:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38381 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262820AbTEGGCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:02:17 -0400
Date: Tue, 06 May 2003 22:07:14 -0700 (PDT)
Message-Id: <20030506.220714.35679546.davem@redhat.com>
To: hch@infradead.org
Cc: dwmw2@infradead.org, thomas@horsten.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507062613.A5318@infradead.org>
References: <1052255946.7532.66.camel@imladris.demon.co.uk>
	<20030506.200638.78728404.davem@redhat.com>
	<20030507062613.A5318@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Wed, 7 May 2003 06:26:13 +0100
   
   Look at e.g. the debian and redhat packages of ipsec-tools:  they all
   have their local copy of theses headers.
   
You merely support my point, the situation is rediculious.

Why don't we copy headers into every app package that wants to use
certain interfaces?

#ifdef SARCASM
Yeah, that sounds like an excellent idea.
#endif /* SARCASM */

This doesn't even consider the case where the ipsec-tools copy of the
headers becomes out of date with the kernel copy.  This isn't a
theoretical issue, this problem is real.

For example, I just changed the values of a few SADB_EALG_* values in
pfkeyv2.h.  Now ipsec-tools is effectively broken.  Oops, when will
the copy in ipsec-tools get updated?

What about applications, ie. normal ones, that want to pass IPSEC
policies into the kernel via the socket options we have that allows
per-socket IPSEC rules to be specified?  The copy in ipsec-tools
doesn't help them at all.

All of this is madness, and every suggestion to copy the headers
all over the place is a non-solution.
