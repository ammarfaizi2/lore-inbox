Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270862AbRH1M6V>; Tue, 28 Aug 2001 08:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270919AbRH1M6C>; Tue, 28 Aug 2001 08:58:02 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:63417 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S270862AbRH1M5t>; Tue, 28 Aug 2001 08:57:49 -0400
Date: Tue, 28 Aug 2001 13:59:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: VM: Bad swap entry 0044cb00
In-Reply-To: <Pine.NEB.4.33.0108280204430.13898-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.21.0108281341140.1135-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, Adrian Bunk wrote:
> 
> I upgraded my kernel from 2.4.8ac10 to 2.4.9ac2 some hours ago and I found
> the following message in my syslog file (I've never seen something like
> this before):
> 
> Aug 27 22:40:46 r063144 kernel: VM: Bad swap entry 0044cb00
> 
> What does this mean (my machine seems to run fine)?

If you only get such a message occasionally, it probably indicates
some race in the swapin code; probably not a new problem, but one now
made more visible by Rik's vm_swap_full swap deletion (as Alan hinted).
The race may well be benign.

But I'm guessing: I ought to understand this, but I don't.

The message I would expect you to get occasionally is the equivalent
message from swap_duplicate(), but that would be differently worded
("Unused swap offset entry in swap_dup 0044cb00").  The one you see
either comes from __swap_free() or from get_swaphandle_info():
I wonder which?

If you're still getting such messages, please let me know and
I'll send a test patch to make the message more informative.

Is this an SMP machine?

Hugh

