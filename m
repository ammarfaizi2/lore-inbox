Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUDLO6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDLO6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:58:51 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:14887
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S261865AbUDLO6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:58:46 -0400
thread-index: AcQgnv92Qxwrl4epRiCBHjsqgWhACw==
X-Sieve: Server Sieve 2.2
Date: Mon, 12 Apr 2004 16:01:13 +0100
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Chris Friesen" <cfriesen@nortelnetworks.com>
Message-ID: <000001c4209e$ff956940$d100000a@sbs2003.local>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <Administrator@vger.kernel.org>
Cc: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: want to clarify powerpc assembly conventions in head.S	and	entry.S
X-Mailer: Microsoft CDO for Exchange 2000
References: <4077A542.8030108@nortelnetworks.com>	 <1081591559.25144.174.camel@gaston>  <4078D42C.1020608@nortelnetworks.com> <1081661150.1380.183.camel@gaston>
In-Reply-To: <1081661150.1380.183.camel@gaston>
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-me-spamlevel: not-spam
Content-Class: urn:content-classes:message
Importance: normal
X-me-spamrating: 6.423327
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-OriginalArrivalTime: 12 Apr 2004 15:01:14.0046 (UTC) FILETIME=[FFB91DE0:01C4209E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt wrote:
>>You knew this was coming...  What's special about syscalls?  There's the
>>r3 thing, but other than that...
>
> The whole codepath is a bit different, there's the syscall trace,
> we can avoid saving much more registers are syscalls are function
> calls and so can clobber the non volatiles, etc...

It appears that we always enter the kernel via "transfer_to_handler",
and return via "ret_from_except".  Is this true? (I'm running on at
least a 74xx chip.)

I want to insert two new bits of code, one that gets called before the
exception handler when we drop from userspace to kernelspace, and one as
late as possible before going back to userspace.  I need to catch
syscalls, interrupts, exceptions, everything.

The entry one I planned on putting in "transfer_to_handler", just before
"addi   r11,r1,STACK_FRAME_OVERHEAD".

I was planning on putting the exit one just after the "restore_user"
label.  Will this catch all possible returns to userspace?

Thanks,

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


