Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbVKIA6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbVKIA6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVKIA6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:58:53 -0500
Received: from tantale.fifi.org ([64.81.251.130]:42376 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S932403AbVKIA6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:58:52 -0500
To: Dick <dm@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIGALRM ignored
References: <loom.20051107T183059-826@post.gmane.org>
	<20051107160332.0efdf310.pj@sgi.com>
	<loom.20051108T124813-159@post.gmane.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 08 Nov 2005 16:58:48 -0800
In-Reply-To: <loom.20051108T124813-159@post.gmane.org>
Message-ID: <87hdamk56f.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick <dm@chello.nl> writes:

> Paul Jackson <pj <at> sgi.com> writes:
> > This is unlikely to be a Linux kernel internal development
> > issue, which is what this "linux-kernel <at> vger.kernel.org"
> > list is focused on.  
> 
> Yesterday I found the following issue:
> http://www.vttoth.com/sigalrm.htm
> 
> which is kernel related, I will try to recompile the kernel for MPENTIUM4 and
> see if it helps.

I doubt it.

> Does someone know a debugging technique to see whats happening?

First make sure that you do not inherit a signal mask where SIGALRM is
blocked, and that you do not inherit a SIG_IGN signal disposition for
SIGALRM either.

Cat /proc/pid/status and look for the SigBlk line (blocked signals)
and the SigIgn (ignored signals).  SIGALRM is 14, look for bit 14,
that is 0000000000002000.  This bit should not be set.

Phil.
