Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSIILJH>; Mon, 9 Sep 2002 07:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSIILJH>; Mon, 9 Sep 2002 07:09:07 -0400
Received: from pc-80-195-35-48-ed.blueyonder.co.uk ([80.195.35.48]:43137 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S317253AbSIILJG>; Mon, 9 Sep 2002 07:09:06 -0400
Date: Mon, 9 Sep 2002 12:13:48 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [RFC] On paging of kernel VM.
Message-ID: <20020909121348.B4855@redhat.com>
References: <2653.1031563253@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2653.1031563253@redhat.com>; from dwmw2@infradead.org on Mon, Sep 09, 2002 at 10:20:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 09, 2002 at 10:20:53AM +0100, David Woodhouse wrote:
> I think I'd like to introduce 'real' VMAs into kernel space, so that areas
> in the vmalloc range can have 'real' vm_ops and more to the point a real
> nopage function.

The alternative is a kmap-style mechanism for temporarily mapping
pages beyond physical memory on demand.  That would avoid the space
limits we have on vmalloc etc; there's only a few tens of MB of
address space we can use for mmap tricks in kernel space, so
persistent maps are seriously constrained if you've got a lot of flash
you want to map.

And with a kmap interface, your locking problems are much simpler ---
you can trap accesses at source and you don't have to go hunting ptes
to invalidate.

Cheers,
 Stephen
