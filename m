Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267647AbUHJVYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbUHJVYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHJVYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:24:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8615 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267647AbUHJVYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:24:33 -0400
Date: Tue, 10 Aug 2004 17:16:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, Matt Domsch <Matt_Domsch@dell.com>,
       Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] reserved buffers only for PF_MEMALLOC
Message-ID: <20040810201652.GF13509@logos.cnet>
References: <Pine.LNX.4.44.0408101310580.7156-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408101310580.7156-100000@dhcp83-102.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 01:20:24PM -0400, Rik van Riel wrote:
> 
> The buffer allocation path in 2.4 has a long standing bug,
> where non-PF_MEMALLOC tasks can dig into the reserved pool
> in get_unused_buffer_head().  The following patch makes the
> reserved pool only accessible to PF_MEMALLOC tasks.
> 
> Other processes will loop in create_buffers() - the only
> function that calls get_unused_buffer_head() - and will call
> try_to_free_pages(GFP_NOIO), freeing any buffer heads that
> have become freeable due to IO completion.
> 
> Note that PF_MEMALLOC tasks will NOT do anything inside
> try_to_free_pages(), so it is needed that they are able to
> dig into the reserved buffer heads while other tasks are
> not.

Applied.

Matt, it would be really nice if you could run the workload
which triggers the deadlock on 2.4.27+Rik's patch.

Thanks guys!
