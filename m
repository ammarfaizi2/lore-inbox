Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVDAJaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVDAJaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDAJ3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:29:34 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:64673 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262669AbVDAJ3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:29:21 -0500
Date: Fri, 1 Apr 2005 01:29:02 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-Id: <20050401012902.2fb1a992.pj@engr.sgi.com>
In-Reply-To: <20050401065955.GB26203@elte.hu>
References: <200503312214.j2VMEag23175@unix-os.sc.intel.com>
	<424C8956.7070108@yahoo.com.au>
	<20050331220526.3719ed7f.pj@engr.sgi.com>
	<20050401065955.GB26203@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It has to be made sure that H1+H2+H3 != H4+H5+H6,

Yeah - if you start trying to think about the general case here, the
combinations tend to explode on one.

I'm thinking we get off easy, because:

 1) Specific arch's can apply specific short cuts.

	My intuition was that any specific architecture, when it
	got down to specifics, could find enough ways to cheat
	so that it could get results quickly, that easily fit
	in a single 'distance' word, which results were 'close
	enough.'

 2) The bigger the system, the more uniform its core hardware.

	At least SGI's big iron systems are usually pretty
	uniform in the hardware that matters here.  We might mix
	two cpu speeds, or a couple of memory sizes.  Not much
	more, at least that I know of.  A 1024 NUMA cobbled
	together from a wide variety of parts would be a very
	strange beast indeed.

 3) Approximate results (aliasing at the edges) are ok.

	If the SN2 arch code ends up telling the cache latency
	initialization code that two cpus on opposite sides of
	a 1024 cpu system are the same distance as another such
	pair, even though they aren't exactly the same distance,
	does anyone care?  Not I.

So I think we've got plenty of opportunity to special case arch's,
plenty of headroom, and plenty of latitude to bend not break if we do
start to push the limits.

Think of that 64 bits as if it was floating point, not int.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
