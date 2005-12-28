Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVL1HZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVL1HZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 02:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVL1HZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 02:25:33 -0500
Received: from main.gmane.org ([80.91.229.2]:10689 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932488AbVL1HZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 02:25:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [vma list corruption] Re: proc_pid_readlink oopses again on 2.6.14.5
Date: Tue, 27 Dec 2005 23:24:10 -0800
Message-ID: <43B23D9A.3020106@triplehelix.org>
References: <dot96e$e76$1@sea.gmane.org> <20051228065354.GE27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-211-242.dsl.pltn13.pacbell.net
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
In-Reply-To: <20051228065354.GE27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> Until the last line it made sense.  Code, however, is flat-out BS.
> This chunk is from around proc_exe_link(), all right.  But it starts
> at 3 bytes before the beginning of that function.  Perfect match to
> build with your .config using gcc4, but...  no way in hell you would
> get an oops at that location - it's in the middle of long chunk of
> NOP.  So something's rotten here...

Do you think it might be a subtle compiler problem, and if I compiled it
with GCC 3.3 it might go away?

I'm willing to help diagnose this problem, but this is a production box
I'm messing with, and I don't want to reboot it more than a few times,
so I want to make those tries count with advice from folks like you :)

What do you think about the oopses in my previous post?
http://www.ussg.iu.edu/hypermail/linux/kernel/0512.0/0199.html
These were triggered (well, I'm not sure how the first one came about)
by running 'pidof pppd' - again in /proc/*/ walking procedures.

> So you've got 0xb7c1fc20 as vma.  Which is not good, since that's a userland
> address.  The next question is where it'd come from - it might be
> 	* fscked task->mm
> 	* fscked mm->mmap
> 	* fscked vma somewhere in the chain.

Note that 2.6.12 is running peachy on the machine right now, so it's not
a hardware problem.

> Doing lsof will walk vma chains of many processes, so if something is
> corrupted it will step into that...

Understood. In this particular case, it seems to have been apache2's
process (3399)..

Thanks for your diagnosis thus far.

-- 
Joshua Kwan

