Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269171AbUJKSfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269171AbUJKSfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269214AbUJKSeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:34:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269171AbUJKSco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:32:44 -0400
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jeff Moyer <jmoyer@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20041007101213.GC10234@logos.cnet>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	 <20041005112752.GA21094@logos.cnet>
	 <16739.61314.102521.128577@segfault.boston.redhat.com>
	 <20041006120158.GA8024@logos.cnet>
	 <1097119895.4339.12.camel@orbit.scot.redhat.com>
	 <20041007101213.GC10234@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1097519553.2128.115.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Oct 2004 19:32:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-10-07 at 11:12, Marcelo Tosatti wrote:

> Oh yes, theres also the indirect blocks which we might need to read from
> disk.

Right.

> Now the question is, how strict should the O_NONBLOCK implementation be 
> in reference to "not blocking" ?

Well, I suspect that depends on the application.  But if you've got an
app that really wants to make sure its hot path is as fast as possible
(eg. a high-throughput server multiplexing disk IO and networking
through a single event loop), then ideally the app would want to punt
any blocking disk IO to another thread.

So it's a matter of significant extra programing for a small extra
reduction in app blocking potential.

I think it's worth getting this right in the long term, though.  Getting
readahead of indirect blocks right has other benefits too --- eg. we may
be able to fix the situation where we end up trying to read indirect
blocks before we've even submitted the IO for the previous data blocks,
breaking the IO pipeline ordering.

--Stephen

