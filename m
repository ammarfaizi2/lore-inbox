Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUEUSbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUEUSbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUEUSbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:31:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58509 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265966AbUEUSbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:31:14 -0400
Date: Fri, 21 May 2004 11:30:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: brettspamacct@fastclick.com
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       jbarnes@engr.sgi.com
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Message-ID: <79400000.1085164250@flay>
In-Reply-To: <40AE46F9.60600@fastclick.com>
References: <40AD52A4.3060607@fastclick.com> <273180000.1085121453@[10.10.2.4]> <40AE3BF5.5080804@fastclick.com> <74030000.1085161614@flay> <40AE46F9.60600@fastclick.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So could process 0 run on processor 0, allocating local to processor 0, then run on processor 1, allocating local to processor 1, this way allocating to both processors?  So over time process 0's allocations would be split up between both processors, defeating NUMA.  The homenode concept + explicit CPU pinning seems useful in that they allow you to take advantage of NUMA better. Without these two things the kernel will just allocate on the currently running CPU whatever that may be when in fact a preference must be given to a CPU at some point, hopefully early on in the life of the process, in order to take advantage of NUMA.


For any given situation, you can come up with a scheduler mod that improves
things. The problem is making something generic that works well in most
cases. 

I suggest: (1) read the archives. (2) Try implementing it if you still 
don't beleive me ;-) The main problem with the homenode scheduler is that
you're more likely to end up in a situation where you're running "off-node"
and allocating stuff back from your "home-node". This stuff isn't 
deterministic.

M.



