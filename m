Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbSLQQC4>; Tue, 17 Dec 2002 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSLQQC4>; Tue, 17 Dec 2002 11:02:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:52790 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S264629AbSLQQC4>; Tue, 17 Dec 2002 11:02:56 -0500
Date: Tue, 17 Dec 2002 16:12:00 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212171556110.1460-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Linus Torvalds wrote:
> 
> Ok, I did the vsyscall page too, and tried to make it do the right thing
> (but I didn't bother to test it on a non-SEP machine).
> 
> I'm pushing the changes out right now, but basically it boils down to the
> fact that with these changes, user space can instead of doing an
> 
> 	int $0x80
> 
> instruction for a system call just do a
> 
> 	call 0xfffff000

I thought that last page was intentionally left invalid?

So that, for example, *(char *)MAP_FAILED will give SIGSEGV;
whereas now I can read a 0 there (and perhaps you should be
using get_zeroed_page rather than __get_free_page?).

I cannot name anything which relies on that page being invalid,
but think it would be safer to keep that it way; though I guess
more compatibility pain to use the next page down (or could
seg lim be used? I forget the granularity restrictions).

Hugh

