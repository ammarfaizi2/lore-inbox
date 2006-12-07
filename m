Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163174AbWLGSuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163174AbWLGSuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163192AbWLGSuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:50:50 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:53775 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163174AbWLGSuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:50:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Csa8PTadL8Nuk0gk2SDY/OPLZvogo/VMRGzUhMuv1wRHISEMLhVPw/GhZ5ia1HC1ZQ1ULJ/5mBAWZv0UCtKPA9BiGk9/Wc7K0KMaXOrdwehRX1ARl0QSycYZDDO6LUb+SBU1m7dJ0qfc+GYJWX8RSmJc+005tZtVEWWyeLry9Og=
Message-ID: <9a8748490612071050q60b378c4ldf039140ffd721be@mail.gmail.com>
Date: Thu, 7 Dec 2006 19:50:49 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: additional oom-killer tuneable worth submitting?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45785DDD.3000503@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45785DDD.3000503@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few questions below.

On 07/12/06, Chris Friesen <cfriesen@nortel.com> wrote:
>
> The kernel currently has a way to adjust the oom-killer score via
> /proc/<pid>/oomadj.
>
> However, to adjust this effectively requires knowledge of the scores of
> all the other processes on the system.
>
> I'd like to float an idea (which we've implemented and been using for
> some time) where the semantics are slightly different:
>
> We add a new "oom_thresh" member to the task struct.
> We introduce a new proc entry "/proc/<pid>/oomthresh" to control it.
>

How does "oomthresh" and "oomadj" affect each other?


> The "oom-thresh" value maps to the max expected memory consumption for
> that process.  As long as a process uses less memory than the specified
> threshold, then it is immune to the oom-killer.
>

Default "oomthresh" value for a new process is 0 (zero) I assume -
right?  If not, then I'd suggest that it should be.

What happens when a process fork()s? Does the child enherit the
parents "oomthresh" value?

Would it make sense to make "oomthresh" apply to process groups
instead of processes?


> On an embedded platform this allows the designer to engineer the system
> and protect critical apps based on their expected memory consumption.
> If one of those apps goes crazy and starts chewing additional memory
> then it becomes vulnerable to the oom killer while the other apps remain
> protected.
>

What happens in the case where the OOM killer really, really needs to
kill one or more processes since there is not a single drop of memory
available, but all processes are below their configured thresholds?


> If a patch for the above feature was submitted, would there be any
> chance of getting it included?  Maybe controlled by a config option?

Impossible to know without posting the patch for review :)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
