Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVI0Qiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVI0Qiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVI0Qiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:38:55 -0400
Received: from tierw.net.avaya.com ([198.152.13.100]:44029 "EHLO
	tierw.net.avaya.com") by vger.kernel.org with ESMTP id S965003AbVI0Qiy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:38:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Date: Tue, 27 Sep 2005 10:24:23 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC086EFBEB@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Thread-Index: AcXDfHSDezXjog24QIy5xVH9CqLpkQAAlAzA
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, this is far from the only problem you're going to have 
> if you run
> your debugger with lower priority than your debuggee.

About the priority inversion and running the debugger at higher priority
then the debuggee, that's a moot point. You're still doing too many
pointless context switches to the debugger only to do nothing and switch
back to the debuggee.


> > 
> > IMHO this is a perfectly safe capability...
> 
> No.  Ptrace is considered a security barrier; the tracee should not be
> able to control what the tracer sees.
> 

Since when did ptrace become a security barrier? If security is the only
concern, then we can always add a capability check to only allow root to
set SA_NOPRNOTIF on sigaction() for a particular signal.

Besides, putting this responsibility (ignore SIGCHLDs for signal X from
Task Y) in the debugger requires the debugger to have information about
the debuggee, like Task Y is special for handling signal X, and I'm
going to ptrace() ignore SIGCHLD's from Task Y.

See where I'm going with this?

That's why I specifically put the responsibility on the debuggee to say:
I know what I'm doing and I don't want the debugger to be notified about
this specific signal.


- Bhavesh


Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com

