Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVBZCny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVBZCny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 21:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVBZCny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 21:43:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49024 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261177AbVBZCnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 21:43:51 -0500
Date: Fri, 25 Feb 2005 19:26:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Schwarz <schwarz@power-netz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.29: Zombies not detected or removed
Message-ID: <20050225222608.GB15251@logos.cnet>
References: <OBECJKACIGIAEGMGGKMPCEIOHJAA.schwarz@power-netz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OBECJKACIGIAEGMGGKMPCEIOHJAA.schwarz@power-netz.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 12:32:33PM +0100, Schwarz wrote:
> 
> 
> Hi everyone,
> 
> since 2.4.29 we discovered a strange behaviour.
> 
> Severall tasks are no longer detected as destroyed.
> means, these tasks have ended but arn't removed from
> the processlist.
> 
> An example from today:
> 
> [root@d102 ]# date
> Mon Feb 21 10:14:06 CET 2005
> [root@d102 ]# strace -p 33326
> attach: ptrace(PTRACE_ATTACH, ...): No such process
> [root@d102 ]# ps aux | grep 29579
> 33326    29579  0.0  0.2 10696 4332 ?        SN   10:11   0:00 -f
> /home/ajondoco
> root     19168  0.0  0.0  1768  628 pts/0    S    10:15   0:00 grep 29579
> [root@d102 ]# strace -p 33326
> attach: ptrace(PTRACE_ATTACH, ...): No such process
> [root@d102 ]#
> 
> As you can see the process in question "29579" was started
> 10:11 , but as finished its activity already. After 10
> minutes it's still not removed from the processlist and 
> it's not detected as a zombie.  
> 
> the task was an Apache 1.3.3 child over a wrapper calling php
> with -f option. 
> 
> We think it's unimportant if its forked or execev(),because on
> another maschine it was not even an apache invoked. 
> 
> Some of the these processes enter zombie state, but were never
> fully removed !
> 
> Any ideas why it and what happens?

I don't, no. Quite strange.

Can you reproduce this? If sys_ptrace() failed the process is not present. 

Can you please "cat /proc/<pid>/status" when ptrace fails but the ps shows the 
process existance ?

I suppose you haven't been seeing this behaviour with v2.4.28 ? 
