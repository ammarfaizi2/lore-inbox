Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVFUJNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVFUJNT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVFUJMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:12:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3823 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262078AbVFUJKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:10:13 -0400
Date: Tue, 21 Jun 2005 14:37:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.6.12-mm1: BUG() in fd_install, RCU related?
Message-ID: <20050621090721.GA7976@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050621083424.GA2076@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621083424.GA2076@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 10:34:24AM +0200, Pavel Machek wrote:
> Hi!
> 
> I got 
> 
> Jun 21 10:30:20 amd kernel: ------------[ cut here ]------------
> Jun 21 10:30:20 amd kernel: kernel BUG at fs/open.c:935!
> Jun 21 10:30:20 amd kernel: invalid operand: 0000 [#1]
> Jun 21 10:30:20 amd kernel: Modules linked in: ipw2100
> Jun 21 10:30:20 amd kernel: CPU:    0
> Jun 21 10:30:20 amd kernel: EIP:    0060:[page_referenced+39/160]    Not tainted VLI
> Jun 21 10:30:20 amd kernel: EFLAGS: 00010286   (2.6.12-mm1)
> Jun 21 10:30:20 amd kernel: EIP is at fd_install+0x27/0x40
> Jun 21 10:30:20 amd kernel: eax: f7268e00   ebx: 00000080   ecx: f61a9800   edx: f6106400

This has been reported by several other people.
I am looking at it except that I can't reproduce it with the config
files in one of those bug reports. Probably whatever userland triggers
this bug isn't in my lab machine. Besides I am running really old
userland anyway. I am going to find a box with  newer userland
and try.

Some things are common - always with fcntl() or fcntl64() and with
a daemon. Does your box come up at all ? If so, can you get me an
strace on the process that triggers this ? If I can narrow it
down to a small testcase, it would be a lot easier. Also, does
switching off CONFIG_PREEMPT fix this problem ?

Thanks
Dipankar
