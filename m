Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284242AbRLLBJH>; Tue, 11 Dec 2001 20:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284814AbRLLBI5>; Tue, 11 Dec 2001 20:08:57 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:267 "EHLO vasquez.zip.com.au")
	by vger.kernel.org with ESMTP id <S284242AbRLLBIp>;
	Tue, 11 Dec 2001 20:08:45 -0500
Message-ID: <3C16ADB1.F9E847E9@zip.com.au>
Date: Tue, 11 Dec 2001 17:06:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Berend De Schouwer <bds@jhb.ucs.co.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel Oops on cat /proc/ioports
In-Reply-To: <1008073796.5535.5.camel@bds.ucs.co.za>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berend De Schouwer wrote:
> 
> [1.] One line summary of the problem:
> 
> Running "cat /proc/ioports" causes a segfault and kernel oops.
> 
> ...
> [7.3.] Module information (from /proc/modules):
> 
> cyclades              147616  16 (autoclean)

cyclades does request_region(), but forgets to do release_region().
This will leave the region allocated in kernel data structures,
but its "name" field resides in module memory.

So if you load cyclades.o, then rmmod it, then cat /proc/ioports,
you'll touch unmapped memory and go boom.

Some brave soul needs to teach cyclades about release_region().
Shame the Nobel prizes are all gone this year.

-
