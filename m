Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTDUSXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTDUSXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:23:46 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:25098 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261844AbTDUSXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:23:44 -0400
Date: Mon, 21 Apr 2003 19:35:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421193546.A10287@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	"David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <20030421191013.A9655@infradead.org> <Pine.LNX.4.44.0304211117260.3101-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304211117260.3101-100000@home.transmeta.com>; from torvalds@transmeta.com on Mon, Apr 21, 2003 at 11:22:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 11:22:51AM -0700, Linus Torvalds wrote:
> Actually, we still do it for both block _and_ character devices.
> 
> Look at "nfs*xdr.c" to see what's up.

Just think s/major/dev_lo/g and s/minor/dev_hi/g.  This is the
represantation for a legacy protocol.  Just because fat thinks
of a filename as 8+3 Linux filenames don't have to be that format.

> The fact that the kernel internally has generalized it away doesn't 
> matter. Any kernel virtualization of the number still _has_ to account for 
> the fact that it's a real thing.
> 
> Put another way:
> 
> 	0x0000000000000101
> 
> _has_ to open the same file as
> 
> 	0x0000000100000001
> 
> because otherwise the kernel virtualization is broken (since they will
> look the same to a user, and they will end up being written to disk the
> same way).

Umm, no.  You're far to major/minor biased to realized live get a lot
sipler for use if we don't do any complicated mapping of old dev_t
to the larger dev_t.  With the proper ranges we can just map it
numerically 1:1 to the new dev_t.  Yes, that means it's all in one
new "major".  But who cares?

