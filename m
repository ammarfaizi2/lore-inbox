Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270935AbUJUU0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270935AbUJUU0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270829AbUJUUWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:22:39 -0400
Received: from code.and.org ([63.113.167.33]:48530 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S270809AbUJUUOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:14:51 -0400
To: jmoyer@redhat.com
Cc: Alexandre Oliva <aoliva@redhat.com>, Ingo Molnar <mingo@redhat.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
From: James Antill <james.antill@redhat.com>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	<20041005112752.GA21094@logos.cnet>
	<16739.61314.102521.128577@segfault.boston.redhat.com>
	<20041006120158.GA8024@logos.cnet>
	<1097119895.4339.12.camel@orbit.scot.redhat.com>
	<20041007101213.GC10234@logos.cnet>
	<1097519553.2128.115.camel@sisko.scot.redhat.com>
	<16746.55283.192591.718383@segfault.boston.redhat.com>
	<1097531370.2128.356.camel@sisko.scot.redhat.com>
	<16749.15133.627859.786023@segfault.boston.redhat.com>
	<16751.61561.156429.120130@segfault.boston.redhat.com>
	<orzn2lpyfc.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0410170715240.16806@devserv.devel.redhat.com>
	<orvfd9yw1m.fsf@livre.redhat.lsd.ic.unicamp.br>
	<16755.62608.19034.491032@segfault.boston.redhat.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 21 Oct 2004 16:14:43 -0400
In-Reply-To: <16755.62608.19034.491032@segfault.boston.redhat.com> (Jeff
 Moyer's message of "Mon, 18 Oct 2004 12:51:28 -0400")
Message-ID: <m3k6tjakwc.fsf@code.and.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> writes:

> Select, pselect, and poll will always return data ready on a regular file.
> As such, I would argue that squid's behaviour is broken.

 I would argue that this isn't true. Yes, poll() would always return
ready, but read would always "block" when you called it on the
files. And using the same method you use for network IO saves having
to have a separate path through the event loop just for reading files
from disk.
 For another view of the argument, see:

http://www.and.org/vstr/examples/ex_cat.c.html

...this does non-blocking IO from stdin to stdout. You seem to be
arguing that it should have to know when stdin is from a pipe and when
it is a redirected file.

> I am in favor of kicking off I/O for reads that would block.

 This would solve the problem, but I'd still argue that poll()
shouldn't lie ... having the event loop do the right thing when the
disk is busy or the file is on a down NFS server would be a huge free
win.

-- 
James Antill                               e: <james.antill@redhat.com>
Red Hat Support Engineering Group
