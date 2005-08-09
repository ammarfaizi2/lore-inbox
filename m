Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVHITdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVHITdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVHITdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:33:13 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:5079 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932224AbVHITdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:33:12 -0400
Subject: Re: Signal handling possibly wrong
From: Steven Rostedt <rostedt@goodmis.org>
To: Robert Wilkens <robw@optonline.net>
Cc: linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
In-Reply-To: <1123614253.3167.18.camel@localhost.localdomain>
References: <42F8EB66.8020002@fujitsu-siemens.com>
	 <1123612016.3167.3.camel@localhost.localdomain>
	 <42F8F6CC.7090709@fujitsu-siemens.com>
	 <1123612789.3167.9.camel@localhost.localdomain>
	 <42F8F98B.3080908@fujitsu-siemens.com>
	 <1123614253.3167.18.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 15:33:03 -0400
Message-Id: <1123615983.18332.194.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 15:04 -0400, Robert Wilkens wrote:
> [resent - previous message not properly addressed]
> 
> It says "signal is blocked, UNLESS SA_NODEFER is used.."
> 
> Which means if NODEFER is used, it's not masked (SA_NOMASK)..
> 

I believe I understand what Bodo is saying.  The man pages seem to imply
that the NODEFER only affects the signal being sent. Where as, in the
kernel, the NODEFER flag affects all signals in the sa_mask.

Let's look at the man pages again:

       sa_mask gives a mask of signals which should be blocked  during  execu-
       tion  of  the  signal handler.  In addition, the signal which triggered
       the handler will be blocked, unless the SA_NODEFER flag is used.

The "In addition" is what makes this look like the kernel is wrong. So
the man pages says that the sa_mask is the mask of signals that should
be blocked during exection of the signal handle (regardless) of the
SA_NODEFER.  It doesn't imply that the sa_mask would only work if the
SA_NODEFER was not set.  The SA_NODEFER seems to imply here that, if
set, the signal that is running could be called again.

It also seems to imply the other way around. That is, that the signal
that is running would be blocked regardless of the sa_mask, and only
would not be blocked if the SA_NODEFER is set.

To me, the man pages make more sense, and I think the kernel is wrong.

> I don't understand how i'm wrong (maybe I have mental problems that are
> worse than I thought).  If you want to explain off-list or on-list
> (depending on whether others are getting annoyed at me) you can.  Or
> just ignore me and i'll go away and someone else who wants to look at it
> can.

Don't take this off list, since I'm sure there are others here that can
add valid input.

-- Steve

