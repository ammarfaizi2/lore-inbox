Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269303AbUJKVwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269303AbUJKVwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUJKVvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:51:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:408 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269298AbUJKVtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:49:40 -0400
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <16746.55283.192591.718383@segfault.boston.redhat.com>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	 <20041005112752.GA21094@logos.cnet>
	 <16739.61314.102521.128577@segfault.boston.redhat.com>
	 <20041006120158.GA8024@logos.cnet>
	 <1097119895.4339.12.camel@orbit.scot.redhat.com>
	 <20041007101213.GC10234@logos.cnet>
	 <1097519553.2128.115.camel@sisko.scot.redhat.com>
	 <16746.55283.192591.718383@segfault.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1097531370.2128.356.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Oct 2004 22:49:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2004-10-11 at 19:58, Jeff Moyer wrote:

> sct> I think it's worth getting this right in the long term, though.
> sct> Getting readahead of indirect blocks right has other benefits too ---
> sct> eg. we may be able to fix the situation where we end up trying to read
> sct> indirect blocks before we've even submitted the IO for the previous
> sct> data blocks, breaking the IO pipeline ordering.
> 
> So for the short term, are you an advocate of the patch posted?

In the short term, can't we just disable readahead for O_NONBLOCK?  That
has true non-blocking semantics --- if the data is already available we
return it, but if not, it's up to somebody else to retrieve it.

That's exactly what you want if you're genuinely trying to avoid
blocking at all costs on a really hot event loop, and the semantics seem
to make sense to me.  It's not that different from the networking case
where no amount of read() on a non-blocking fd will get you more data
unless there's another process somewhere filling the stream.

--Stephen

