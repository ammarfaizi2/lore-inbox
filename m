Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267348AbUHSTta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267348AbUHSTta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUHSTsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:48:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32466 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267329AbUHSTr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:47:29 -0400
Date: Thu, 19 Aug 2004 12:54:05 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rainer Weikusat <rainer.weikusat@sncag.com>
Cc: "bradgoodman.com" <bkgoodman@bradgoodman.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.27 - MTD cfi_cmdset_0002.c - Duplicate cleanup in error path
Message-ID: <20040819155405.GC4396@logos.cnet>
References: <200407231947.i6NJlwo32224@bradgoodman.com> <87k6wtlvwk.fsf@farside.sncag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6wtlvwk.fsf@farside.sncag.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied Rainer's patch, its equivalent and I his
"consisteny with other algorithms" point is a good one.

Thanks guys!

On Sat, Jul 24, 2004 at 03:14:03PM +0800, Rainer Weikusat wrote:
> "bradgoodman.com" <bkgoodman@bradgoodman.com> writes:
> > Patch to 2.4.x: Corrects an obvious error where all of the cleanups are done
> > twice in the event of a chip programming error. This can result in
> > kernel BUG() getting called on subsequent programming attempts.
<snip>
> That way, it is consistent with the other low-level chip access
> functions. But the algorithm is per se buggy, anyway, because except
> if DQ5 was raised before, the chip is not 'ready' (for reading array
> data), but still in programming mode and will remain there until the
> 'embedded programming algorithm' stops, because (according to the
> docs) a reset command will not be accepted until DQ5 has been raised
> and the opportunityto check for that is gone after the syscall
> returned to the caller.
