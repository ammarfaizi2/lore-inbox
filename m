Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUI1NbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUI1NbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUI1NbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:31:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:7082 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267708AbUI1NbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:31:06 -0400
Date: Tue, 28 Sep 2004 06:29:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: jlan@engr.sgi.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, csa@oss.sgi.com, akpm@osdl.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       corliss@digitalmages.com
Subject: Re: [PATCH 2.6.9-rc2 2/2] enhanced MM accounting data collection
Message-Id: <20040928062949.2ab2249e.pj@sgi.com>
In-Reply-To: <20040928113858.GA1090@lnx-holt.americas.sgi.com>
References: <4158956F.3030706@engr.sgi.com>
	<41589927.5080803@engr.sgi.com>
	<20040928023350.611c84d8.pj@sgi.com>
	<20040928113858.GA1090@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin wrote:
> I have benchmarked these hooks a very long time ago.  The number and
> location has not changed appreciably.

These results seem reasonable ... thanks.

> The size was never very noticable.

But would the time cost of being out of line be noticable either?
Actually, being out of line might be a tick faster, if it reduced by a
cache line what was needed for a common execution path.

> Originally, there was a 5% decrease in performance with the writing of
> the accounting data.  There was another unfortunate side effect that some
> of the CSA metrics became much worse.  This problem was later identified
> and fixed. 

Is there any non-trivial risk that some other "unfortunate side affect"
exists today, that we'd find on benchmarking?

I'm not sure its worth benchmarking again, but I slightly suspect it is,
and if benchmarking was done, I'd do it with these calls both inline and
out of line, to see what affect that had on runtime.  If no affect on
runtime, I'd tend toward the out of line calls - at least saving a
little kernel text space.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
