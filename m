Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbUKCUMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUKCUMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbUKCUMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:12:54 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:13562 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261844AbUKCUKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:10:16 -0500
Date: Wed, 3 Nov 2004 12:09:30 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2)
Message-ID: <20041103200930.GA10669@taniwha.stupidest.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <1099482457.16445.1.camel@imp.csi.cam.ac.uk> <20041103120829.GA23182@taniwha.stupidest.org> <200411032028.44376.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411032028.44376.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 08:28:44PM +0100, Blaisorblade wrote:

> I'm going to test this.

please do

> I thought that Gerd Knorr patch (which I sent cc'ing LKML and most
> of you) already solved this (I actually modified that one, replacing
> his SIGCONT kill()ing with a PTRACE_KILL, but I did this in the
> places he identified).

it might, i'm going to check soon

what worries me is that two very different code paths might be fixing
the same problem which makes me think the flow of execution here is
very vague and needs cleaninng up

also, check your return values for errors --- i bet you will see
some.  os_kill_process has this problem too --- many invocations of it
are pointless and fail, especially those from relase_thread_tt (i need
to check the details here, this is all from memory and im getting old)

> I guess that old_pid should either already be dead there or going to
> die after a little, but I'm going to check (after I get UML to run
> in the current snapshot...)

it should build pretty close to as-is, if not let me know and i'll
sent you what i have
