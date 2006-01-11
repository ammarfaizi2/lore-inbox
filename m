Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbWAKXpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWAKXpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWAKXpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:45:36 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:40509 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932647AbWAKXpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:45:35 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
X-Message-Flag: Warning: May contain useful information
References: <1052904816d73f208585.1137019196@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 11 Jan 2006 15:45:31 -0800
In-Reply-To: <1052904816d73f208585.1137019196@eng-12.pathscale.com> (Bryan
 O'Sullivan's message of "Wed, 11 Jan 2006 14:39:56 -0800")
Message-ID: <adamzi2ib1g.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 11 Jan 2006 23:45:32.0545 (UTC) FILETIME=[1C695F10:01C61709]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +/**
 > + * memcpy32 - copy data, in units of 32 bits at a time
 > + * @dst: destination (must be 32-bit aligned)
 > + * @src: source (must be 32-bit aligned)
 > + * @count: number of 32-bit quantities to copy
 > + */
 > + 	.globl memcpy32
 > +memcpy32:
 > +	movl %edx,%ecx
 > +	shrl $1,%ecx
 > +	andl $1,%edx
 > +	rep movsq
 > +	movl %edx,%ecx
 > +	rep movsd
 > +	ret

Sorry to keep this going still further, but I'm still confused.  Why
can't this assembly just define __raw_memcpy_toio32() directly?  In
other words, Why do we need to introduce the indirection of having a
stub in C that calls the memcpy32 assembly routine?  Is there some
reason having to do with linker magic and weak symbols?  Could it be
solved by using gcc inline assembly rather than putting the assembly
in a .S file?

Also why does memcpy32() need to be exported?  There are no users
other than the x86_64 version of __raw_memcpy_toio32(), and memcpy32()
doesn't seem like an API we want to add to every arch anyway.

 - R.
