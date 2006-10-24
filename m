Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWJXMzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWJXMzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWJXMzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:55:38 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:56979 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161053AbWJXMzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:55:38 -0400
Date: Tue, 24 Oct 2006 08:54:42 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: John Levon <levon@movementarian.org>
cc: Mike Kravetz <kravetz@us.ibm.com>, phil.el@wanadoo.fr,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net
Subject: Re: oprofile can cause an NMI to schedule (was: [RT] scheduling and
 oprofile)
In-Reply-To: <20061024124650.GA2668@totally.trollied.org>
Message-ID: <Pine.LNX.4.58.0610240852450.949@gandalf.stny.rr.com>
References: <20061023212307.GA21498@monkey.beaverton.ibm.com>
 <1161656674.13276.17.camel@localhost.localdomain> <20061024124650.GA2668@totally.trollied.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Oct 2006, John Levon wrote:

> On Mon, Oct 23, 2006 at 10:24:34PM -0400, Steven Rostedt wrote:
>
>
> in_atomic() is supposed to be true in this context, so the test in
> do_page_fault() catches it.
>


	/*
	 * If we're in an interrupt, have no user context or are running in an
	 * atomic region then we must not take the fault..
	 */
	if (in_atomic() || !mm)
		goto bad_area_nosemaphore;


Ahh, missed that one.  So this is an issue that _only_ rt needs to fix.
OK, thanks for pointing that out.

-- Steve

