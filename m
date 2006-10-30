Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWJ3PmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWJ3PmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbWJ3PmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:42:25 -0500
Received: from [82.147.217.150] ([82.147.217.150]:8064 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030536AbWJ3PmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:42:24 -0500
From: Al Boldi <a1426z@gawab.com>
To: Rik van Riel <riel@surriel.com>
Subject: Re: [RFC] kswapd: Kernel Swapper performance
Date: Mon, 30 Oct 2006 18:45:00 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200610282031.17451.a1426z@gawab.com> <4543CF1C.7070604@surriel.com>
In-Reply-To: <4543CF1C.7070604@surriel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200610301845.00206.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> Al Boldi wrote:
> > One thing that has improved in 2.6, wrt 2.4, is swapper performance. 
> > And the difference isn't small either: ~5 fold increase in swapin
> > performance.
> >
> > But swapin performance still lags swapout performance by 50%, which is a
> > bit odd, considering swapin to be a read from disk, usually faster, and
> > swapout to be a write to disk, usually slower.
>
> Ahhhhhh, but there's a catch...
>
> You can queue up multiple writes, because the data you want
> to write to disk is already in memory.
>
> However, at swapin time you need to read the first bit of
> data from disk, after which the program can continue, and
> only when the next page fault happens you know what data
> to read in next.
>
> Linux does some swapin clustering, but there simply is no
> way to know which data will be needed next.
>
> This means reads are serialized and synchronous wrt. program
> execution, while writes can overlap and be done asynchronously.
>
> It's a miracle reads are going at 50% of the speed of writes...
>
> > Improving this ratio could possibly yield a dramatic improvement in
> > system performance under memory load (think tmpfs/swsusp/...).
>
> Let me know when you figure out how to look into the future.
>
> Actually, Keir Fraser and Fay Chang came up with a cool trick.
>
>     "Operating System I/O Speculation:
>    How Two Invocations Are Faster Than One"
>
> http://www.usenix.org/publications/library/proceedings/usenix03/tech/frase
>r.html
>
> It is somewhat complex though...

Thanks for the link, but I was more thinking about improving consecutive 
swapin rather than random swapin.

Right now, consecutive swapin looks suspiciously slow, and should be at least 
as fast as swapout, if not faster.


Thanks!

--
Al

