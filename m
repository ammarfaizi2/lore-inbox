Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUFLAVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUFLAVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbUFLAVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:21:45 -0400
Received: from zero.aec.at ([193.170.194.10]:9221 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264419AbUFLAVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:21:44 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>, akpm@osdl.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
 MAX_ORDER size
References: <263jX-5RZ-19@gated-at.bofh.it> <262nZ-56Z-5@gated-at.bofh.it>
	<263jX-5RZ-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 12 Jun 2004 02:21:28 +0200
In-Reply-To: <263jX-5RZ-17@gated-at.bofh.it> (Martin J. Bligh's message of
 "Sat, 12 Jun 2004 01:10:09 +0200")
Message-ID: <m3d645fwxj.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:
>
> Allocating the big-assed hashes out of bootmem seems much cleaner to me,
> at least ...

Machines big enough that such big hashes make sense are probably NUMA.
And on NUMA systems you imho should rather use node interleaving vmalloc(),
not a bit physical allocation on a specific node for these hashes. 
This will avoid memory controller hot spots and avoid the problem completely.
Likely it will perform better too.

-Andi

