Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUDLX2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 19:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUDLX2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 19:28:16 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:8744
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S263161AbUDLX2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 19:28:12 -0400
thread-index: AcQg5iqLerH9esnzSLaXnWHm6u6k5Q==
X-Sieve: Server Sieve 2.2
Subject: Re: want to clarify powerpc assembly conventions inhead.S	and	entry.S
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: <Administrator@vger.kernel.org>
Cc: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Message-ID: <000001c420e6$2a8da7b0$d100000a@sbs2003.local>
In-Reply-To: <407AA848.2000008@nortelnetworks.com>
References: <4077A542.8030108@nortelnetworks.com> <1081591559.25144.174.camel@gaston>  <4078D42C.1020608@nortelnetworks.com> <1081661150.1380.183.camel@gaston>  <407AA848.2000008@nortelnetworks.com>
Content-Type: text/plain;
	charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Apr 2004 00:30:40 +0100
Content-Transfer-Encoding: 7bit
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
Content-Class: urn:content-classes:message
X-me-spamlevel: not-spam
Importance: normal
X-me-spamrating: 5.120257
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-OriginalArrivalTime: 12 Apr 2004 23:30:40.0437 (UTC) FILETIME=[2AB63E50:01C420E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2004-04-13 at 00:31, Chris Friesen wrote:
> Benjamin Herrenschmidt wrote:
> >>You knew this was coming...  What's special about syscalls?  There's the
> >>r3 thing, but other than that...
> >
> > The whole codepath is a bit different, there's the syscall trace,
> > we can avoid saving much more registers are syscalls are function
> > calls and so can clobber the non volatiles, etc...
>
> It appears that we always enter the kernel via "transfer_to_handler",
> and return via "ret_from_except".  Is this true? (I'm running on at
> least a 74xx chip.)

ret_from_syscall for syscalls, hash_page also has a different
return to userland path, and load_up_{fpu,altivec} have their own
retturn path.
On ppc32 currently, the entry is almost always the same except for
hash_page and load_up_{fpu,altivec}

> I want to insert two new bits of code, one that gets called before the
> exception handler when we drop from userspace to kernelspace, and one as
> late as possible before going back to userspace.  I need to catch
> syscalls, interrupts, exceptions, everything.
>
> The entry one I planned on putting in "transfer_to_handler", just before
> "addi   r11,r1,STACK_FRAME_OVERHEAD".
>
> I was planning on putting the exit one just after the "restore_user"
> label.  Will this catch all possible returns to userspace?

No.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


