Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbUB0Uyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbUB0Uyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:54:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:2497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263097AbUB0Uyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:54:37 -0500
Date: Fri, 27 Feb 2004 12:55:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040227125516.44a85ba4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0402271544520.1747-100000@chimarrao.boston.redhat.com>
References: <20040227122936.4c1be1fd.akpm@osdl.org>
	<Pine.LNX.4.44.0402271544520.1747-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> > Current 2.6 will write out nr_inactive>>DEF_PRIORITY pages,
> 
>  That may be a bit much on extremely huge systems, but that should
>  require no more than a little tweaking to fix.  Certainly no code
>  changes should be needed ...

hmm, with 4 million pages on the inactive list that's 1000 pages.  It might
be OK.

Bear in mind that under usual circumstances the direct-reclaim path will
refuse to block on request queue exhaustion so we might end up just
scanning past some dirty pages without starting I/O against them at all. 
End result: some jumbling up of the LRU order.  I suspect that's a
second-order problem though.  But hey, if we have a testcase, we can fix it!
