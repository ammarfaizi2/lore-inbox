Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUE0O5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUE0O5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUE0O5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:57:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:48327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264639AbUE0O4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:56:11 -0400
Date: Thu, 27 May 2004 07:55:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Brian Gerst <bgerst@didntduck.org>, Ingo Molnar <mingo@elte.hu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
In-Reply-To: <20040527145033.GF3889@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0405270754360.1648@ppc970.osdl.org>
References: <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu>
 <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com>
 <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com>
 <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040527124551.GA12194@elte.hu>
 <20040527135930.GC3889@dualathlon.random> <40B5F8C0.2010005@didntduck.org>
 <20040527145033.GF3889@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 May 2004, Andrea Arcangeli wrote:
>
> On Thu, May 27, 2004 at 10:18:40AM -0400, Brian Gerst wrote:
> > The problem on i386 (unlike x86-64) is that the thread_info struct sits 
> > at the bottom of the stack and is referenced by masking bits off %esp. 
> > So the stack size must be constant whether in process context or IRQ 
> > context.
> 
> so what, that's a minor implementation detail, pda is a software thing.

"minor implementation detail"?

You need to get to the thread info _some_ way, and you need to get to it
_fast_. There are really no sane alternatives. I certainly do not want to
play games with segments.

		Linus
