Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTJHOtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 10:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTJHOtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 10:49:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61312 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S261606AbTJHOti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 10:49:38 -0400
Date: Wed, 8 Oct 2003 15:49:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rik van Riel <riel@redhat.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Matt Domsch <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <Pine.LNX.4.44.0310071224200.31052-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0310081538170.3028-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Rik van Riel wrote:

> In the "better safe than sorry" category. Thanks go out to
> Matt Domsch and Robert Hentosh. A similar fix went into the
> 2.6 kernel. Please apply.

Seven atomic ops in a row, isn't that rather inefficient?
The 2.6 version clears those PG_flags all together in one
non-atomic op - but elsewhere, in prep_new_page.

Is there an actual test case for why 2.4 now needs this change?

If there's something trying to lock random pages, of course it would
be needed; or should that something be taking a reference instead?

Hugh

