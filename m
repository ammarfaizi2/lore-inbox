Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWAEMWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWAEMWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbWAEMWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:22:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58547 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752174AbWAEMWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:22:40 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Matt Mackall <mpm@selenic.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
In-Reply-To: <43BC716A.5080204@mbligh.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com>
	 <43BC716A.5080204@mbligh.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 13:19:12 +0100
Message-Id: <1136463553.2920.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What would be nice to do is pack all the frequently used code together 
> in close proximity. Would probably have much larger effects with 
> userspace code, esp where we touch disk (which is more page-size 
> granularity), but is probably worth doing with kernel code too (where 
> AFAICS we'd only get cacheline granular).

in the kernel we could make a .text.rare section for functions, which we
could annotate with __rare.
The other way around, __fastpath or whatever is a bad idea, everyone
will consider all of their own functions as such (just like inline ;)...
go-fast-stripes all the way :-(


obvious candidates for __rare are
* pm suspend/resume functions
* error handling functions
* initialization stuff (including mount time stuff for filesystems,
  and hardware setup for drivers)

I wonder if gcc can be convinced to put all unlikely() code sections
into a .text.rare as well, that'd be really cool.



