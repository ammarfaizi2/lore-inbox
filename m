Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUGRV3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUGRV3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 17:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUGRV3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 17:29:54 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:30981 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264530AbUGRV2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 17:28:51 -0400
Date: Sun, 18 Jul 2004 23:27:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Solar Designer <solar@openwall.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
Message-ID: <20040718212721.GC1545@alpha.home.local>
References: <20040707234852.GA8297@openwall.com> <Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet> <20040718125925.GA20133@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040718125925.GA20133@openwall.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Sun, Jul 18, 2004 at 04:59:25PM +0400, Solar Designer wrote:
> On Sun, Jul 18, 2004 at 01:41:34PM +0100, Tigran Aivazian wrote:
[...]
> > # setuidapp < /proc/self/mem
> > 
> > and this program reading stdin.
> 
> The problem is the program does not know its stdin corresponds to a
> process' address space and it does not know it is making use of a
> privilege to read it.  A correctly written SUID root program may
> reasonably assume that the data it obtains from stdin is whatever the
> unprivileged user has provided, -- and, for example, display such data
> back to the user (as a part of an error message or so).  If we permit
> reads from /proc/<pid>/mem based on credentials of the read(2)-calling
> process only, this assumption would be violated resulting in security
> holes.

unless I'm mistaken, it will be the shell which will open /proc/self/mem,
so if it doesn't have correct rights, even the setuidapp will not have
access to it because the shell will not be able to open the file.

> Oh, by the way, I've just noticed that the above example is not
> entirely correct.  In order to read setuidapp's own address space
> (after the kernel has been patched according to your proposal), it
> should have been:
> 
> $ exec setuidapp < /proc/self/mem

Hmm, this is an interesting case. What exactly is passed then ? You agree
that the shell opens its own memory map on fd 0 then execs setuidapp
which will have it on stdin. But will the fd contents be automatically
replaced with the new process' memory map or will it still be the shell's
until this last reference is dropped ?

Cheers,
Willy

