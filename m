Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbTENMXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTENMXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:23:23 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:26641 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262008AbTENMXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:23:14 -0400
Date: Wed, 14 May 2003 13:35:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] PAG support, try #2
Message-ID: <20030514133557.A18431@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@warthog.cambridge.redhat.com>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20030514115653.A15202@infradead.org> <30949.1052913364@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <30949.1052913364@warthog.warthog>; from dhowells@warthog.cambridge.redhat.com on Wed, May 14, 2003 at 12:56:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 12:56:04PM +0100, David Howells wrote:
> > So do you have an estimate for the number of users here yet?
> > Adding two more slab caches that are unused for 99% of the users
> > might not be the best choice if there's no strong need.
> 
> There won't be many PAGs. Basically one per login session would be fairly
> typical, and possibly one per SUID program run at some later date.

I think using plain kmalloc is better then.

> > Inline but not static seems strange..
> 
> It's not without precedent within the kernel. The compiler is free to inline
> it, but must also emit an out-of-line copy. Thinking about it, it's probably
> not worth it... these calls aren't going to be called very often and so don't
> need to be optimised for every last ounce of speed.

Right, that's why I didn't complained very loud :)

> > We already discussed the coding style issue,
> 
> Well, the coding style is wrong here IMNSHO. Readability is preferable.

No.  Please follow the style guidelines.  If you say readability is
preferable you habve to say whos.  I always get stuck at code that
uses such strange constructs for example.

> > What protects vfspag->tokens?
> 
> Why does it need to be protected at that point? The PAG no longer has any
> references, and the tokens don't point back to it, and are in any case pinned
> by virtue of being on the list.

Okay.

> > Shouldn't vfs_pag_get hanlde a NULL argument instead?
> 
> Maybe. But then that's introducing a conditional branch that you can't avoid,
> even if you know it's going to succeed:-/

Then add an __vfs_pag_get that expects a non-NULL argument for those
cases where you know for sure it's not NULL.

