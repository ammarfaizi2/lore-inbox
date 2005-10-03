Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVJCPyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVJCPyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVJCPyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:54:02 -0400
Received: from tiere.net.avaya.com ([198.152.12.100]:3513 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S932311AbVJCPyA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:54:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Date: Mon, 3 Oct 2005 09:21:00 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC0874921D@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Thread-Index: AcXHsTnUpYqU2fehT460YLtee0E1twAfDxkw
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, the only problem with this is that it requires consensus on the
> format of kernel sigsets.  Think about the 32-vs-64-bit compatibility
> issues.
> 
> It should be cleared on PTRACE_DETACH, of course.  Do we even need the
> GET functionality?  If not, is PTRACE_SET_IGNORE_SIGNAL 
> taking a single
> signal number sufficient?

Thanks for reminding me about handling PTRACE_DETACH!

Yeah, we could go with PTRACE_SET_IGNORE_SIGNAL (signum), but we'll
still need a sigset_t like structure in struct task_struct {}. I figured
the PTRACE_SET_SIGIGN_MASK interface would be more flexible and
efficient if someone wanted to have the debugger ignore a whole bunch of
signals at once for a debuggee child.

But I agree, the GET interface is perhaps not required.

Okay, I'll whip out a preliminary patch, and you can all rip it apart if
you find issues with it. Stay tuned...

Thanks for your comments, Daniel!

- Bhavesh



Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com
