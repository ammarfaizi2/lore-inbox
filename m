Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVI1TMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVI1TMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVI1TMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:12:05 -0400
Received: from tierw.net.avaya.com ([198.152.13.100]:61885 "EHLO
	tierw.net.avaya.com") by vger.kernel.org with ESMTP
	id S1750730AbVI1TME convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:12:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Date: Wed, 28 Sep 2005 13:11:22 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC086F0379@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Thread-Index: AcXEWz3oLb6T2kn1TGeuC5snd2vA+wAAa6FA
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Okay, I'll come up with an alternative patch that enhances 
> the ptrace
> > interface so the debugger can guide the kernel to NOT 
> context switch and
> > bother it about signal x from task y.
> > 
> > Would you be amenable to such a patch?
> 
> Yes, definitely.  I just hadn't found a chance to think about what the
> interface should look like.
> 
> [For the record, I'm pretty sure that the Solaris procfs debug
> interface offers a similar feature.]
> 
> -- 
> Daniel Jacobowitz
> CodeSourcery, LLC
> 


How about 2 new PTRACE requests: PTRACE_SET_SIGIGN_MASK,
PTRACE_GET_SIGIGN_MASK

Both taking a "sigset_t *mask" as a parameter? The mask would be filled
by the debugger as usual using sigemptyset(), sigfillset(), sigaddset(),
etc.

Of course, the implementation would do error checking for legal values
of signals to mask, etc.

And this might require augmenting task_struct {} to store this mask,
kind of like last_siginfo which is already used by the
PTRACE_SETSIGINFO/PTRACE_GETSIGINFO ptrace requests.

- Bhavesh


Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com
