Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275105AbTHLGf7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 02:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275108AbTHLGfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 02:35:55 -0400
Received: from mail7.speakeasy.net ([216.254.0.207]:54419 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S275105AbTHLGfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 02:35:47 -0400
Message-Id: <5.2.1.1.0.20030811233014.02900008@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 11 Aug 2003 23:35:26 -0700
To: Andries Brouwer <aebr@win.tue.nl>
From: Jeff Woods <kazrak+kernel@cesmail.net>
Subject: Re: [PATCH] oops in sd_shutdown
Cc: linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030812044901.A1650@pclin040.win.tue.nl>
References: <5.2.1.1.0.20030811180413.01a67dc0@no.incoming.mail>
 <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher>
 <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher>
 <20030812002844.B1353@pclin040.win.tue.nl>
 <5.2.1.1.0.20030811180413.01a67dc0@no.incoming.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At +0200 04:49 AM 8/12/2003, Andries Brouwer wrote:
>On Mon, Aug 11, 2003 at 06:13:50PM -0700, Jeff Woods wrote:
>
>>Looking only at the above code snippet, I'd suggest something more like:
>
>>+       if (!sdp ||
>
>This is not meaningful.

How is it not meaningful?  The next action in the expression is to 
dereference the pointer and if it has a NULL value then I expect the 
dereference to fail.  [But I am a complete newbie with respect to Linux 
kernel and driver code so perhaps my understanding is in error.  If so, 
please enlighten me.]

>A general kind of convention is that a pointer will be NULL either by 
>mistake, when it is uninitialized, or on purpose, when no object is 
>present or no action (other than the default) needs to be performed.

Of course.  But in this case, the next action the code will attempt is to 
dereference that pointer which I expect would fail if it's NULL.  If you're 
telling me the pointer cannot be NULL, then fine [which I tried to indicate 
was a possibility in my first email in this thread], but if the pointer 
might *ever* be NULL (and dereferencing a NULL pointer in this context is 
as bad as it usually is) then there is no point in proceeding and returning 
from the function immediately seems like a reasonable thing to do in case 
of a shutdown function.  (I can see possible value in additionally 
reporting an error or warning somehow if feasible, but that's not germane 
to whether checking the pointers for NULL is a prudent action.

>But that general idea is broken by container_of(), which just subtracts a 
>constant. So, one should check before subtracting that the pointer is 
>non-NULL. Checking afterwards is meaningless.

As I tried to indicate in the opening statement I have not looked at any 
other code than what you included in the patch diff beginning this thread 
so I don't see any reference to anything that indicates some function 
called container_of() [which sounds like it might be some C++ routine... 
and I was under the impression this code is C rather than C++].  The diff 
includes the beginning of the function including initialization of both the 
sdp and sdkp pointers.  One bug the patch fixes is the implicit dereference 
of sdkp in the original version of the "if" statement I suggest be 
modified.  My version of the patch (1) reduces the number of lines changed, 
(2) results in fewer lines, (3) improves the transparency of the code, and 
(4) additionally checks for a (perhaps unlikely or even  improbable) 
potential unanticipated runtime error, all of which makes me believe it is 
an improvement.

--
Jeff Woods <kazrak+kernel@cesmail.net> 


