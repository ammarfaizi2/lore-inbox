Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVDAS2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVDAS2w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVDAS1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:27:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:31148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262847AbVDASZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:25:53 -0500
Date: Fri, 1 Apr 2005 10:25:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: david@gibson.dropbear.id.au, linuxppc64-dev@ozlabs.org, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm5 1/3] perfctr: ppc64 arch hooks
Message-Id: <20050401102514.505ad059.akpm@osdl.org>
In-Reply-To: <16973.17085.561804.567539@alkaid.it.uu.se>
References: <200503312207.j2VM7YUI011924@alkaid.it.uu.se>
	<20050331151129.279b0618.akpm@osdl.org>
	<20050331234940.GA21676@localhost.localdomain>
	<20050331173302.3ec64e59.akpm@osdl.org>
	<16973.17085.561804.567539@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> In addition, there is one unresolved issue:
>  - A counter's value is represented by a 64-bit software sum,
>    a 32-bit start value containing the HW counter's value at the
>    start of the current time slice, and the current HW counter's value
>    (now). The actual value is computed as sum + (now - start).
>    This is reflected in the mmap()ed state, which contains a variable-
>    length { u32 map; u32 start; u64 sum; } pmc[] array.
>    This layout is very cache-efficient on current 32 and 64-bit CPUs,
>    but there is a _possible_ concern that it won't do on 10+ GHz CPUs.
>    So the question is, should we change it to use 64-bit start values
>    already now (and take more cache misses), or should that wait a few
>    years until it becomes a necessity (causing ABI change issues)?

I'd be inclined to make the change now, personally.  ABI changes are a pain
for everyone.

