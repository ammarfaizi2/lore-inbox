Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVAKAU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVAKAU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVAKATz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:19:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:55262 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262551AbVAKAKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:10:10 -0500
Date: Mon, 10 Jan 2005 16:09:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave <dave.jiang@gmail.com>
cc: linux-kernel@vger.kernel.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
In-Reply-To: <8746466a050110153479954fd2@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org>
References: <8746466a050110153479954fd2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jan 2005, Dave wrote:
>
> After all said and done, the struct resource members start and end
> must support 64bit integer values in order to work. On a 64bit arch
> that would be fine since unsigned long is 64bit. However on a 32bit
> arch one must use unsigned long long to get 64bit.

We really should make "struct resource" use u64's. It's wrong even on x86, 
but we've never seen any real problems in practice, so we've had little 
reason to bother.

This has definitely come up before, maybe there's even some old patch 
floating around. It should be as easy as just fixing up "start/end" to be 
"u64" (and perhaps move them to the beginning of the struct to make sure 
packing is ok on all architectures), and fixing any fall-out.

		Linus
