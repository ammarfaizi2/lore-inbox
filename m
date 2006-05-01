Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWEAGVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWEAGVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 02:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWEAGVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 02:21:09 -0400
Received: from kanga.kvack.org ([66.96.29.28]:48352 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750806AbWEAGVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 02:21:08 -0400
Date: Mon, 1 May 2006 03:20:58 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: DervishD <lkml@dervishd.net>
Subject: Re: O_DIRECT, ext3fs, kernel 2.4.32... again
Message-ID: <20060501062058.GA16589@dmt>
References: <20060427063249.GH761@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427063249.GH761@DervishD>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raul,

On Thu, Apr 27, 2006 at 08:32:49AM +0200, DervishD wrote:
>     Hi all :)
> 
>     I don't know if the patch to backport O_DIRECT support for ext3
> under kernel 2.4.3x was finally accepted or not, but I'm having what
> I consider inconsistent behaviour due to O_DIRECT under ext3fs and
> kernel 2.4.32.
> 
>     I can understand that ext3 doesn't support O_DIRECT, and that's
> not a problem for me. In fact, if an app really needs O_DIRECT and
> the underlying filesystem doesn't support it, the app should fail, no
> more and no less.

On v2.4, nope it doesnt.

>     The problem I'm having is with dvd+rw-tools. Apart from all the
> problems regarding DVD writing, I have another problem: the open64
> call with the O_DIRECT flag succeeds, but any subsequent read
> operation fails. IMHO, if the filesystem is going to return EINVAL
> for any read/write operation over an O_DIRECT'ed filehandle, it
> should return an error when opening, too.
> 
>     The growisofs program tries to open a file using O_DIRECT and the
> call succeeds, so it tries to read from that filehandle and the
> result is always EINVAL.
>
> I've tried a test program, just in case the problem was memory
> alignment of the buffer, but nothing is solved (I used posix_memalign
> and some recipe I found in this list, using the st_blksize and the
> st_size of the file). The problem seems to be in the O_DIRECT flag,
> because removing it from the open call makes all work.
> 
>     Shouldn't ext3fs return an error when the O_DIRECT flag is used
> in the open call? Is the open call userspace only and thus only libc
> can return such error? Am I misunderstanding the entire issue and
> this is a perfectly legal behaviour (allowing the open, failing in
> the read operation)?

Your interpretation is correct. It would be nicer for open() to fail on
fs'es which don't support O_DIRECT, but v2.4 makes such check later at
read/write unfortunately ;(

And its too late for changing that IMO...

