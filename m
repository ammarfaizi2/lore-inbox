Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTJHO75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 10:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTJHO74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 10:59:56 -0400
Received: from rth.ninka.net ([216.101.162.244]:63392 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261602AbTJHO7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 10:59:55 -0400
Date: Wed, 8 Oct 2003 07:57:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: riel@redhat.com, marcelo.tosatti@cyclades.com, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] page->flags corruption fix
Message-Id: <20031008075700.553e89f9.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310081538170.3028-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0310071224200.31052-100000@chimarrao.boston.redhat.com>
	<Pine.LNX.4.44.0310081538170.3028-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003 15:49:34 +0100 (BST)
Hugh Dickins <hugh@veritas.com> wrote:

> Seven atomic ops in a row, isn't that rather inefficient?
> The 2.6 version clears those PG_flags all together in one
> non-atomic op - but elsewhere, in prep_new_page.
> 
> Is there an actual test case for why 2.4 now needs this change?

It's not a new bug, we've always had this bug in 2.4.x

There is so much code that does atomic bit ops asynchronously on
page->flags that it is therefore not safe for any context to make
non-atomic changes to the values there.

The patch Rik posted is the safest solution to this bug.  If you
want to make it faster by creating a "mutliple bit" set of bitops
go right ahead, but be nice enough to make sure every single architecture
has an implementation before suggesting that the change gets merged
into 2.4.x
