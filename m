Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130286AbRBAKN7>; Thu, 1 Feb 2001 05:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130122AbRBAKNj>; Thu, 1 Feb 2001 05:13:39 -0500
Received: from slc26.modem.xmission.com ([166.70.9.26]:15378 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130035AbRBAKNf>; Thu, 1 Feb 2001 05:13:35 -0500
To: David Gould <dg@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
In-Reply-To: <Pine.LNX.4.21.0101310636530.16408-100000@freak.distro.conectiva> <m18znrcxx7.fsf@frodo.biederman.org> <20010131162424.E9053@archimedes.oak.suse.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2001 00:41:12 -0700
In-Reply-To: David Gould's message of "Wed, 31 Jan 2001 16:24:24 -0800"
Message-ID: <m14ryedf53.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gould <dg@suse.com> writes:

> Hmmm, arguably reading pages we do not want is a mistake. I should think that
> if a big performance win is required to justify a design choice, it should
> be especially required to show such a win for doing something that on its
> face is wrong.

The case for files and has already been justified.   
The performance gain of reading pages that are contiguous on disk has
been justified. 
The only problem thing that has not been shown is that swap pages that
are used together are located near each other in swap.

As for design choices simplicity, maintainability and
comprehensiblility, tend to be more important than absolute
performance.  This lets bugs be fixed, and the big changes that tend
to be the biggest wins happen.

> I am skeptical of the argument that we can win by replacing "the least
> desirable" pages with pages were even less desireable and that we have
> no recent indication of any need for. It seems possible under heavy swap
> to discard quite a portion of the useful pages in favor of junk that just
> happenned to have a lucky disk address.

I won't argue that.  My gut just says we should work to improve the
disk addresses, so it isn't luck. ;)  And only if we fail in that
hack up the efficient simple policy, that we have for reading disk
data in.

Of course since I'm not actually writing the code at the moment
this is all hot air :)

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
