Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310570AbSCGWnI>; Thu, 7 Mar 2002 17:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310568AbSCGWmt>; Thu, 7 Mar 2002 17:42:49 -0500
Received: from [208.29.163.248] ([208.29.163.248]:12278 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S310566AbSCGWmn>; Thu, 7 Mar 2002 17:42:43 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Date: Thu, 7 Mar 2002 14:42:21 -0800 (PST)
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <Pine.LNX.4.44L.0203071926340.2181-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0203071441180.22863-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in addition by rducing the amount of readahead you do for each file you
can stabilize into a mode where you are doing _some_ readahead and not
thrashing so this will reduce your seeks.

David Lang



On Thu, 7 Mar 2002, Rik van Riel wrote:

> Date: Thu, 7 Mar 2002 19:27:49 -0300 (BRT)
> From: Rik van Riel <riel@conectiva.com.br>
> To: Andrew Morton <akpm@zip.com.au>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [RFC] Arch option to touch newly allocated pages
>
> On Thu, 7 Mar 2002, Andrew Morton wrote:
>
> > > use-once reduces the VM to FIFO order, which suffers from
> > > belady's anomaly so it doesn't matter much how much memory
> > > you throw at it
> > >
> > > drop-behind will suffer the same problem once the readahead
> > > memory is too large to keep in the system, but at least the
> > > already-used pages won't kick out readahead pages
> >
> > err..  Was there a fix in there somewhere, or are we stuck?
>
> Imagine how TCP backoff would work if it kept old packets
> around and would drop random packets because of too many
> old packets in the buffers.
>
> I suspect that the readahead window resizing might work
> when we throw away the already-used streaming IO pages
> before we start throwing away any pages we're about to
> use.
>
> regards,
>
> Rik
> --
> <insert bitkeeper endorsement here>
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
