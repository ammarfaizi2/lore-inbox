Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbUKXWgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUKXWgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUKXWgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:36:41 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:48569 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261659AbUKXWgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:36:37 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124132839.GA13145@infradead.org>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <20041124132839.GA13145@infradead.org>
Content-Type: text/plain
Message-Id: <1101329104.3425.40.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 07:46:12 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 00:28, Christoph Hellwig wrote:
> Your way of merging looks rather wrong.  Please submit changes against the
> current swsusp code that introduce one feature after another to bring it
> at the level you want.  You'll surely have to rewrok it a lot until all
> reviewers are happy.

I realise that it needs further cleanup; that's why I'm submitting it
now for comment and not asking 'please apply'. As to patching against
swsusp, I'm purposely not doing that. The reason is that suspend2 isn't
a bunch of incremental changes to swsusp. It has been redesigned from
the ground up and I'd have to pull swsusp to pieces and put it back
together to do the same things.

I'm thus seeking to simply merge the existing code, let Pavel and others
get to the point where they're ready to say "Okay, we're satisfied that
suspend2 does everything swsusp does and more and better." Then we can
remove swsusp. This is the plan that was discussed with Pavel and Andrew
ages ago. I've just been slow to get there because I'm doing this
part-time voluntary.

> And most importantly for each patch explain exactly what feature it
> implements and why, etc..  "swsusp2" tells exactly nothing about the
> changed you do.

Okay. The changes include:

- Almost no BUG() statements. Wherever possible, if something goes
wrong, we back out and give the user a perfectly usable system back
- Speed: All I/O is asynchronous where possible and readahead used where
not. Routines everywhere optimised to get things done as fast as poss.
(Think low battery).
- Flexible: You can tune performance to your system in a number of ways.
You can use/not use bootsplash, text output, compression drivers as you
choose. You can change your swap configuration without having to reboot
just to change the resume2= parameter. You can cancel a suspend if you
want, or disable the possibility of doing so.
- Reliability. I haven't run the tests for a while, but Michael Frank
produced a suite that was used to stress test the software (under 2.4)
while running 100s (1000s at least once) of cycles. There have been some
significant changes since then, but the software is essentially the
same.
- Test bed: Around 10,000 downloads of the 1.0 patch, 2730 to date of
the 2.1.5 version I released 2 weeks ago.
- Swap file support
- Support for LVM/dm-crypt and siblings
- Support for having device drivers as modules (resume from an
initrd/initramfs)
- Almost all memory allocations are order 0, making suspend more
reliable under load.
- Designed to save as much of memory as possible rather than as little
(making the system more responsive post-resume).
- Support for SMP
- Support for preempt
- Support for 4GB highmem (hope to do 64GB soonish)
- Support for suspending/resuming over a network possible but not yet
implemented (hope to do so soon)

I realise it's only some, but I think it gives you the jist :>

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

