Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031933AbWLGJ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031933AbWLGJ7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031931AbWLGJ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:59:15 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:37788 "EHLO jdi.jdi-ict.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031933AbWLGJ7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:59:14 -0500
Date: Thu, 7 Dec 2006 10:58:45 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, npiggin@suse.de, erich <erich@areca.com.tw>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <20061206074008.2f308b2b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0612070940590.28683@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
 <20061130212248.1b49bd32.akpm@osdl.org> <Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl> <20061206074008.2f308b2b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Thu, 07 Dec 2006 10:58:46 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I thought it was, but from my look through yout 8-billion-task backtrace,
> no task was stuck in D-state with the appropriate call trace.

I was afraid of that... Where is the lock on the i_mutex suppose 
to be released ? I can't grasp the codepath from within an interrupt back 
to the fs layer.
 
> So I don't know what's causing this.  In the first trace you have at least
> four D-state kjournalds and a lot of processes stuck on an i_mutex.  I
> guess it's consistent with an IO system which is losing completion
> interrupts.  AFAICT in the second trace all you have is a lot of processes
> stuck on i_mutex for no obvious reason - I don't know why that would
> happen.

Is there any way to see if it is missing interrupts ? Enabling the 
debugging in the areca driver isn't a good idea on this machine, it's a
heavely IO loaded machine, and the problem seems to take some time to occur.

I *does* happen less often with a 2.6.19 kernel however. 

The task dump takes > 10 seconds, which causes the softlock detector to 
trigger. Is there any objection to a patch which disables the lockup 
detector during the dump ? It isn't a big issue, since al it does is dump 
a stacktrace.

I've enabled most debugging now, I'll see of i can run both a disk and VM 
stresstest.

I'll put a .config and a dmesg of the machine booting at 
http://www.jdi-ict.nl/plain/ for those who want to look at it.


Regards,


	Igmar
