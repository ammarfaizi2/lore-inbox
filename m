Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUCIT5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbUCIT5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:57:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:59100 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262110AbUCIT4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:56:38 -0500
Date: Tue, 9 Mar 2004 20:57:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309195752.GA16519@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random> <20040309074747.GA8021@elte.hu> <20040309152121.GD8193@dualathlon.random> <20040309153620.GA9012@elte.hu> <20040309163345.GK8193@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309163345.GK8193@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> > (OASB is not a full-disclosure benchmark so i have no way to check
> > this.) All you have proven is that workloads with a limited number of
> > per-inode vmas can perform well. Which completely ignores my point.
> 
> what is your point, that OASB is a worthless workload and the only
> thing that matters is TPC-C? [...]

not at all. I pointed out specific workloads that create tons of vmas,
which would perform very bad if swapping. OASB is not one of those
workloads. [I could also mention UML which currently creates a vma per
virtualized page, which, with a low-end UML setup, generates tens of
thousands of vmas as well.]

(if the linear search is fixed then i have no objections, but for the
current code to hit any mainline kernel we would first need to redefine
'enterprise quality'. My main worry is that we are now at a dozen emails
regarding this topic and you still dont seem to be aware of the severity
of this quality of implementation problem.)

sure, remap_file_pages() fixes such problems - while i'm happy if more
people use remap_file_pages(), apps are not (and should not be) forced
to use remap_file_pages() and i refuse to concede that the VM must
inevitably get wedged with just a couple of thousand vmas created on a
256 MB 500 MHz box ... I dont know how to put this point in a simpler
way. This stuff must not be added (to mainline) until it can take the
load.

	Ingo
