Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTEKDkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 23:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTEKDkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 23:40:52 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:15753 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S262175AbTEKDkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 23:40:51 -0400
Date: Sat, 10 May 2003 23:50:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: desc v0.61 found a 2.5 kernel bug
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305102353_MC3-1-385A-BC35@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:

> The devil is in the details: you have to edit the TSS, clear the busy bit
> of the previous TSS, LTR, clear the busy bit of the debug TSS, restore
> many registers from the previous TSS image, switch to the kernel stack of
> the interrupted process, push a lot of stuff on the stack to be used by iret.
> (depending on whether you return to kernel/user/v86 modes). All of this in the 
> right order, of course (and after having cleared your own NT flag).

 And this is the way to do it right, but...

> Doable I believe but not simple, and there is still the TS issue.

 I finally realized the TS problem is basically unsolvable.  There is no
way to know what the value was before a switch happened.


 (BTW some other Free kernel has interesting things in its descriptor
tables: DPL 1 execute-only code segments, conforming code, expand-down
data, multiple LDTs etc...  It uncovered a bug in my code, too.)
