Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbTEGMA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 08:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTEGMA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 08:00:57 -0400
Received: from holomorphy.com ([66.224.33.161]:62862 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263184AbTEGMA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 08:00:56 -0400
Date: Wed, 7 May 2003 05:13:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Paul Mackerras <paulus@samba.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030507121319.GA8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Paul Mackerras <paulus@samba.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com,
	linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20030506014745.02508f0d.akpm@digeo.com> <20030507023126.12F702C019@lists.samba.org> <20030507024135.GW8978@holomorphy.com> <16056.34210.319959.255815@argo.ozlabs.ibm.com> <20030507042250.GX8978@holomorphy.com> <16056.37397.694764.303333@argo.ozlabs.ibm.com> <20030507051901.GY8978@holomorphy.com> <4960000.1052280622@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4960000.1052280622@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was stripped from:
>> Not as bad as it initially sounds; on non-PAE i386, it's 4KB and would
>> hurt. On PAE i386, it's 32B and can be shoehorned, say, in thread_info.
>> Then the rest is just a per-cpu kernel pmd and properly handling vmalloc
>> faults (which are already handled properly for non-PAE vmallocspace).
>> There might be other reasons to do it, like reducing the virtualspace
>> overhead of the atomic kmap area, but it's not really time yet.

On Tue, May 06, 2003 at 09:10:24PM -0700, Martin J. Bligh wrote:
> Even if the space isn't a problem, having a full TLB flush on thread 
> context switch sounds sucky. Per-node is sufficient for most things,
> and is much cheaper (update on cross-node migrate). 

The scheme described requires no TLB flushing or pgd switching when
switching between threads in the same mm. Providing a true per-thread
mapping, like one for the stack, might require an invlpg or two at each
switch, but that wasn't mentioned here.


-- wli
