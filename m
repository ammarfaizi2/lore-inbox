Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVBOPti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVBOPti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVBOPti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:49:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20658 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261764AbVBOPtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:49:36 -0500
Date: Tue, 15 Feb 2005 07:49:06 -0800
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: haveblue@us.ibm.com, holt@sgi.com, raybry@sgi.com, taka@valinux.co.jp,
       hugh@veritas.com, akpm@osdl.org, marcello@cyclades.com,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
 sys_page_migrate
Message-Id: <20050215074906.01439d4e.pj@sgi.com>
In-Reply-To: <20050214220148.GA11832@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	<1108242262.6154.39.camel@localhost>
	<20050214135221.GA20511@lnx-holt.americas.sgi.com>
	<1108407043.6154.49.camel@localhost>
	<20050214220148.GA11832@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin wrote:
> Then how do you handle overlapping nodes.  If I am doing a 5->4, 4->3,
> 3->2, 2->1 shift ...

Then do the shifts in the other order, first 2->1, then 3->2, ...

So now you ask, what if you are doing a rotation?  Use a temporary
node: 2->tmp, 3->2, ..., N->(N-1), tmp->N.

So now you ask, what if you are doing a rotation involving _all_
nodes, and have nothing you can use as a temporary node?

Argh I say ... would anyone really do that?  Or perhaps it makes
sense to have the system call take a virtual address range (and
hence a pid).  In which case, you can do one page at a time, if
need be, and get any foolhardy migration possible.

Or perhaps some integration with Andi's mbind/mempolicy make sense.
I'm not quite following Andi's comments on this, so I can't say
one way or the other if this is good.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
