Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265945AbUFOUml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUFOUml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUFOUmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:42:40 -0400
Received: from mail.ccur.com ([208.248.32.212]:49925 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265945AbUFOUlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:41:00 -0400
Date: Tue, 15 Jun 2004 16:40:59 -0400
From: Joe Korty <joe.korty@ccur.com>
To: "j.random.programmer" <javadesigner@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Threading behavior in 2.6.5 may be broken ?
Message-ID: <20040615204059.GA21301@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040610041641.80112.qmail@web14202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610041641.80112.qmail@web14202.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 09:16:41PM -0700, j.random.programmer wrote:
> Hi all:
> 
> I just installed Fedora Core 2 (2.6.5.x smp 
> kernel) on a Dual 1 Ghz P4 server with about 
> 1.5 GB of RAM and about 1.4 GB of swap. 
> 
> I am primarily a web/database developer, not 
> a C programmer so I am writing this email from
> an end-user's perspective.
> 
> I have a program that tries to create as many
> threads as possible. This program was written by me 
> for kicks/testing -- just to see what would happen.
> I ssh into the server and run this program as root
> under the sun 1.4.2 JDK.
> 
> On a 2.4.x kernel, from a Java JVM I could create
> about 900 threads before the JVM crapped out with
> a "cannot create more threads" type of error. Before
> this point, I can create/run - say 700 threads - just
> fine. This is good -- a clean failure at some point
> and good behavior before then.
> 
> On this new kernel, the system gets totally wedged
> when I run the same program and try to create
> 10,000 threads. Instead of getting a "cannot
> create more threads" error, I now get an "out of
> memory" error. Then the command line freezes in
> the existing terminal window, ctrl+c does not work
> (no matter how many times it's pressed), I cannot
> launch another ssh session and cannot ssh into the
> server again (although ping still works).
> 
> To recap:
> 
> [2.4.x]
> 700 threads --> fine
> 10,000 threads --> crap out at 900 something. 
> 
> [2.6.5]
> 700 threads --> fine
> 10,000 threads --> system wedged totally. 

It's funny you should post this, I just encountered the
same thing a few days ago, and found the cause a few
minutes ago.

The problem is that 2.6.x restricts unpinned mmaps (mmaps
where the app does not supply the virtual address) to the
400000000-c000000000 range, while redhat allows all holes
in the user address space to satisfy such requests.

RedHat implements this by introducing an i386-specific
version of arch_get_unmapped_area().  This has not
yet made it to the official kernels.  I have no idea
if it was ever submitted for consideration, or was
submitted and rejected.

Regards,
Joe
