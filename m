Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbUKWViS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbUKWViS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKWVgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:36:10 -0500
Received: from holomorphy.com ([207.189.100.168]:35494 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261350AbUKWRqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:46:40 -0500
Date: Tue, 23 Nov 2004 09:46:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org,
       gerg@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
Message-ID: <20041123174623.GL2714@holomorphy.com>
References: <20041123171039.GK2714@holomorphy.com> <20041122155434.758c6fff.akpm@osdl.org> <11948.1101130077@redhat.com> <29356.1101201515@redhat.com> <20041123081129.3e0121fd.akpm@osdl.org> <16107.1101230673@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16107.1101230673@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> The MMU-less code appears to assume the refcounts of the tail pages
>> will remain balanced, and elevates them to avoid the obvious disaster.
>> But this looks rather broken barring some rather unlikely invariants.

On Tue, Nov 23, 2004 at 05:24:33PM +0000, David Howells wrote:
> I had to fix it to make it work, but what's currently lurking in
> Andrew's tree seems more or less correct, just not necessarily safe.

Pardon my saying so, but "correct, but unsafe" sounds a bit oxymoronic. =)


William Lee Irwin III <wli@holomorphy.com> wrote:
>> It's unclear (to me) how the current MMU-less code works properly, at
>> the very least.

On Tue, Nov 23, 2004 at 05:24:33PM +0000, David Howells wrote:
> For the most part it's down to two !MMU bits in page_alloc.c - one sets all
> the refcounts on the pages of a high-order allocation, and the other
> decrements them all again during the first part of freeing.

Yes, the issue centered around this not being sound.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> It would appear to leak memory since there is no obvious guarantee the
>> reference to the head page will be dropped when needed, though things may
>> have intended to free the various tail pages.

On Tue, Nov 23, 2004 at 05:24:33PM +0000, David Howells wrote:
> Actually, it's more a problem of the "superpage" being freed when the
> subpages have elevated counts.

I realized this shortly after hitting 'y'.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> It may also be helpful for Greg Ungerer to help review these patches,
>> as he appears to represent some of the other MMU-less concerns, and
>> may have more concrete notions of how things behave in the MMU-less
>> case than I myself do (hardware tends to resolve these issues, but
>> that's not always feasible; perhaps an MMU-less port of a "normal"
>> architecture would be enlightening to those otherwise unable to
>> directly observe MMU-less behavior). In particular, correcting what
>> misinterpretations in the above there may be.

On Tue, Nov 23, 2004 at 05:24:33PM +0000, David Howells wrote:
> The FRV arch does both MMU and !MMU versions. It's settable by a config
> option, and I check both.

Unless FRV is surprisingly more widely distributed than it appears,
it's unclear it will do much to help the CONFIG_MMU=n testing level.

Thanks.


-- wli
