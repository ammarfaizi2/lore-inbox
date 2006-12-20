Return-Path: <linux-kernel-owner+w=401wt.eu-S965136AbWLTP2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWLTP2i (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 10:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbWLTP2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 10:28:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965136AbWLTP2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 10:28:37 -0500
Date: Wed, 20 Dec 2006 10:28:28 -0500
From: Dave Jones <davej@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch] x86_64: fix boot time hang in detect_calgary()
Message-ID: <20061220152828.GF31335@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@suse.de>
References: <20061220105332.GA20922@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220105332.GA20922@elte.hu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 11:53:32AM +0100, Ingo Molnar wrote:

 > the patch below fixes the boot hang by trusting the BIOS-supplied data 
 > structure a bit less: the parser always has to make forward progress, 
 > and if it doesnt, we break out of the loop and i get the expected kernel 
 > message:
 > 
 >   Calgary: Unable to locate Rio Grande Table in EBDA - bailing!

Good job tracking this down.  I saw someone get bit by probably this
same bug a few days ago.  Whilst on the subject though, can we do
something about the printk ?
It always bothered me that some drivers print something when
a) built-in, and b) they don't find something.
For kitchen sink kernels, this makes for a really noisy bootup.

So you didn't find hardware I know I don't have. Big deal, move on.
dmesg spam these days is getting really out of hand.

hmm, maybe a mod_printk, to only printk something when built as
a module ?

		Dave

-- 
http://www.codemonkey.org.uk
