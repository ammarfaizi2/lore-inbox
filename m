Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422927AbWBIRtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbWBIRtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWBIRtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:49:42 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:49310 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1422927AbWBIRtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:49:41 -0500
Date: Thu, 9 Feb 2006 12:48:12 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
Message-ID: <20060209174812.GA6945@ccure.user-mode-linux.org>
References: <43E7C65F.3050609@openvz.org> <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com> <20060209021828.GC9456@ccure.user-mode-linux.org> <43EB7007.5040208@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EB7007.5040208@watson.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 11:38:31AM -0500, Hubertus Franke wrote:
> Jeff, interesting, but won't that post some serious scalability issue?
> Imaging 100s of container/namespace ?

In terms of memory?  

Running size on sched.o gives me this on x86_64:
   text    data     bss     dec     hex filename
  35685    6880   28800   71365   116c5 sched.o

and on i386 (actually UML/i386)

   text    data     bss     dec     hex filename
  10010      36    2504   12550    3106 obj/kernel/sched.o

I'm not sure why there's such a big difference, but 100 instances adds
a meg or two (or three) to the kernel.  This overstates things a bit
because there are things in sched.c which wouldn't be duplicated, like
the system calls.

How big a deal is that on a system which you plan to have 100s of
containers on anyway?

It's heavier than your namespaces, but does have the advantage that it
imposes no cost when it's not being used.

> The namespace is mainly there to identify which data needs to be private
> when multiple instances of a subsystem are considered and
> encapsulate that data in an object/datastructure !

Sure, and that's a fine approach.  It's just not the only one.

				Jeff
