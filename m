Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTF3Nac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 09:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTF3Nac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 09:30:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15373 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263761AbTF3Nab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 09:30:31 -0400
Date: Mon, 30 Jun 2003 09:37:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mike Galbraith <efault@gmx.de>
cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
In-Reply-To: <5.2.0.9.2.20030628064029.00cfa800@pop.gmx.net>
Message-ID: <Pine.LNX.3.96.1030630093316.5710A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jun 2003, Mike Galbraith wrote:

> At 11:51 PM 6/27/2003 -0400, Bill Davidsen wrote:
> >Why do it at wakeup. Is it easier to just decide at the time of the
> >processes blocking to decisde there if it is blocking on an interactive
> >transaction? Is it that easy or is it really necessary to make the process
> >perfect?
> 
> I'm no clean freak, but fiddling with scheduling information all over the 
> place seems like a very bad idea. (before anyone says it, yes, we fiddle 
> with state all over the place;)  I can imagine doing something dirty in 
> driver code for specific cases (kdb/mouse are always interactivity 
> indicators), but not in generic code.
> 
> Besides, the logical bindings for foo | bar | ... | baz do not exist in the 
> kernel.  The kernel knows and cares only that single entities are using 
> open/read/write/close primitives.  This is why I said I could _imagine_ a 
> process struct... as the container for this missing (it lives in userland) 
> information.
> 
> Another besides:  it makes zero difference it you add overhead to wakeup 
> time or go to sleep time.  If it's something you do a lot of, adding 
> overhead to it is going to hurt a lot.

True, but at block time you have more information. If a process blocks on
pipe read, presumably it's in the pipe read code that the process is
blocked, and that code is not common to disk read, keyboard read, socket
read, etc. Atleast not all of it is...

If you try to do something at unblock, you have to determine why the
process blocked. But if you do it at block time you have that information.
Therefore you should have a lot less overhead to add, which is why I think
it's a win over finding "what happened?" at unblock.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

