Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVLNMRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVLNMRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVLNMRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:17:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932500AbVLNMRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:17:44 -0500
Date: Wed, 14 Dec 2005 12:17:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org,
       dhowells@redhat.com, cfriesen@nortel.com, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051214121739.GA20587@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	arjan@infradead.org, dhowells@redhat.com, cfriesen@nortel.com,
	torvalds@osdl.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214033536.05183668.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 03:35:36AM -0800, Andrew Morton wrote:
> 
> Could someone please remind me why we're even discussing this, given that
> mutex_down() is slightly more costly than current down(), and mutex_up() is
> appreciably more costly than current up()?

That's a good question.  The new mutex implementation here is big regression
to what we have right now.  What I had in mind when brainstorming something
like this would be to have a slow-path pure C semaphore implementation that
is cross-platform, and keep the current semaphore code as mutex.  Once that
is done the mutex code could be optimized further because it doesn't need to
deal with the broader uses of the semaphore, and we could add lots of useful
debugging.

The current patchkit is far from that.

What might be more useful as a start is to implement a mutex type ontop
of the current semaphore that has lots of additional checks for the DEBUG
build so we have nice diagnostics.  Once we have all users of mutex semantics
using that API we can change the underlying implementation to whatever we want.
