Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWCNP3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWCNP3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWCNP3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:29:54 -0500
Received: from gold.veritas.com ([143.127.12.110]:57994 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751781AbWCNP3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:29:53 -0500
X-IronPort-AV: i="4.02,191,1139212800"; 
   d="scan'208"; a="57151823:sNHT30100048"
Date: Tue, 14 Mar 2006 15:30:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Clayton <andrew@rootshell.co.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-git[12] spontaneous reboots on x86_64
In-Reply-To: <1142337319.4412.2.camel@zeus.pccl.info>
Message-ID: <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com>
References: <1142337319.4412.2.camel@zeus.pccl.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Mar 2006 15:29:53.0395 (UTC) FILETIME=[241BB430:01C6477C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Andrew Clayton wrote:
> 
> With the above kernels I am seeing spontaneous system reboots. Nothing
> seems to get logged anywhere and when I've been at the console I haven't
> noticed any oops or anything before the machine resets.
> 
> This was first triggered by accessing a usb key drive thing, this
> happened a couple of times and then this morning while investigating
> some more it happened as I was exiting my X session.  
> 
> The machine is an AMD Athlon(tm) 64 Processor 3500+ (Single processor,
> single core), with 1GB RAM. GCC is gcc (GCC) 4.0.2 20051125 (Red Hat
> 4.0.2-8) from Fedora Core 4
> 
> 
> 2.6.16-rc6 is working fine.
> 
> 
> The following change looked an obvious candidate
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c33d4568aca9028a22857f94f5e0850012b6444b
> 
> So I took a 2.6.16-rc6-git2 tree and reverted arch/x86_64/kernel/entry.S
> to the one in 2.6.16-rc6 and so far (35 minutes) no problems.

Yep, that one's a turkey, definitely something for Linus to revert.

Seeing your report, I gave 2.6.16-rc6-git2 a try at concurrent kernel
builds on dual HT EM64T: collapsed in all kinds of weird page table
corruption or slab corruption within minutes, three boots in a row.
Backed out that patch and it's going fine for half an hour now.

Andi, if you've a replacement patch you'd like everybody to test,
please post: I for one will surely give it a try.

Hugh
