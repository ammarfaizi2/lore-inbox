Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTIAFAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 01:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTIAFAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 01:00:18 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:12443
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262575AbTIAFAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 01:00:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Robert Love <rml@tech9.net>, Ian Kumlien <pomac@vapor.com>
Subject: Re: [SHED] Questions.
Date: Mon, 1 Sep 2003 15:07:45 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <1062324435.9959.56.camel@big.pomac.com> <1062374409.5171.194.camel@big.pomac.com> <1062389038.1313.39.camel@boobies.awol.org>
In-Reply-To: <1062389038.1313.39.camel@boobies.awol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309011507.45314.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003 14:03, Robert Love wrote:
> Look at it like this.  Assume we have:
>
> 	Task A, B, and C at priority 10 (the highest)
> 	Task D at priority 5
> 	Tasks E and F at priority 0 (the lowest)
>
> We run them in that order: A, B, C, D, E, then F.  And repeat.
> (Actually, within a given priority, the tasks are run round-robin in any
> nonspecific order.. effectively first-come, first-served scheduling).
>
> If [any task] has exhausted its timeslice, it will not run until the
> remaining tasks exhaust their timeslice.  Once all tasks have expired,
> we start over.

I hate to keep butting in and saying this but this is not quite what happens. 
If a task is considered interactive (a priority boost of 2 or more) and it 
uses up a full timeslice then it is checked to see if a starvation limit has 
been exceeded by the tasks on the expired array. If it hasn't exceeded the 
limit, the interactive task will be rescheduled again ahead of everything 
else. ie if A is the only task still considered interactive after using up 
it's timeslice the first time it will go

A,B,C,A 
before anything else

and if nothing else is interactive it can even go
A,B,C,A,A,A
etc until A is not considered interactive (boost lost) or the starvation limit 
is exceeded.

This is not just with my patches; this is Ingo's design.

Con

