Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWGDNRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWGDNRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWGDNRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:17:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44179 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932241AbWGDNRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:17:31 -0400
Subject: Re: R/W semaphore changes
From: Arjan van de Ven <arjan@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <15345.1152018339@warthog.cambridge.redhat.com>
References: <1152017562.3109.48.camel@laptopd505.fenrus.org>
	 <14683.1152017262@warthog.cambridge.redhat.com>
	 <15345.1152018339@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 15:17:25 +0200
Message-Id: <1152019045.3109.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 14:05 +0100, David Howells wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > > Please, please, please don't.  R/W semaphores are _not_ permitted to nest.
> > 
> > yet they do in places, there where there is a natural hierarchy..
> 
> Where?  I believe the mm used to but no longer does.
> 
> They still aren't allowed to.  Consider:
> 
> 	CPU 1			CPU 2
> 	=======================	=======================
> 	-->down_read(&A);
> 	<--down_read(&A);
> 				-->down_write(&A);
> 				   --- SLEEPING ---
> 	-->down_read(&A);
> 	   --- DEADLOCKED ---

you mean recursion, while nesting != recursion!
(for examples of nesting see the general lockdep documentation)
With nesting we mean

down_read(&A);
down_read(&B);

where A and B are a similar lock but not the same exact instance (for
example two inode locks of different inodes)


