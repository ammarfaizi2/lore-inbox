Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbVI0V4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbVI0V4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVI0V4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:56:15 -0400
Received: from tierw.net.avaya.com ([198.152.13.100]:898 "EHLO
	tierw.net.avaya.com") by vger.kernel.org with ESMTP id S965178AbVI0V4O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:56:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Date: Tue, 27 Sep 2005 15:55:26 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC086EFEEB@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Thread-Index: AcXDpCegSpy0403hT62qvWtgIQiepgACLb8Q
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Daniel Jacobowitz [mailto:dan@debian.org] 
> Sent: Tuesday, September 27, 2005 2:39 PM
> To: Davda, Bhavesh P (Bhavesh)
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
> 
> On Tue, Sep 27, 2005 at 10:24:23AM -0600, Davda, Bhavesh P 
> (Bhavesh) wrote:
> > About the priority inversion and running the debugger at 
> higher priority
> > then the debuggee, that's a moot point. You're still doing too many
> > pointless context switches to the debugger only to do 
> nothing and switch
> > back to the debuggee.
> 
> Depending on your debugger, they may not be pointless.


Sorry for reiterating this, but in certain cases, yes, the context
switch to the debugger just to have it ignore the SIGCHLD for that
signal is pointless.


> > Besides, putting this responsibility (ignore SIGCHLDs for 
> signal X from
> > Task Y) in the debugger requires the debugger to have 
> information about
> > the debuggee, like Task Y is special for handling signal X, and I'm
> > going to ptrace() ignore SIGCHLD's from Task Y.
> > 
> > See where I'm going with this?
> 
> Hint: your debugger already needs to know this.  GDB already does.  It
> has a list of signals not to bother stopping or displaying to 
> the user.
> SIGCHLD is on it by default.  If not, you'd see the debugger prompt
> after each one of these context switches.
> 

That is under user control of the person using the debugger. What I was
talking about is control in the debuggee process/developer to say that I
would like to spare the unnecessary overhead of notifying the debugger
that a specific signal is being delivered to me. 

By the time GDB decides to ignore the SIGCHLD, you've already incurred
the overhead of notifying GDB and context switching into it. Then GDB,
in userspace, has to waitpid(), look at WIFSTOPPED(status),
WSTOPSIG(status) and then decide to do nothing and ptrace(PTRACE_CONT)
if the signal was one of the ignored signals. Lots of unnecessary
overhead in this case.

It is obvious to me that you and I are going to continue disagreeing
about this and arguing endlessly about this capability, so I would like
to in all modesty solicit other folks opinion about this capability
too...

Thanks

- Bhavesh

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com
