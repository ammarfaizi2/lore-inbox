Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVA0ADo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVA0ADo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVA0ADd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:03:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43172 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262392AbVAZUmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:42:47 -0500
Date: Wed, 26 Jan 2005 15:42:35 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andy Isaacson <adi@hexapodia.org>
cc: linux-os <linux-os@analogic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <20050126202639.GA10106@hexapodia.org>
Message-ID: <Pine.LNX.4.61.0501261541020.5677@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
 <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com> <20050126202639.GA10106@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Andy Isaacson wrote:

> Any particular thoughts as to how large a window should be reserved?
> SHLIB_BASE is a bit more than 1MB, which is fairly small in the grand
> scheme of things, but I guess I don't see why you'd reserve more than
> PAGE_SIZE (or maybe PAGE_SIZE*2, though I can't actually articulate why
> that seems like a good idea).

You also want to catch not-quite-NULL pointer dereferences,
where you dereference the member of a large struct or array,
but the array or struct pointer itself was NULL.

Eg. you try to fetch the 100,000th from an array, but you
got passed a NULL array pointer.  Getting a segfault is
much, much better than corrupting data.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
