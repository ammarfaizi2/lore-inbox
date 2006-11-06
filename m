Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753791AbWKFUkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbWKFUkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbWKFUkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:40:17 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:47304 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S1753787AbWKFUkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:40:15 -0500
Date: Mon, 06 Nov 2006 21:31:47 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
 that offer x86 compatability
In-reply-to: <20061106202313.GA691@wohnheim.fh-wedel.de>
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <454F9BB3.6020004@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
 <20061106182222.GO27140@parisc-linux.org>
 <1162838843.12129.8.camel@dantu.rdu.redhat.com>
 <20061106202313.GA691@wohnheim.fh-wedel.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel a écrit :
> On Mon, 6 November 2006 13:47:23 -0500, Jeff Layton wrote:
>> On Mon, 2006-11-06 at 11:22 -0700, Matthew Wilcox wrote:
>>> On Mon, Nov 06, 2006 at 01:12:05PM -0500, Jeff Layton wrote:
>>>> The attached patch remedies this by making the last_inode counter be an
>>>> unsigned int on kernels that have ia32 compatability mode enabled.
>>> ... and this only happens on ia64/x86_64 kernels, not sparc64, ppc64,
>>> s390x, parisc64 or mips64?
>> Here's a new (untested) patch that replaces the ia32 specific
>> compatability mode defines with CONFIG_COMPAT, as suggested by Matthew.
> 
> While you're at it, how about making last_ino per-sb instead of
> system-wide?  ino collisions after a wrap are just as bad as inos
> beyond 32bit.  And this should be a fairly simple method to reduce the
> risk.
> 
> Also, do you have a testcase that can actually force the wrap?

while (1) {
	int fd[2];
	pipe(fd);
	close(fd[0]);
	close(fd[1]);
}


