Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUDOWHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUDOWHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:07:31 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:19676 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262226AbUDOWHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:07:30 -0400
Date: Thu, 15 Apr 2004 15:07:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lazy NUMA sorting?
Message-ID: <225720000.1082066846@flay>
In-Reply-To: <407EFAAB.7060307@techsource.com>
References: <407EFAAB.7060307@techsource.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, I understand that the 2.6 SMP balancer redistributes workload on a periodic basis.  Once every second or something, it migrates processes.
> 
> A NUMA system would have to do something similar, where if there is a page which is referenced by only one process, and the page is located on the "wrong" node, it could be migrated.  This could be done gradually by a periodic background process.  Is this already how it works?

We don't do page migration. It has proved extraordinarily hard to know when
to migrate pages correctly ... in conjunction with the cross-node movement
of tasks.

> Also, if a page is being referenced by multiple nodes, the same background process could make mirror copies.  (Age of page would be an important consideration here so moves don't happen for short-lived pages.)

We can do that for read-only mappings and kernel text already. Dave Hansen
did a patch for the read-only mappings, though I need to update it to the
latest kernel tree.

M.

