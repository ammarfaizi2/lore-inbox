Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272291AbTHMMXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272378AbTHMMXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:23:11 -0400
Received: from mail.suse.de ([213.95.15.193]:32012 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272291AbTHMMXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:23:03 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
References: <20030813045638.GA9713@middle.of.nowhere.suse.lists.linux.kernel>
	<20030813014746.412660ae.akpm@osdl.org.suse.lists.linux.kernel>
	<20030813091958.GA30746@gates.of.nowhere.suse.lists.linux.kernel>
	<20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel>
	<1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel>
	<20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel>
	<1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Aug 2003 14:10:43 +0200
In-Reply-To: <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel>
Message-ID: <p7365l17o70.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mer, 2003-08-13 at 12:25, Andrew Morton wrote:
> > Like this?
> > 
> > What happens if someone runs a K6 kernel on a K7?
> > Or various other CPU types?  What is the matrix here?
> 
> Beats me, but then the prefetch code in 2.6 seems broken from
> 5 seconds of inspection anyway. We are testing the XMM feature
> and using prefetchnta for Athlon, thats wrong for lots of athlon
> processors that dont have XMM but do have prefetch/prefetchw,
> (which btw also seem to work properly on all these processors
>  while prefetchnta seems to do funky things)

The early Athlon Specific test was not done to avoid too much bloat.
(three alternatives instead of two)

Most Athlons in existence should have XMM already and the rest works.

You can hardly call that broken.

I would be surprised if prefetch behaves differently than prefetchnta
on Athlon. If the bug is similar to what happens on Opteron then
I bet it won't make a difference.

> For Athlon we should be testing 3Dnow, and using prefetch/prefetchw
> for Intel cases we want to go for prefetchnta if XMM is set (PIII, PIV)

That's done for write prefetches correctly.

(as Intel does not have a write prefetch)

-Andi
