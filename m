Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUFNKTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUFNKTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 06:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUFNKTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 06:19:37 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:30734 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S262322AbUFNKTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 06:19:35 -0400
Date: Mon, 14 Jun 2004 12:19:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Christoph Hellwig <hch@infradead.org>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [12/12] fix thread_info.h ignoring __HAVE_THREAD_FUNCTIONS
In-Reply-To: <20040614081639.GI7162@infradead.org>
Message-ID: <Pine.LNX.4.58.0406141032210.10292@scrub.local>
References: <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com>
 <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com>
 <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com>
 <20040614004354.GX1444@holomorphy.com> <20040614004516.GY1444@holomorphy.com>
 <20040614004701.GZ1444@holomorphy.com> <20040614004855.GA1444@holomorphy.com>
 <20040614081639.GI7162@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Jun 2004, Christoph Hellwig wrote:

> On Sun, Jun 13, 2004 at 05:48:55PM -0700, William Lee Irwin III wrote:
> >  * Check __HAVE_THREAD_FUNCTIONS in include/linux/thread_info.h (m68k)
> > This fixes the build on m68k; its thread_info functions need to be used.
> 
> I don't like this one a lot and prefer to discuss it with the m68k folks
> first.  Given they didn't sent it to Linus themselves I guess they're not
> completely proud of it ;-)

That's out of the "should we just blindly copy everything from i386?" 
department. These thread info functions used char fields for a short 
while, which is actually preferable over bitfields on a lot of archs.
The various thread flags have different usage, often the current thread is 
the only one accessing it, but all of them right now use possibly 
expensive bit field functions.
I'm thinking about reverting this one and just copy what everyone else is 
doing, as the benefit is probably not that big for m68k.

There is another pending change in this department: current_thread_info(). 
For all nonbroken archs which have proper thread register it would 
actually be beneficial, to keep the task structure and thread info 
together and access them via the thread register, but a certain arch 
and include dependencies forces everyone to derive the thread info pointer 
from the stack pointer.
The most important change here is to separate task_struct out of sched.h 
and I'd really like to get this change in, even if it has to wait for 2.7.

bye, Roman
