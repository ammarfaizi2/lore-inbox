Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUAaVwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 16:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUAaVwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 16:52:51 -0500
Received: from mail3.speakeasy.net ([216.254.0.203]:10941 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S265118AbUAaVwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 16:52:50 -0500
Date: Sat, 31 Jan 2004 13:52:43 -0800
Message-Id: <200401312152.i0VLqh6W024564@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "Matthias Urlichs" <smurf@smurf.noris.de>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org, molnar@elte.hu,
       phil-list@redhat.com
Subject: Re: BUG: NTPL: waitpid() doesn't return?
In-Reply-To: Matthias Urlichs's message of  Saturday, 31 January 2004 21:49:14 +0100 <20040131204914.GB2160@kiste>
X-Shopping-List: (1) Puddle-Off! Distracted suspenders
   (2) Dangerous breeze infestations
   (3) Inelegant onions
   (4) Amorphous garrulous congestion
   (5) Vacuous organs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your test program works... except that it reports, when I strace it,
> 
> [pid 10629] waitpid(10631, Process 10629 suspended
>  <unfinished ...>
> [pid 10628] <... mmap2 resumed> )       = 0x41966000
> [pid 10630] waitpid(10632, Process 10630 suspended
> <unfinished ...>
> 
> Those "Process ### suspended" messages did NOT happen with the Python
> script that exhibits the bug.

This is an strace bug.  Because of goofy ptrace interactions, strace does
funny business with threads doing wait calls.  strace should resume those
threads when the pids they are waiting for exit.  

Make sure you are using the most current strace and if it's still not
different then report the strace bug (<strace-devel@lists.sourceforge.net>
or https://bugzilla.redhat.com are fine).
  
To research the issue thoroughly, you may have to avoid relying on strace
to tell you what calls your programs make.
