Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVLFSU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVLFSU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVLFSU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:20:57 -0500
Received: from ns1.suse.de ([195.135.220.2]:39063 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932484AbVLFSU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:20:56 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Policy for reverting user ABI breaking patches was Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	<20051203201945.GA4182@kroah.com>
	<9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com>
	<20051204115650.GA15577@merlin.emma.line.org>
	<20051204232454.GG8914@kroah.com> <20051205185110.GJ9973@stusta.de>
	<20051206175017.GF3084@kroah.com>
From: Andi Kleen <ak@suse.de>
Date: 06 Dec 2005 15:50:55 -0700
In-Reply-To: <20051206175017.GF3084@kroah.com>
Message-ID: <p73hd9lrga8.fsf_-_@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> 
> And there will always be a need for new package upgrades for some small
> subset of programs that are tightly tied to the kernel (like
> wpa_supplicant or alsa-libs, or even udev).  But "normal" userspace

Actually I don't necessarily agree on that. It's best to avoid
breakage even for them. It has actually worked for a long time.
In the early days of Linux there was frequent breakage like
this but then in recent times the kernel has been very good
at this for a long time (one exception was the module rewrite,
but that was a single flag day). I have been running
modern kernels on old distributions for a long time
and it generally worked. 

And if there is breakage of such kernel-near applications there should
be an *extremly* good reason for this (and minor cleanup isn't such a
reason). For example for the recent udev breakage imho the cleanup
patch that caused this should have just been reverted. I know it's not
possible to know such bad interactions in advance, but when they are
known and there isn't an *extremly* good reason for it then the ABI
breaking change should be reverted.

It would be good to have a policy like this: if an important program
breaks due to a new kernel

[With important being fairly liberally defined as anything shipped in
standard distros unless it's something exotic that does something
stupid or is obviously broken. External kernel modules or /dev/mem
access don't count.]

then the breakage needs to have an *extremly* good rationale 
(fixing security bugs etc.) and if there isn't one from the person
who submitted the patch then it should be reverted.

-Andi
