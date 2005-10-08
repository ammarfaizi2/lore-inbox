Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVJHKbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVJHKbU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 06:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVJHKbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 06:31:20 -0400
Received: from ns2.suse.de ([195.135.220.15]:62689 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750925AbVJHKbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 06:31:19 -0400
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Fix hotplug cpu on x86_64
Date: Sat, 8 Oct 2005 12:33:12 +0200
User-Agent: KMail/1.8
Cc: Brian Gerst <bgerst@didntduck.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <43437DEB.4080405@didntduck.org> <20051007095041.GK6642@verdi.suse.de> <20051008005016.GG5210@krispykreme>
In-Reply-To: <20051008005016.GG5210@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081233.12551.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 October 2005 02:50, Anton Blanchard wrote:
> Hi,
>
> > I also have a followon patch to avoid the extreme memory wastage
> > currently caused by hotplug CPUs (e.g. with NR_CPUS==128 you currently
> > lose 4MB of memory just for preallocated per CPU data). But that is
> > something for post 2.6.14.
>
> Im interested in doing that on ppc64 too. Are you currently only
> creating per cpu data areas for possible cpus? 

Yes. In fact that caused some of the problems that lead to the investigation 
of this.

> The generic code does 
> NR_CPUS worth, we should change that in 2.6.15.

You need to audit all architecture code then that fills up possible map.
(at least for the architectures that support CPU hotplug) 

With that change x86-64 could move back to the generic code BTW - 
the numa allocation in the architecture specific code doesn't work anymore 
because we usually find out about the cpu<->node mapping now only 
afterwards :/

-Andi
