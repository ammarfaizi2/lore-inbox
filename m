Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVBMUK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVBMUK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 15:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVBMUK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 15:10:26 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64945 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261265AbVBMUKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 15:10:20 -0500
Date: Sun, 13 Feb 2005 21:10:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrey Savochkin <saw@sawoct.com>, linux-kernel@vger.kernel.org
Subject: Re: possible CPU bug and request for Intel contacts
Message-ID: <20050213201006.GA28783@elte.hu>
References: <01EF044AAEE12F4BAAD955CB7506494302E88991@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01EF044AAEE12F4BAAD955CB7506494302E88991@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Seth, Rohit <rohit.seth@intel.com> wrote:

> On a little different note, while running the 4G-4G kernel on our
> machine, we saw occasional hangs.  Those are root caused to the fact
> that this kernel was first chaging the stack pointer from virtual
> stack to kernel and then changing the CR3 to that of kernel.  Any
> interrupt between these two instructions will result in those hangs as
> the interruption handler will execute with user's CR3(as the kernel
> thinks that it is already in kernel because of the value of esp). 
> Swapping the order, first loading the CR3 with kernel and then
> switching the stack to kernel fixes this issue.  Venki will generate
> that patch and send to lkml.

i'm not sure what you mean. Here's the relevant 4:4 code from Fedora:

#define __SWITCH_KERNELSPACE                            \
...
        movl %edx, %cr3;                                \
        movl %ebx, %esp;                                \

i.e. we _first_ load cr3 with the kernel pagetable value, then do we
switch esp to the real kernel stack.

	Ingo
