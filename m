Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVBXTxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVBXTxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVBXTxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:53:08 -0500
Received: from orb.pobox.com ([207.8.226.5]:25033 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262460AbVBXTxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:53:04 -0500
Date: Thu, 24 Feb 2005 11:52:54 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Chad N. Tindel" <chad@tindel.net>
Cc: Paulo Marques <pmarques@grupopie.com>, Chris Friesen <cfriesen@nortel.com>,
       Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224195254.GE7524@ip68-4-98-123.oc.oc.cox.net>
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com> <421E2528.8060305@grupopie.com> <20050224192237.GA31894@calma.pair.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224192237.GA31894@calma.pair.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is much, much better than the "users are stupid, we must protect 
> > them from themselves" kind of way that other OS'es use.
> 
> Isn't this what the kernel attempts to do in many other places?  What else
> could possibly be the point of sending SIGSEGV and causing applications
> to dump core when they make a mistake referencing memory?  Isn't it the
> kernel's job to protect one application from another? 

A related example: Typically, when a program (even when running as
root) attempts to access I/O ports directly, it gets killed as you
describe. However, the X server, running as root, can use ioperm or iopl
to request permission to access the video card's I/O ports directly. When
it gets that permission, it can do that and no longer gets killed. It
also means the X server is capable of bringing the entire system via
errant I/O port accesses if it wishes (or if it misbehaves).

The general philosophy is to protect one application from another,
unless an application has been specifically granted sufficient power
to wreck the system.


I don't remember off the top of my head whether SCHED_FIFO tasks are
supposed to be able to take SMP systems down, if the # of SCHED_FIFO
tasks is less than the # of CPU's. I imagine someone has thought about
this in the past and answered the question one way or another, but I
don't happen to know the answer.

-Barry K. Nathan <barryn@pobox.com>
