Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbUDQGPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 02:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUDQGPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 02:15:52 -0400
Received: from ozlabs.org ([203.10.76.45]:31675 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263678AbUDQGPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 02:15:49 -0400
Subject: Re: [CHECKER] Probable security holes in 2.6.5
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Wright <chrisw@osdl.org>
Cc: Ken Ashcraft <ken@coverity.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
In-Reply-To: <20040416122733.Z22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
	 <20040416122733.Z22989@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1082181408.2122.106.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 16:15:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 05:27, Chris Wright wrote:
> > [BUG]
> > /home/kash/linux/linux-2.6.5/kernel/module.c:1303:load_module:
> > ERROR:TAINT: 1283:1303:Using user value "((*hdr).e_shstrndx * 0)"
> > without first performing bounds checks

Yes, this is a special case. We've already checked CAP_SYS_MODULE, and
we only do trivial sanity checks for correct arch and truncated
modules.  This is by policy, since there are things we simply can't
check (like the code we're about to run!),

Hope that helps!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

