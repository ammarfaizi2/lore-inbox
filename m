Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUHBK0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUHBK0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUHBK0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:26:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33504 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266487AbUHBKV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:21:56 -0400
Subject: Re: [brett@wrl.org: Stumped about where to post an Oops!]
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Brett Charbeneau <brett@wrl.org>, Stephen Tweedie <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040726133422.66c42143.akpm@osdl.org>
References: <20040724235219.GB2614@dmt.cyclades>
	 <20040726133422.66c42143.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1091442091.2125.11.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Aug 2004 11:21:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2004-07-26 at 21:34, Andrew Morton wrote:
> The 0x00040004 access address almost looks like some pointer-poisoning
> thing.  

It's the result of doing 

>    0:   39 72 04                  cmp    %esi,0x4(%edx)   <=====

when %edx is 0x00040000.

That looks to me like a single bit-flip in memory, and get_hash_table is
one of those functions that shows up in traces all the time when you've
got bad memory (it's one of the kernel's hottest functions for doing
list-walks over dynamically-allocated data structures.)

This footprint would definitely have me reaching for memtest86 as the
next step.  It certainly has all the hallmarks of a classic bit-flip bad
memory trace.

--Stephen

