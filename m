Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVAEXIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVAEXIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAEXIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:08:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12519 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262641AbVAEXIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:08:15 -0500
Date: Wed, 5 Jan 2005 18:32:18 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050105203217.GB17265@logos.cnet>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com> <20050105020859.3192a298.akpm@osdl.org> <20050105180651.GD4597@dualathlon.random> <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com> <20050105174934.GC15739@logos.cnet> <20050105134457.03aca488.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105134457.03aca488.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The caller would need to wait on all the zones which can satisfy the
> caller's allocation request.  A bit messy, although not rocket science. 
> One would have to be careful to avoid additional CPU consumption due to
> delivery of multiple wakeups at each I/O completion.
> 
> We should be able to demonstrate that such a change really fixes some
> problem though.  Otherwise, why bother?

Agreed. The current scheme works well enough, we dont have spurious OOM kills
anymore, which is the only "problem" such change ought to fix. 

You might have performance increase in some situations I believe (because you 
have perzone waitqueues), but I agree its does not seem to be worth the
trouble.
