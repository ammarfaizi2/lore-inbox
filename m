Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTKEHIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 02:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTKEHIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 02:08:36 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:47324 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262707AbTKEHIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 02:08:35 -0500
Date: Wed, 5 Nov 2003 02:08:32 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: jlnance@unity.ncsu.edu
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
Message-ID: <20031105020832.V2097@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0311041422580.20373-100000@home.osdl.org> <3FA83ACC.5060700@redhat.com> <20031105005816.GA5971@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031105005816.GA5971@ncsu.edu>; from jlnance@unity.ncsu.edu on Tue, Nov 04, 2003 at 07:58:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 07:58:16PM -0500, jlnance@unity.ncsu.edu wrote:
> On Tue, Nov 04, 2003 at 03:48:28PM -0800, Ulrich Drepper wrote:
> > 
> > The first is the old nptl code, the second LinuxThreads, the third the
> > current nptl code.
> 
> By current, do you mean what is in Fedora, or you personal development copy?

Ulrich meant glibc CVS HEAD.
For some reason, stdio locking was not using the jump around lock prefix
variant of locking:
            __asm __volatile ("cmpl $0, %%gs:%P6\n\t"                         \
                              "je,pt 0f\n\t"                                  \
                              "lock\n"                                        \
                              "0:\tcmpxchgl %1, %2\n\t"                       \
                              "jnz _L_mutex_lock_%=\n\t"                      \
			      ".subsection 1\m\t" ...
but one without the first 2 insns, so there were 2 instructions with lock
prefix in putc and similar functions even when only one thread was running.

	Jakub
