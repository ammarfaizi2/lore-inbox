Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWCLVcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWCLVcf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWCLVcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:32:35 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:2028 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932230AbWCLVce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:32:34 -0500
Date: Sun, 12 Mar 2006 22:32:28 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: Faster resuming of suspend technology.
Message-ID: <20060312213228.GA27693@rhlx01.fht-esslingen.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[CC'd -ck list]

On Sat, Mar 11, 2006 at 02:04:10AM +0900, Jun OKAJIMA wrote:
> 
> 
> As you might know, one of the key technology of fast booting is suspending.
> actually, using suspending does fast booting. And very good point is
> not only can do booting desktop and daemons, but apps at once.
> but one big fault --- it is slow for a while after booted because of HDD thrashing.
> (I mention a term suspend as generic one, not refering only to Nigel Cunningham's one)
I think that is the case since swsusp AFAIR forces as many pages
as possible into swap and then appends some non-pageable parts
before shutting down.
Thus the system will resume with all processes fully residing
in swap space and the apps getting back to main memory
on demand only.

And... well... this sounds to me exactly like a prime task
for the newish swap prefetch work, no need for any other
special solutions here, I think.
We probably want a new flag for swap prefetch to let it know
that we just resumed from software suspend and thus need
prefetching to happen *much* faster than under normal
conditions for a short while, though (most likely by
enabling prefetching on a *non-idle* system for a minute).

Andreas Mohr
